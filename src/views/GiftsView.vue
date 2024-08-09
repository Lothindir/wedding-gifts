<template>
  <main>
    <div class="bg-gray-300 h-full w-full">
      <div class="mx-auto max-w-2xl px-4 py-4 sm:px-6 sm:py-8 lg:max-w-7xl lg:px-8">
        <img :src="bannerUrl" />
        <h2 class="text-2xl font-bold tracking-tight text-gray-900">
          {{ t('wedding.gift_list') }}
        </h2>
        <p class="mt-2 text-sm py-2 text-gray-700">
          {{ t('wedding.gift_list_description') }}
          <FaceSmileIcon class="inline w-6 h-6" />
        </p>
        <div
          class="mt-6 grid grid-cols-1 gap-x-6 gap-y-10 sm:grid-cols-2 lg:grid-cols-4 xl:gap-x-8"
        >
          <GiftItem
            v-for="gift in gifts"
            :key="gift.id!"
            :title="gift.title!"
            :img="gift.image!"
            :alt="gift.title"
            :description="gift.description!"
          >
            <GiftPrice
              :total-price="gift.price!"
              :gifted-amount="gift.amount_gifted"
              v-if="gift.parts == 0"
              :giftable="true"
              @contribute="contribute(gift.id!)"
            />
            <GiftParts
              :total-parts="gift.parts!"
              :gifted-parts="gift.amount_gifted"
              :part-price="gift.price!"
              v-else
              :giftable="true"
              @contribute="contribute(gift.id!)"
            />
          </GiftItem>
        </div>

        <GiftCheckoutModal :id="giftId" v-model="openModal" />
      </div>
    </div>
  </main>
</template>

<script setup lang="ts">
import { useI18n } from 'vue-i18n'
import { ref, onMounted, watch } from 'vue'
import GiftItem from '@/components/gifts/GiftItem.vue'
import GiftPrice from '@/components/gifts/GiftPrice.vue'
import GiftParts from '@/components/gifts/GiftParts.vue'
import GiftCheckoutModal from '@/components/gifts/GiftCheckoutModal.vue'
import bannerUrl from '@/assets/images/banner.jpg'
import { FaceSmileIcon } from '@heroicons/vue/24/outline'
import { useGiftsStore } from '@/stores/gifts'
import { storeToRefs } from 'pinia'
import { useRoute } from 'vue-router'

const openModal = ref(false)
const giftId = ref<number>(-1)
const { locale, t } = useI18n()
const giftsStore = useGiftsStore()
const route = useRoute()
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
  if (route.query.lang) {
    locale.value = route.query.lang as string
    history.replaceState({}, '', '/')
  }
  gifts.value = giftsStore.giftsTranslations
})
</script>
