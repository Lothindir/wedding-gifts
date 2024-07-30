<template>
  <div class="group relative bg-white p-4 rounded-xl flex flex-col justify-between">
    <div
      class="aspect-h-1 aspect-w-1 w-full overflow-hidden rounded-md bg-gray-200 lg:aspect-none lg:h-60"
    >
      <img :src="img" class="h-full w-full object-cover object-center lg:h-full lg:w-full" />
    </div>
    <div class="mt-4 flex justify-between">
      <div>
        <h3 class="text-sm text-gray-700">{{ title }}</h3>
        <p class="mt-1 text-sm text-justify text-gray-500">
          {{ description }}
        </p>
      </div>
    </div>
    <hr class="mt-4 bg-black border-1" />
    <slot></slot>
  </div>
</template>

<script setup lang="ts">
defineProps({
  title: String,
  description: String,
  img: {
    type: String,
    default() {
      return 'https://picsum.photos/275/320'
    },
  },
})
</script>
