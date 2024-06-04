<template>
  <GiftForm v-model:gift="gift" v-model:languages="languages" @save="addGift" @cancel="router.push('/admin/gifts')" />
</template>

<script setup lang="ts">
import { useToast } from 'vue-toast-notification'
import { useRouter } from 'vue-router'
import { supabase } from '@/database/supabase'
import { ref } from 'vue'
import { useSettingsStore } from '@/stores/settings'
import GiftForm from '@/components/GiftForm.vue'

import type { TablesInsert } from '@/database/database.types'

const gift = ref<TablesInsert<'gifts'>>({
  id: 0,
  hidden: false,
  image: '',
  parts: 0,
  price: 0
})
const languages = ref<TablesInsert<'gift_translations'>[]>([])
const toast = useToast()
const router = useRouter()

async function addGift() {
  delete gift.value.id // Otherwise it's always 0
  const { data, error } = await supabase.from('gifts').insert(gift.value).select().single()
  if (error) {
    toast.error('Error adding gift')
    console.error(error)
  } else {
    for (const l of languages.value) {
      delete l.id
      if (!l.title) continue
      l.gift = data.id
      await supabase.from('gift_translations').insert(l)
    }
    toast.success('Gift added')
    router.push('/admin/gifts')
  }
}
</script>
