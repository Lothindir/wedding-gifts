import { ref } from 'vue'
import { defineStore } from 'pinia'
import { supabase } from '@/database/supabase'
import type { Tables } from '@/database/database.types'

export const useGiftsStore = defineStore('gifts', () => {
  const gifts = ref<Tables<'gifts'>[]>([])
  const giftsTranslations = ref<Tables<'gifts_visible'>[]>([])

  async function loadGifts() {
    const { data, error } = await supabase.from('gifts').select('*').eq('hidden', false)

    if (error) {
      console.error('Error loading gifts:', error)
      return
    }

    gifts.value = data
  }

  async function loadGiftsTranslations(lang: string) {
    console.log('loadGiftsTranslations', lang)

    const { data, error } = await supabase.from('gifts_visible').select('*').eq('language', lang)
    console.log('loadGiftsTranslations', data, error)
    if (error) {
      console.error('Error loading gifts translations:', error)
      return
    }

    giftsTranslations.value = data
  }

  function getGiftById(id: number): Tables<'gifts_visible'> | undefined {
    const gift = giftsTranslations.value.find((gift) => gift.id === id)
    return gift
  }

  return {
    gifts,
    giftsTranslations,
    loadGifts,
    loadGiftsTranslations,
    getGiftById,
  }
})
