import { createRouter, createWebHistory } from 'vue-router'
import GiftsView from '@/views/GiftsView.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'gifts',
      component: GiftsView
    }
  ]
})

export default router
