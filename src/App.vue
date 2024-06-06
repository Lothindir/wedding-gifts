<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { RouterView } from 'vue-router'
import { useI18n } from 'vue-i18n'
import { i18n, loadLocaleMessages } from './utils/i18n';
import { useSettingsStore } from '@/stores/settings'

const { t } = useI18n()
// const selectedLocale = ref<string>(i18n.global.locale)
const settingsStore = useSettingsStore()
settingsStore.loadSettings()

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
    <h1 class="text-2xl font-bold p-4">{{ t('wedding.title') }} Katja & Francesco</h1>
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
  <RouterView />
</template>
