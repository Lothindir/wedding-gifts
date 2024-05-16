<template>
  <div class="mt-4 flex justify-between">
    <div class="flex flex-col grow justify-center">
      <p class="text-sm font-medium text-center text-gray-700">
        {{ totalParts }}x <span class="font-bold">{{ partPrice }}CHF</span>
      </p>
      <p class="text-sm font-medium italic text-center text-gray-500">{{ totalPrice }}CHF</p>
    </div>
    <div class="border-r border-gray-500"></div>
    <div class="flex flex-col grow justify-items-center">
      <p class="text-md font-medium font-bold text-center text-teal-700">{{ remainingParts }}</p>
      <p class="text-sm font-medium text-center text-gray-700">{{ partsRemainingMessage }}</p>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue'

const props = defineProps<{
  totalParts: number
  remainingParts: number
  partPrice: number
}>()

const totalPrice = computed(() => props.totalParts * props.partPrice)

const partsRemainingMessage = computed(() => {
  return props.remainingParts > 1 ? 'parts' : 'part'
})
</script>

<style></style>
