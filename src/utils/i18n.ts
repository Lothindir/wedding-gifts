import { createI18n } from 'vue-i18n'
// import enUS from './locales/en-US.json'
import frCH from './locales/fr-CH.json'
import itCH from './locales/it-CH.json'
// import deCH from './locales/de-CH.json'

import { nextTick } from 'vue'

// Type-define 'fr-CH' as the master schema for the resource
type MessageSchema = typeof frCH

export const i18n = createI18n<[MessageSchema], /*'en-US' | */ 'fr-CH' | 'it-CH'>({
  legacy: false,
  locale: 'fr-CH',
  fallbackLocale: 'fr-CH',
  messages: {
    //'en-US': enUS,
    'fr-CH': frCH,
    'it-CH': itCH,
  },
})

export async function loadLocaleMessages(i18n: any, locale: string) {
  // Load locale messages with dynamic import
  const messages = await import(
    /* webpackChunkName: "locale-[request]" */ `./locales/${locale}.json`
  )
  i18n.global.setLocaleMessage(locale, messages.default)
  return nextTick()
}
