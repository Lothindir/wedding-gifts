import { RouterView, createRouter, createWebHistory } from 'vue-router'
import GiftsView from '@/views/GiftsView.vue'
import { i18n } from '@/utils/i18n'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'gifts',
      component: GiftsView,
    },
    {
      path: '/:lang([a-z]{2})',
      component: GiftsView,
      beforeEnter: (to) => {
        const localeArray = i18n.global.availableLocales.map((l) => l.split('-')[0])
        const futureLocale = to.params.lang.toString()

        if (!localeArray.includes(futureLocale)) {
          // i18n.global.locale.value = i18n.global.fallbackLocale.value
          router.push({ name: 'not-found', params: { pathMatch: 'unknown locale' } })
        } else {
          const localeId = localeArray.findIndex((l) => l == futureLocale)
          i18n.global.locale.value = i18n.global.availableLocales[localeId]
          router.push('/')
        }
      },
    },
    {
      path: '/admin',
      name: 'admin',
      component: () => import('@/views/AdminView.vue'),
    },
    {
      path: '/admin/gifts',
      name: 'admin-gifts',
      component: () => import('@/views/admin/AdminGiftsView.vue'),
    },
    {
      path: '/admin/gifts/:id',
      name: 'admin-edit-gift',
      component: () => import('@/views/admin/AdminEditGiftView.vue'),
      props: true,
    },
    {
      path: '/admin/gifts/add',
      name: 'admin-add-gift',
      component: () => import('@/views/admin/AdminAddGiftView.vue'),
    },
    {
      path: '/:pathMatch(.*)*',
      name: 'not-found',
      component: () => import('@/views/errors/NotFound.vue'),
    },
  ],
})

export default router
