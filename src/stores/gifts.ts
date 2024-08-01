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

    gifts.value = data.sort((a, b) => a.id - b.id)
  }

  async function updateGift(id: number) {
    const { data, error } = await supabase
      .from('gifts')
      .select('*')
      .eq('id', id)
      .eq('hidden', false)
      .single()

    if (error) {
      console.error('Error updating gift(', id, '):', error)
      return
    }

    const giftIndex = gifts.value.findIndex((g) => g.id == id)
    gifts.value[giftIndex] = data
  }

  async function loadGiftsTranslations(lang: string) {
    const { data, error } = await supabase.from('gifts_visible').select('*').eq('language', lang)
    if (error) {
      console.error('Error loading gifts translations:', error)
      return
    }

    giftsTranslations.value = data.sort((a, b) => {
      if (a.price === 0) return -1
      if (b.price === 0) return 1
      return a.title.localeCompare(b.title)
    })
  }

  function getGiftById(id: number): Tables<'gifts_visible'> | undefined {
    const gift = giftsTranslations.value.find((gift) => gift.id === id)
    return gift
  }

  return {
    gifts,
    giftsTranslations,
    loadGifts,
    updateGift,
    loadGiftsTranslations,
    getGiftById,
  }
})
