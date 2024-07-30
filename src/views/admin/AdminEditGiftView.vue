<template>
  <GiftForm v-model:gift="gift" v-model:languages="languages" @save="updateGift"
    @cancel="router.push('/admin/gifts')" />
</template>

<script setup lang="ts">
import { useToast } from 'vue-toast-notification'
import { useRouter } from 'vue-router'
import { supabase } from '@/database/supabase'
import { ref, onMounted } from 'vue'
import type { Tables, TablesInsert } from '@/database/database.types'
import GiftForm from '@/components/GiftForm.vue'

const props = defineProps<{
  id: number
}>()

const gift = ref<Tables<'gifts'>>({
  hidden: false,
  id: 0,
  image: '',
  parts: 0,
  price: 0
})
const languages = ref<Tables<'gift_translations'>[]>([])

const toast = useToast()
const router = useRouter()

async function getGift() {
  const { data, error } = await supabase.from('gifts').select().eq('id', props.id).single()
  if (error) {
    console.error(error)
  } else {
    gift.value = data
    console.log(data)
  }
  getLanguages()
}

async function getLanguages() {
  const { data, error } = await supabase.from('gift_translations').select().eq('gift', props.id)
  if (error) {
    console.error(error)
  } else {
    languages.value = data
    console.log(data)
  }
}

async function updateGift() {
  if (languages.value.length === 0) {
    toast.error('Please add at least one language')
    return
  }

  const { error } = await supabase.from('gifts').update(gift.value).eq('id', props.id)

  if (error) {
    toast.error(error.message, { duration: 5000 })
  } else {
    for (const l of languages.value) {
      let language: TablesInsert<'gift_translations'> = { ...l }
      if (language.id === -1) delete language.id
      console.log('Language', language);


      const { error } = await supabase.from('gift_translations').upsert(language)
      if (error) {
        console.error(error)
        return
      } else {
        console.log('Language', l.language, 'updated')
      }
    }
    toast.success('Gift updated')
    router.push('/admin/gifts')
  }
}

onMounted(() => {
  getGift()
})
</script>
