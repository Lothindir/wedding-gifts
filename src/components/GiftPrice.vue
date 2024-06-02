<template>
  <div class="mt-4 flex justify-between">
    <div>
      <p class="text-sm font-medium text-gray-700">{{ t('gift.total') }}</p>
      <p class="text-sm font-medium text-gray-700">{{ t('gift.remaining') }}</p>
    </div>
    <div>
      <p class="text-sm font-medium text-gray-700">{{ totalPrice }} {{ settingsStore.currency }}</p>
      <p class="text-sm italic font-medium text-gray-500">
        {{ remainingAmount }} {{ settingsStore.currency }}
      </p>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { useSettingsStore } from '@/stores/settings'
import { useI18n } from 'vue-i18n'

const props = defineProps<{
  totalPrice: number
  giftedAmount: number | null
}>()

const settingsStore = useSettingsStore()
const { t } = useI18n()

const remainingAmount = computed(() => {
  if (!props.giftedAmount) {
    return props.totalPrice
  }
  return props.totalPrice - props.giftedAmount
})
</script>

<style></style>
