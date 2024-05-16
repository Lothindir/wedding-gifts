<template>
  <div class="mt-4 flex justify-between">
    <div>
      <p class="text-sm font-medium text-gray-700">Total</p>
      <p class="text-sm font-medium text-gray-700">Remaining</p>
    </div>
    <div>
      <p class="text-sm font-medium text-gray-700">{{ totalPrice }}CHF</p>
      <p class="text-sm italic font-medium text-gray-500">{{ remainingPrice }}CHF</p>
    </div>
  </div>
</template>

<script setup lang="ts">
defineProps<{
  totalPrice: number
  remainingPrice: number
}>()
</script>

<style></style>
