import { createRouter, createWebHistory } from 'vue-router'
import GiftsView from '@/views/GiftsView.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'gifts',
      component: GiftsView
    },
    {
      path: '/admin',
      name: 'admin',
      component: () => import('@/views/AdminView.vue')
    },
    {
      path: '/admin/gifts',
      name: 'admin-gifts',
      component: () => import('@/views/admin/AdminGiftsView.vue')
    }
  ]
})

export default router
