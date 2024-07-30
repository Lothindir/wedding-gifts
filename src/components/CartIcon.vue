<template>
  <RouterLink
    to="/checkout"
    class="relative flex w-10 h-10 my-auto hover:cursor-pointer"
    v-if="cartStore.cartCount > 0"
  >
    <ShoppingCartIcon aria-hidden="true" />
    <span
      class="absolute bottom-1 right-1 text-sm font-medium bg-teal-400 text-gray-700 rounded-full h-5 w-5 text-center"
      >{{ cartStore.cartCount }}</span
    >
  </RouterLink>
</template>

<script setup lang="ts">
import { ShoppingCartIcon } from '@heroicons/vue/24/solid'
import { useCartStore } from '@/stores/cart'

const cartStore = useCartStore()
</script>
