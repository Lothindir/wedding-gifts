<template>
  <div>
    <div class="mt-4 flex justify-between" v-if="isGiftable && !isFreeParticipation">
      <div>
        <p class="text-sm font-medium text-gray-700">{{ t('gift.total') }}</p>
        <p class="text-sm font-medium text-gray-700">{{ t('gift.remaining') }}</p>
      </div>
      <div>
        <p class="text-sm font-medium text-gray-700">{{ totalPrice }} {{ currency }}</p>
        <p class="text-sm italic font-medium text-gray-500">{{ remainingAmount }} {{ currency }}</p>
      </div>
    </div>
    <hr class="mt-4 bg-black border-1" v-if="isGiftable && !isFreeParticipation" />
    <div class="flex justify-center bottom-0">
      <ContributeButton :active="isGiftable" @contribute="$emit('contribute')" v-if="props.giftable" />
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { useSettingsStore } from '@/stores/settings'
import { useI18n } from 'vue-i18n'
import { storeToRefs } from 'pinia'
import ContributeButton from '@/components/gifts/ContributeButton.vue'

const props = defineProps<{
  totalPrice: number
  giftedAmount: number | null
  giftable: boolean
}>()

const settingsStore = useSettingsStore()
const { t } = useI18n()
const { currency } = storeToRefs(settingsStore)

const remainingAmount = computed(() => {
  if (!props.giftedAmount) {
    return props.totalPrice
  }
  return props.totalPrice - props.giftedAmount
})
const isGiftable = computed(() => remainingAmount.value > 0 || isFreeParticipation.value)
const isFreeParticipation = computed(() => props.totalPrice === 0)
</script>
