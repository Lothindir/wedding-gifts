<template>
  <main>
    <div class="bg-gray-300 h-full w-full">
      <div class="mx-auto max-w-2xl px-4 py-4 sm:px-6 sm:py-8 lg:max-w-7xl lg:px-8">
        <h2 class="text-2xl font-bold tracking-tight text-gray-900">
          {{ t('wedding.gift_list') }}
        </h2>
        <!-- <p class="mt-2 text-sm text-gray-700">Merci de contribuer à notre lune de miel.</p> -->
        <div class="mt-6 grid grid-cols-1 gap-x-6 gap-y-10 sm:grid-cols-2 lg:grid-cols-4 xl:gap-x-8">
          <GiftItem v-for="gift in gifts" :key="gift.id" :title="gift.title" :img="gift.image" :alt="gift.title"
            :description="gift.description">
            <GiftPrice :total-price="gift.price" :gifted-amount="gift.amount_gifted" v-if="gift.parts == 0" />
            <GiftParts :total-parts="gift.parts" :gifted-parts="gift.amount_gifted" :part-price="gift.price" v-else />
          </GiftItem>
        </div>
      </div>
    </div>
  </main>
</template>

<script setup lang="ts">
import { useI18n } from 'vue-i18n'
import { supabase } from '@/database/supabase'
import { ref, onMounted, watch } from 'vue'
import type { Tables } from '@/database/database.types'

import GiftItem from '@/components/GiftItem.vue'
import GiftPrice from '@/components/GiftPrice.vue'
import GiftParts from '@/components/GiftParts.vue'

const gifts = ref<Tables<'gifts_visible'>[]>([])
const { locale, t } = useI18n()

watch(locale, async () => {
  getGifts()
})

async function getGifts() {
  const { data, error } = await supabase.from('gifts_visible').select().eq('language', locale.value)
  if (error) {
    console.error(error)
  } else {
    gifts.value = data
  }
}

onMounted(() => {
  getGifts()
})
</script>
