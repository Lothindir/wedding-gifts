import { createI18n } from 'vue-i18n'
import frCH from './locales/fr-CH.json'
import deCH from './locales/de-CH.json'
import itCH from './locales/it-CH.json'

// Type-define 'en-US' as the master schema for the resource
type MessageSchema = typeof frCH

export const i18n = createI18n<[MessageSchema], 'fr-CH' /*| 'de-CH'*/ | 'it-CH'>({
  legacy: false,
  locale: 'fr-CH',
  messages: {
    'fr-CH': frCH,
    //'de-CH': deCH,
    'it-CH': itCH,
  },
})
