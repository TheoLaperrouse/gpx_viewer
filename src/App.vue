<template>
    <div>
        <input type="file" id="fileInput" ref="fileInput" accept=".gpx" @change="updateFileName" class="mr-2" />
        <span class="text-gray-600 w-100">{{ fileName }}</span>

        <button
            @click="loadGPX"
            class="bg-blue-500 text-white px-4 py-2 rounded-md hover:bg-blue-600 focus:outline-none focus:shadow-outline-blue active:bg-blue-800"
        >
            Charger le GPX
        </button>
        <div id="map"></div>
    </div>
</template>

<script>
import L from 'leaflet';
import 'leaflet/dist/leaflet.css';
import toGeoJSON from 'togeojson';

export default {
    data() {
        return {
            map: null,
        };
    },
    mounted() {
        this.map = L.map('map').setView([48.1173, -1.6778], 13); // Set view to Rennes, France
        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            attribution: '© OpenStreetMap contributors',
        }).addTo(this.map);
    },
    methods: {
        loadGPX() {
            const fileInput = this.$refs.fileInput;
            const file = fileInput.files[0];

            if (file) {
                const reader = new FileReader();

                reader.onload = (e) => {
                    const gpxData = e.target.result;
                    const geojson = toGeoJSON.gpx(new DOMParser().parseFromString(gpxData, 'text/xml'));
                    L.geoJSON(geojson).addTo(this.map);
                    this.map.fitBounds(L.geoJSON(geojson).getBounds());
                };

                reader.readAsText(file);
            } else {
                alert('Veuillez sélectionner un fichier GPX.');
            }
        },
    },
};
</script>

<style>
#app {
    height: 100vh;
    margin: 0;
    display: flex;
    flex-direction: column;
}

#map {
    flex: 1;
    height: 100vh;
}
</style>
