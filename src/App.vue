<script setup lang="ts">
import { RouterLink, RouterView } from 'vue-router'
import { useI18n } from 'vue-i18n'
import { useSettingsStore } from '@/stores/settings'

const { t } = useI18n()
const settingsStore = useSettingsStore()
settingsStore.loadSettings()
</script>

<template>
  <header class="flex justify-between align-middle">
    <h1 class="text-2xl font-bold p-4">{{ t('wedding.title') }} de Katja & Francesco</h1>
    <div class="locale-changer">
      <!-- <label for="locale" class="block text-sm font-medium leading-6 text-gray-900">Lang</label> -->
      <select
        id="locale"
        name="locale"
        v-model="$i18n.locale"
        class="my-auto mt-2 block w-full rounded-md border-0 py-1.5 pl-3 pr-10 text-gray-900 ring-1 ring-inset ring-gray-300 focus:ring-2 focus:ring-indigo-600 sm:text-sm sm:leading-6"
      >
        <option v-for="locale in $i18n.availableLocales" :key="`locale-${locale}`" :value="locale">
          {{ locale }}
        </option>
      </select>
    </div>
  </header>
  <RouterView />
</template>
