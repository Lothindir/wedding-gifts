import { ref } from 'vue'
import { defineStore } from 'pinia'
import { supabase } from '@/database/supabase'
import type { Tables } from '@/database/database.types'

export const useSettingsStore = defineStore('settings', () => {
  const currency = ref<string>('')
  const languages_nb = ref<number>(0)
  const languages = ref<string[]>([])
  const languages_default = ref<string>('')
  const payment_methods = ref<Tables<'payment_methods'>[]>([])
  const loaded = ref(false)

  async function loadSetting<T>(key: string, defVal: T): Promise<T> {
    const { data, error } = await supabase
      .from('settings')
      .select('value')
      .eq('key', key)
      .returns<T>()
      .single<any>()

    if (error) {
      console.error('Error loading settings:', error)
      return defVal
    }

    return data.value
  }

  async function loadSettings() {
    if (loaded.value == true) return

    currency.value = await loadSetting<string>('currency', '')
    languages_nb.value = await loadSetting<number>('languages_nb', 0)
    languages_default.value = await loadSetting<string>('languages_default', '')
    let lang_string = await loadSetting<string>('languages_string', '')
    lang_string = lang_string.replace('[', '')
    lang_string = lang_string.replace(']', '')
    lang_string = lang_string.replace(/["']/g, '')
    let langs = lang_string.split(',')
    langs = langs.map((lang_string) => lang_string.trim())

    languages.value = langs

    const { data, error } = await supabase.from('payment_methods').select()

    if (error) {
      console.error('Error loading payment methods:', error)
      payment_methods.value = [
        {
          id: 0,
          title: '',
          image: '',
          info: [''],
          info_icon: null,
        },
      ]
    } else {
      payment_methods.value = data
    }

    loaded.value = true
  }

  return {
    currency,
    languages_nb,
    languages_default,
    languages,
    payment_methods,
    loadSettings,
  }
})
