<template>
  <form>
    <div class="space-y-12 bg-white p-8 h-full">
      <div class="grid grid-cols-1 gap-x-8 gap-y-10 border-b border-gray-900/10 pb-12 md:grid-cols-3">
        <div>
          <h1 class="text-4xl font-semibold leading-7 text-gray-900" v-if="languages.length == 0">
            New gift
          </h1>
          <h2 class="text-base font-semibold leading-7 text-gray-900" v-else>
            <div class="text-3xl" v-for="l in languages" :key="l.id">{{ l.title }}</div>
          </h2>
          <h2 class="mt-2 text-base font-semibold leading-7 text-gray-900">
            Generic informations
          </h2>
        </div>

        <div class="grid max-w-2xl grid-cols-1 gap-x-6 gap-y-8 sm:grid-cols-6 md:col-span-2">
          <div class="sm:col-span-4">
            <label for="price" class="block text-sm font-medium leading-6 text-gray-900">Price</label>
            <div class="mt-2">
              <div
                class="flex rounded-md shadow-sm ring-1 ring-inset ring-gray-300 focus-within:ring-2 focus-within:ring-inset focus-within:ring-indigo-600 sm:max-w-md">
                <span class="flex select-none items-center pl-3 text-gray-500 sm:text-sm">{{
                  settingsStore.currency
                  }}</span>
                <input type="number" name="price" id="price"
                  class="block flex-1 border-0 bg-transparent py-1.5 pl-1 text-gray-900 placeholder:text-gray-400 focus:ring-0 sm:text-sm sm:leading-6"
                  v-model="gift.price" step="0.01" required />
              </div>
            </div>
          </div>

          <div class="grid max-w-2xl grid-cols-1 gap-x-6 gap-y-8 sm:grid-cols-6 md:col-span-2">
            <div class="sm:col-span-4">
              <label for="pieces" class="block text-sm font-medium leading-6 text-gray-900">Parts</label>
              <div class="mt-2">
                <div
                  class="flex rounded-md shadow-sm ring-1 ring-inset ring-gray-300 focus-within:ring-2 focus-within:ring-inset focus-within:ring-indigo-600 sm:max-w-md">
                  <input type="text" name="parts" id="parts"
                    class="block flex-1 border-0 bg-transparent py-1.5 pl-1 text-gray-900 placeholder:text-gray-400 focus:ring-0 sm:text-sm sm:leading-6"
                    v-model="gift.parts" />
                </div>
              </div>
            </div>
          </div>

          <div class="col-span-full">
            <label for="photo" class="block text-sm font-medium leading-6 text-gray-900">Photo</label>
            <div class="mt-2 flex items-center gap-x-3">
              <img :src="gift.image" class="h-36 w-36 text-gray-300" aria-hidden="true" />
              <button type="button" @click="uploadModalOpen = true"
                class="rounded-md bg-white px-2.5 py-1.5 text-sm font-semibold text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50">
                Change
              </button>
            </div>
          </div>

          <UploadFileDialog v-model:open="uploadModalOpen" title="Upload a file" @uploaded="(url) => gift.image = url"
            message="PNG, JPG, GIF up to 10MB" />

          <fieldset class="col-span-full">
            <div class="mt-6 space-y-6">
              <div class="relative flex gap-x-3">
                <div class="flex h-6 items-center">
                  <input id="comments" name="comments" type="checkbox"
                    class="h-4 w-4 rounded border-gray-300 text-indigo-600 focus:ring-indigo-600"
                    v-model="gift.hidden" />
                </div>
                <div class="text-sm leading-6">
                  <label for="comments" class="font-medium text-gray-900">Hidden</label>
                  <p class="text-gray-500">Hide the gift from the main page.</p>
                </div>
              </div>
            </div>
          </fieldset>
        </div>
      </div>

      <div v-for="l in languages" :key="l.id"
        class="grid grid-cols-1 gap-x-8 gap-y-10 border-b border-gray-900/10 pb-12 md:grid-cols-3">
        <div>
          <h2 class="text-base font-semibold leading-7 text-gray-900">
            Language <span class="italic">{{ l.language }}</span>
          </h2>
          <button type="button"
            class="w-full justify-center rounded-md bg-red-400 px-3 py-2 text-sm font-semibold text-white shadow-sm hover:bg-red-500 sm:w-auto"
            @click="removeLanguage(l.language)">
            Remove language
          </button>
        </div>

        <div class="grid max-w-2xl grid-cols-1 gap-x-6 gap-y-8 sm:grid-cols-6 md:col-span-2">
          <div class="sm:col-span-4">
            <label for="title" class="block text-sm font-medium leading-6 text-gray-900">Title</label>
            <div class="mt-2">
              <input type="text" name="title" id="title" v-model="l.title" required
                class="block w-full rounded-md border-0 py-1.5 pl-1 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6" />
            </div>
          </div>

          <div class="sm:col-span-full">
            <label for="description" class="block text-sm font-medium leading-6 text-gray-900">Description</label>
            <div class="mt-2">
              <textarea id="description" name="description" rows="3" v-model="l.description"
                class="block w-full rounded-md border-0 py-1.5 pl-1 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6" />
            </div>
          </div>
        </div>
      </div>

      <div class="grid grid-cols-1 gap-x-8 gap-y-10 border-b border-gray-900/10 pb-12 md:grid-cols-3"
        v-if="missingLanguages.length > 0">
        <!-- Select box to add languages that are missing -->
        <h2 class="text-base font-semibold leading-7 text-gray-900">
          Add other languages
        </h2>
        <div class="sm:col-span-4">
          <label for="language" class="block text-sm font-medium leading-6 text-gray-900">Language</label>
          <div class="mt-2 flex">
            <select id="language" name="language" v-model="languageToAdd"
              class="block w-32 rounded-md border-0 py-1.5 pl-1 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6">
              <option v-for="l in missingLanguages" :key="l" :value="l">{{ l }}</option>
            </select>
            <button type="button"
              class="rounded-md bg-white ml-8 px-2.5 py-1.5 text-sm font-semibold text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50"
              @click.prevent="addLanguage">
              Add language
            </button>
          </div>
        </div>
      </div>

      <div class="mt-6 flex items-center justify-end gap-x-6">
        <button type="button" class="text-sm font-semibold leading-6 text-gray-900"
          @click.prevent="cancelModalOpen = true">
          Cancel
        </button>
        <button type="submit"
          class="rounded-md bg-indigo-600 px-3 py-2 text-sm font-semibold text-white shadow-sm hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600 disabled:opacity-50 disabled:cursor-not-allowed"
          @click.prevent="save" :disabled="!canSave">
          Save
        </button>
      </div>
    </div>
    <CriticalDialog v-model="cancelModalOpen" title="Cancel?" message="All changes will be lost" confirm-button="OK"
      cancel-button="No" @confirm="emits('cancel')" />
  </form>
</template>

<script setup lang="ts">
import { useToast } from 'vue-toast-notification'
import { computed, onMounted, ref, watch } from 'vue'
import { useSettingsStore } from '@/stores/settings'
import CriticalDialog from '@/components/CriticalDialog.vue'
import UploadFileDialog from '@/components/UploadFileDialog.vue'

import type { Tables, TablesInsert } from '@/database/database.types'

const gift = defineModel<Tables<'gifts'> | TablesInsert<'gifts'>>('gift', { required: true })
const languages = defineModel<Tables<'gift_translations'>[] | TablesInsert<'gift_translations'>[]>('languages', { required: true })

const missingLanguages = ref<string[]>([])
const languageToAdd = ref<string>('')
const cancelModalOpen = ref(false)
const uploadModalOpen = ref(false)
const canSave = computed(() => languages.value.length > 0 && languages.value.every((l) => l.title))

const settingsStore = useSettingsStore()
const toast = useToast()

const emits = defineEmits<{
  save: [],
  cancel: []
}>()

/** Add and remove languages **/
watch(() => settingsStore.languages, () => {
  if (settingsStore.languages) {
    missingLanguages.value = settingsStore.languages.filter((l) => !languages.value.find((t) => t.language === l))
    languageToAdd.value = missingLanguages.value[0]
  }
})

watch(() => languages.value, () => {
  if (settingsStore.languages) {
    missingLanguages.value = settingsStore.languages.filter((l) => !languages.value.find((t) => t.language === l))
    languageToAdd.value = missingLanguages.value[0]
  }
})

function addLanguage() {
  if (languageToAdd.value) {
    languages.value.push({
      id: -1,
      gift: gift.value.id!,
      language: languageToAdd.value,
      title: '',
      description: '',
    })
    missingLanguages.value = missingLanguages.value.filter((l) => l !== languageToAdd.value)
    languageToAdd.value = missingLanguages.value[0]
  }
}

function removeLanguage(language: string) {
  languages.value = languages.value.filter((l) => l.language !== language)
  missingLanguages.value.push(language)
}

function save() {
  if (canSave.value) {
    emits('save')
  } else {
    toast.error('At least one language must be added')
  }
}

onMounted(() => {
  if (settingsStore.languages) {
    missingLanguages.value = settingsStore.languages.filter((l) => !languages.value.find((t) => t.language === l))
    languageToAdd.value = missingLanguages.value[0]
  }
})
</script>