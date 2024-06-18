import './assets/main.css'

import { createApp } from 'vue'
import { createPinia } from 'pinia'
import { createHead } from '@unhead/vue'
import ToastPlugin from 'vue-toast-notification'
import { createPersistedState } from 'pinia-plugin-persistedstate'

import 'vue-toast-notification/dist/theme-default.css'

import App from './App.vue'
import router from './router'
import { i18n } from './utils/i18n'

const app = createApp(App)
const pinia = createPinia()

pinia.use(
  createPersistedState({
    storage: localStorage,
  })
)

app.use(pinia)
app.use(createHead())
app.use(i18n)
app.use(router)
app.use(ToastPlugin)

app.mount('#app')
