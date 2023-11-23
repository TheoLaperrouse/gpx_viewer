<template>
    <div v-if="visible" class="modal-overlay">
        <div class="modal">
            <div class="modal-header">
                <h2>Sélectionner un fichier GPX</h2>
                <button @click="closeModal" class="modal-close-btn">×</button>
            </div>
            <div class="modal-body">
                <input type="file" id="fileInput" ref="fileInput" accept=".gpx" @change="updateFileName" />
                <div class="flex items-center mt-4">
                    <span class="text-gray-600">{{ fileName }}</span>
                </div>
            </div>
            <div class="modal-footer">
                <button
                    @click="loadGPX"
                    class="bg-blue-500 text-white px-4 py-2 rounded-md hover:bg-blue-600 focus:outline-none focus:shadow-outline-blue active:bg-blue-800"
                >
                    Charger le GPX
                </button>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    props: {
        visible: Boolean,
    },
    data() {
        return {
            fileName: '',
        };
    },
    methods: {
        closeModal() {
            this.$emit('close');
        },
        updateFileName() {
            const fileInput = this.$refs.fileInput;
            this.fileName = fileInput.files.length > 0 ? fileInput.files[0].name : '';
        },
        loadGPX() {
            const fileInput = this.$refs.fileInput;
            const file = fileInput.files[0];

            if (file) {
                const reader = new FileReader();

                reader.onload = (e) => {
                    const gpxData = e.target.result;
                    this.$emit('load', gpxData);
                    this.closeModal();
                };

                reader.readAsText(file);
            } else {
                alert('Veuillez sélectionner un fichier GPX.');
            }
        },
    },
};
</script>

<style scoped>
.modal-overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.5);
    display: flex;
    align-items: center;
    justify-content: center;
}

.modal {
    background: #fff;
    max-width: 80%;
    max-height: 80%;
    overflow-y: auto;
    border-radius: 8px;
    padding: 20px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
}

.modal-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
}

.modal-body {
    margin-bottom: 20px;
}

.modal-footer {
    text-align: right;
}

.modal-close-btn {
    cursor: pointer;
    background: none;
    border: none;
    font-size: 18px;
    color: #333;
}
</style>
