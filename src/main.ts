import './assets/main.css'

import { createApp } from 'vue'
import { createPinia } from 'pinia'
import { createI18n } from 'vue-i18n'
import ToastPlugin from 'vue-toast-notification'

import 'vue-toast-notification/dist/theme-default.css'

import App from './App.vue'
import router from './router'
import { i18n } from './utils/i18n'

const app = createApp(App)

app.use(createPinia())
app.use(router)
app.use(i18n)
app.use(ToastPlugin)

app.mount('#app')
