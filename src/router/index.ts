import { createRouter, createWebHashHistory, RouteRecordRaw } from 'vue-router';
import App from '@/App.vue';

const routes: Array<RouteRecordRaw> = [{ path: '/', component: App }];

const router = createRouter({
    history: createWebHashHistory(),
    routes,
});

export default router;
