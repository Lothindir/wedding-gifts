<template>
  <div>
    <div class="mt-4 flex justify-between" v-if="isGiftable">
      <div class="flex flex-col grow justify-center">
        <p class="text-sm font-medium text-center text-gray-700">
          {{ totalParts }}x
          <span class="font-bold">{{ partPrice }} {{ settingsStore.currency }}</span>
        </p>
        <p class="text-sm font-medium italic text-center text-gray-500">
          {{ totalPrice }} {{ settingsStore.currency }}
        </p>
      </div>
      <div class="border-r border-gray-300"></div>
      <div class="flex flex-col grow justify-items-center">
        <p class="text-md font-medium font-bold text-center text-teal-700">{{ remainingParts }}</p>
        <p class="text-sm font-medium text-center text-gray-700">
          {{ t('gift.part', remainingParts) }}
        </p>
      </div>
    </div>
    <hr class="mt-4 bg-black border-1" v-if="isGiftable" />
    <div class="flex justify-center">
      <ContributeButton :active="isGiftable" @contribute="$emit('contribute')" v-if="props.giftable" />
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { useI18n } from 'vue-i18n'
import { useSettingsStore } from '@/stores/settings'
import ContributeButton from '@/components/ContributeButton.vue'

const props = defineProps<{
  totalParts: number
  giftedParts: number | null
  partPrice: number
  giftable: boolean
}>()

const totalPrice = computed(() => props.totalParts * props.partPrice)
const { t } = useI18n()
const settingsStore = useSettingsStore()

const remainingParts = computed(() => {
  if (!props.giftedParts) {
    return props.totalParts
  }
  return props.totalParts - props.giftedParts
})
const isGiftable = computed(() => remainingParts.value > 0)
</script>

<style></style>
