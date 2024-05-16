<template>
  <main>
    <div class="bg-gray-300">
      <div class="mx-auto max-w-2xl px-4 py-4 sm:px-6 sm:py-8 lg:max-w-7xl lg:px-8">
        <h2 class="text-2xl font-bold tracking-tight text-gray-900">Liste des cadeaux</h2>
        <p class="mt-2 text-sm text-gray-700">Merci de contribuer à notre lune de miel.</p>
        <div
          class="mt-6 grid grid-cols-1 gap-x-6 gap-y-10 sm:grid-cols-2 lg:grid-cols-4 xl:gap-x-8"
        >
          <GiftItem>
            <GiftPrice total-price="30" remaining-price="25" />
          </GiftItem>
          <GiftItem>
            <GiftPrice total-price="30" remaining-price="25" />
          </GiftItem>
          <GiftItem>
            <GiftParts total-parts="4" part-price="50" remaining-parts="3" />
          </GiftItem>
          <GiftItem>
            <GiftPrice total-price="30" remaining-price="25" />
          </GiftItem>
          <GiftItem>
            <GiftPrice total-price="30" remaining-price="25" />
          </GiftItem>
          <GiftItem>
            <GiftPrice total-price="30" remaining-price="25" />
          </GiftItem>
          <GiftItem>
            <GiftParts total-parts="4" part-price="50" remaining-parts="3" />
          </GiftItem>
          <GiftItem>
            <GiftPrice total-price="30" remaining-price="25" />
          </GiftItem>
          <!-- More products... -->
        </div>
      </div>
    </div>
  </main>
</template>

<script setup lang="ts">
import GiftItem from '../components/GiftItem.vue'
import GiftPrice from '../components/GiftPrice.vue'
import GiftParts from '../components/GiftParts.vue'
</script>
