<template>
  <form>
    <div class="space-y-12 bg-white p-8 h-full">
      <div class="grid grid-cols-1 gap-x-8 gap-y-10 border-b border-gray-900/10 pb-12 md:grid-cols-3">
        <div>
          <h2 class="text-base font-semibold leading-7 text-gray-900">
            <div class="text-3xl" v-for="l in languages" :key="l.id">{{ l.title }}</div>
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
              <button type="button"
                class="rounded-md bg-white px-2.5 py-1.5 text-sm font-semibold text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50">
                Change
              </button>
            </div>
          </div>

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

          <!-- <div class="col-span-full">
            <label for="cover-photo" class="block text-sm font-medium leading-6 text-gray-900"
              >Cover photo</label
            >
            <div
              class="mt-2 flex justify-center rounded-lg border border-dashed border-gray-900/25 px-6 py-10"
            >
              <div class="text-center">
                <PhotoIcon class="mx-auto h-12 w-12 text-gray-300" aria-hidden="true" />
                <div class="mt-4 flex text-sm leading-6 text-gray-600">
                  <label
                    for="file-upload"
                    class="relative cursor-pointer rounded-md bg-white font-semibold text-indigo-600 focus-within:outline-none focus-within:ring-2 focus-within:ring-indigo-600 focus-within:ring-offset-2 hover:text-indigo-500"
                  >
                    <span>Upload a file</span>
                    <input id="file-upload" name="file-upload" type="file" class="sr-only" accept=".png, .jpg, .jpeg, .gif" />
                  </label>
                  <p class="pl-1">or drag and drop</p>
                </div>
                <p class="text-xs leading-5 text-gray-600">PNG, JPG, GIF up to 10MB</p>
              </div>
            </div>
          </div> -->
        </div>
      </div>

      <div v-for="l in languages" :key="l.id"
        class="grid grid-cols-1 gap-x-8 gap-y-10 border-b border-gray-900/10 pb-12 md:grid-cols-3">
        <div>
          <h2 class="text-base font-semibold leading-7 text-gray-900">
            Language <span class="italic">{{ l.language }}</span>
          </h2>
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

      <div class="mt-6 flex items-center justify-end gap-x-6">
        <button type="button" class="text-sm font-semibold leading-6 text-gray-900" @click.prevent="modalOpen = true">
          Cancel
        </button>
        <button type="submit"
          class="rounded-md bg-indigo-600 px-3 py-2 text-sm font-semibold text-white shadow-sm hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600"
          @click.prevent="updateGift">
          Save
        </button>
      </div>
    </div>
    <CriticalDialog v-model="modalOpen" title="Cancel?" message="All changes will be lost" confirm-button="OK"
      cancel-button="No" @confirm="router.push('/admin/gifts')" />
  </form>
</template>

<script setup lang="ts">
import { useToast } from 'vue-toast-notification'
import { useRouter } from 'vue-router'
import { PhotoIcon, UserCircleIcon } from '@heroicons/vue/24/solid'
import { supabase } from '@/database/supabase'
import { ref, onMounted } from 'vue'
import { useSettingsStore } from '@/stores/settings'
import type { Tables } from '@/database/database.types'
import CriticalDialog from '@/components/CriticalDialog.vue'

const props = defineProps<{
  id: number
}>()

const gift = ref<Tables<'gifts'>>({})
const languages = ref({})
const modalOpen = ref(false)

const settingsStore = useSettingsStore()
const toast = useToast()
const router = useRouter()

async function getGift() {
  const { data, error } = await supabase.from('gifts').select().eq('id', props.id).single()
  if (error) {
    console.error(error)
  } else {
    gift.value = data
    console.log(data)
  }
  getLanguages()
}

async function getLanguages() {
  const { data, error } = await supabase.from('gift_translations').select().eq('gift', props.id)
  if (error) {
    console.error(error)
  } else {
    languages.value = data
    console.log(data)
  }
}

async function updateGift() {
  const { error } = await supabase.from('gifts').update(gift.value).eq('id', props.id)

  if (error) {
    toast.error(error.message, { duration: 5000 })
  } else {
    for (const l of languages.value) {
      const { error } = await supabase.from('gift_translations').update(l).eq('id', l.id)
      if (error) {
        console.error(error)
        return
      } else {
        console.log('Language', l.language, 'updated')
      }
    }
    toast.success('Gift updated')
    router.push('/admin/gifts')
  }
}

onMounted(() => {
  getGift()
})
</script>
