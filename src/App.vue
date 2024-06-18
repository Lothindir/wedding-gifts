<script setup lang="ts">
import { ref, onMounted, defineComponent, h } from 'vue'
import { RouterView } from 'vue-router'
import { useI18n } from 'vue-i18n'
import { i18n, loadLocaleMessages } from './utils/i18n';
import { useSettingsStore } from '@/stores/settings'
import { useGiftsStore } from '@/stores/gifts'
import logoWhite from '@/assets/images/logo/logo-white_nt.svg'

import FooterComponent from '@/components/FooterComponent.vue'

const { t, locale } = useI18n()
// const selectedLocale = ref<string>(i18n.global.locale)
const settingsStore = useSettingsStore()
const giftsStore = useGiftsStore()
settingsStore.loadSettings()
giftsStore.loadGifts()
giftsStore.loadGiftsTranslations(locale.value)

// async function changeLocale() {
//   await loadLocaleMessages(i18n, selectedLocale.value)
// }

// onMounted(async () => {
//   await settingsStore.loadSettings()
//   if (settingsStore.languages_default && settingsStore.languages_default !== i18n.global.locale)
//     selectedLocale.value = settingsStore.languages_default
// })
</script>

<template>
  <header class="flex justify-between align-middle">
    <div class="flex align-baseline">
      <img :src="logoWhite" class="my-1 ml-1 h-12 w-12" alt="Logo" />
      <h1 class="text-2xl font-bold py-4 pl-1">{{ t('wedding.title') }} Katja & Francesco</h1>
    </div>
    <div class="locale-changer mr-2 mt-2">
      <select id="locale" name="locale" v-model="$i18n.locale"
        class="my-auto mt-2 block w-full rounded-md border-0 py-1.5 pl-3 pr-10 text-gray-900 ring-1 ring-inset ring-gray-300 focus:ring-2 focus:ring-indigo-600 sm:text-sm sm:leading-6">
        <option v-for="locale in $i18n.availableLocales" :key="`locale-${locale}`" :value="locale">
          {{ locale }}
        </option>
      </select>
      <!-- <select id="locale" name="locale" @change="changeLocale()" v-model="selectedLocale"
        class="my-auto mt-2 block w-full rounded-md border-0 py-1.5 px-3 pr-10 text-gray-900 ring-1 ring-inset ring-gray-300 focus:ring-2 focus:ring-indigo-600 sm:text-sm sm:leading-6">
        <option v-for="locale in settingsStore.languages" :key="`locale-${locale}`" :value="locale"
          :selected="locale == settingsStore.languages_default">
          {{ locale }}
        </option>
      </select> -->
    </div>
  </header>

  <div class="h-full">
    <RouterView class="flex-1" />
  </div>

  <FooterComponent />
</template>
