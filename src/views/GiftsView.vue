<template>
  <main>
    <div class="bg-gray-300 h-full w-full">
      <div class="mx-auto max-w-2xl px-4 py-4 sm:px-6 sm:py-8 lg:max-w-7xl lg:px-8">
        <h2 class="text-2xl font-bold tracking-tight text-gray-900">Liste des cadeaux</h2>
        <p class="mt-2 text-sm text-gray-700">Merci de contribuer à notre lune de miel.</p>
        <div
          class="mt-6 grid grid-cols-1 gap-x-6 gap-y-10 sm:grid-cols-2 lg:grid-cols-4 xl:gap-x-8"
        >
          <GiftItem v-for="gift in gifts"
          :key="gift.id"
          :title="gift.title"
          :img="gift.img"
          :description="gift.description">
            <GiftPrice :total-price="gift.price" :gifted-amount="gift.gifted" v-if="gift.parts==0" />
            <GiftParts :total-parts="gift.parts" :gifted-parts="gift.gifted" :part-price="gift.price" v-else />
          </GiftItem>
          <!-- More products... -->
        </div>
      </div>
    </div>
  </main>
</template>

<script setup lang="ts">
import { supabase } from '@/utils/supabase'
import { ref, onMounted } from 'vue'

import GiftItem from '@/components/GiftItem.vue'
import GiftPrice from '@/components/GiftPrice.vue'
import GiftParts from '@/components/GiftParts.vue'

const gifts = ref([])

async function getGifts() {
  const { data, error } = await supabase.from('gifts_with_total_amount').select()
  if (error) {
    console.error(error)
  } else {
    gifts.value = data
    console.log(data);
  }
}

onMounted(() => {
  getGifts()
})
</script>
