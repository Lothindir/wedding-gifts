<template>
  <main>
    <div class="bg-gray-300 h-full w-full">
      <div class="mx-auto max-w-2xl px-4 py-4 sm:px-6 sm:py-8 lg:max-w-7xl lg:px-8">
        <img :src="bannerUrl" />
        <h2 class="text-2xl font-bold tracking-tight text-gray-900">
          {{ t('wedding.gift_list') }}
        </h2>
        <!-- <p class="mt-2 text-sm text-gray-700">Merci de contribuer à notre lune de miel.</p> -->
        <div class="mt-6 grid grid-cols-1 gap-x-6 gap-y-10 sm:grid-cols-2 lg:grid-cols-4 xl:gap-x-8">
          <GiftItem v-for="gift in gifts" :key="gift.id!" :title="gift.title!" :img="gift.image!" :alt="gift.title"
            :description="gift.description!">
            <GiftPrice :total-price="gift.price!" :gifted-amount="gift.amount_gifted" v-if="gift.parts == 0"
              :giftable="true" @contribute="contribute(gift.id!)" />
            <GiftParts :total-parts="gift.parts!" :gifted-parts="gift.amount_gifted" :part-price="gift.price!" v-else
              :giftable="true" @contribute="contribute(gift.id!)" />
          </GiftItem>
        </div>

        <GiftCheckoutModal :id=giftId v-model="openModal" />
      </div>
    </div>
  </main>
</template>

<script setup lang="ts">
import type { Tables } from '@/database/database.types'

import { useI18n } from 'vue-i18n'
import { supabase } from '@/database/supabase'
import { ref, onMounted, watch } from 'vue'
import GiftItem from '@/components/GiftItem.vue'
import GiftPrice from '@/components/GiftPrice.vue'
import GiftParts from '@/components/GiftParts.vue'
import GiftCheckoutModal from '@/components/GiftCheckoutModal.vue'
import bannerUrl from '@/assets/images/banner.jpg'
import { useGiftsStore } from '@/stores/gifts'
import { storeToRefs } from 'pinia'

// const gifts = ref<Tables<'gifts_visible'>[]>([])
const openModal = ref(false)
const giftId = ref<number>(-1)
const { locale, t } = useI18n()
const giftsStore = useGiftsStore()
const { giftsTranslations: gifts } = storeToRefs(giftsStore)

watch(locale, async () => {
  giftsStore.loadGiftsTranslations(locale.value)
  gifts.value = giftsStore.giftsTranslations
})

function contribute(id: number) {
  giftId.value = id
  openModal.value = true
}

onMounted(() => {
  gifts.value = giftsStore.giftsTranslations
})
</script>
