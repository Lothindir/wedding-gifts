<script setup lang="ts">
import { ref, onMounted, defineComponent, h } from 'vue'
import { RouterView } from 'vue-router'
import { useI18n } from 'vue-i18n'
import { i18n, loadLocaleMessages } from './utils/i18n'

import { useSettingsStore } from '@/stores/settings'
import { useGiftsStore } from '@/stores/gifts'
import { useRecaptchaProvider } from 'vue-recaptcha'

import logoWhite from '@/assets/images/logo/logo-white_nt.svg'

import FooterComponent from '@/components/FooterComponent.vue'
import CartIcon from '@/components/CartIcon.vue'

useRecaptchaProvider()
const { t, locale } = useI18n()
// const selectedLocale = ref<string>(i18n.global.locale)
const settingsStore = useSettingsStore()
const giftsStore = useGiftsStore()
const devMode = import.meta.env.DEV

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
    <RouterLink to="/" class="flex align-baseline">
      <img :src="logoWhite" class="my-1 ml-1 h-12 w-12" alt="Logo" />
      <h1 class="text-2xl font-bold py-4 pl-1">{{ t('wedding.title') }} Katja & Francesco</h1>
    </RouterLink>
    <div class="flex">
      <CartIcon />
      <div class="locale-changer ml-8 mr-2 mt-2 flex">
        <select
          id="locale"
          name="locale"
          v-model="$i18n.locale"
          class="my-auto mt-2 block w-full rounded-md border-0 py-1.5 pl-3 pr-10 text-gray-900 ring-1 ring-inset ring-gray-300 focus:ring-2 focus:ring-indigo-600 sm:text-sm sm:leading-6"
        >
          <option
            v-for="locale in $i18n.availableLocales"
            :key="`locale-${locale}`"
            :value="locale"
          >
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
    </div>
  </header>
  <div
    class="flex items-center gap-x-6 bg-orange-600 px-6 py-2.5 sm:px-3.5 sm:before:flex-1"
    v-if="devMode"
  >
    <p class="text-sm leading-6 text-white">
      <a href="#">
        <strong class="font-semibold">Work in progress</strong
        ><svg viewBox="0 0 2 2" class="mx-2 inline h-0.5 w-0.5 fill-current" aria-hidden="true">
          <circle cx="1" cy="1" r="1" />
        </svg>
        This website is still under development. Some features may not work as expected.
      </a>
    </p>
    <div class="flex flex-1 justify-end"></div>
  </div>

  <div class="h-full">
    <RouterView class="flex-1" />
    <div
      class="fixed right-0 bottom-1/2 rounded-l-md bg-orange-400"
      v-if="$route.name != 'checkout'"
    >
      <CartIcon class="text-gray-700 my-2 ml-2 mr-4" />
    </div>
  </div>

  <FooterComponent />
</template>
