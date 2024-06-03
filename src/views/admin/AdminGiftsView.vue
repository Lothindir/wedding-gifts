<template>
  <main class="bg-white h-screen w-full p-8">
    <div class="px-4 sm:px-6 lg:px-8">
      <div class="sm:flex sm:items-center">
        <div class="sm:flex-auto">
          <h1 class="text-base font-semibold leading-6 text-gray-900">Gifts</h1>
          <!-- <p class="mt-2 text-sm text-gray-700">
            A list of all the users in your account including their name, title, email and role.
          </p> -->
        </div>
        <div class="mt-4 sm:ml-16 sm:mt-0 sm:flex-none">
          <button @click="$router.push('/admin/gifts/add')" type="button"
            class="block rounded-md bg-indigo-600 px-3 py-2 text-center text-sm font-semibold text-white shadow-sm hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600">
            Add gift
          </button>
        </div>
      </div>
      <div class="-mx-4 mt-8 sm:-mx-0">
        <table class="min-w-full divide-y divide-gray-300 table-auto">
          <thead>
            <tr>
              <th scope="col" class="py-3.5 pl-1 pr-1 text-left text-sm font-semibold text-gray-900 sm:pl-0">
                Image
              </th>
              <th scope="col" class="py-3.5 pl-4 pr-3 text-left text-sm font-semibold text-gray-900 sm:table-cell">
                Title
              </th>
              <th scope="col" class="hidden px-3 py-3.5 text-left text-sm font-semibold text-gray-900 sm:table-cell">
                Description
              </th>
              <th scope="col" class="hidden px-3 py-3.5 text-left text-sm font-semibold text-gray-900 lg:table-cell">
                Price
              </th>
              <th scope="col" class="px-3 py-3.5 text-left text-sm font-semibold text-gray-900">
                Parts
              </th>
              <th scope="col" class="relative py-3.5 pl-3 pr-4 sm:pr-0">
                <span class="sr-only">Edit or Delete</span>
              </th>
            </tr>
          </thead>
          <tbody class="divide-y divide-gray-200 bg-white rounded rounded-md">
            <tr v-for="gift in gifts" :key="gift.id">
              <td class="whitespace-nowrap py-4 pl-1 pr-1 text-sm font-medium text-gray-900 sm:pl-0">
                <img :src="gift.image" class="object-cover object-center w-16 h-16" />
              </td>
              <td class="whitespace-nowrap py-4 pl-4 pr-3 text-sm font-medium text-gray-900 sm:table-cell">
                {{ gift.title }}
              </td>
              <td class="hidden whitespace-nowrap px-3 py-4 text-sm text-gray-500 sm:table-cell">
                {{ gift.description }}
              </td>
              <td class="hidden whitespace-nowrap px-3 py-4 text-sm text-gray-500 lg:table-cell">
                {{ gift.price }}
              </td>
              <td class="whitespace-nowrap px-3 py-4 text-sm text-gray-500">{{ gift.parts }}</td>
              <td class="whitespace-nowrap py-4 pl-3 pr-4 text-right text-sm font-medium sm:pr-0">
                <router-link :to="`/admin/gifts/${gift.id}`" class="text-indigo-600 hover:text-indigo-900">
                  Edit<span class="sr-only">, {{ gift.title }}</span></router-link>
                <button type="button" class="text-white rounded-md bg-red-400 p-1 hover:text-red-900 ml-2"
                  @click="tryDelete(gift.id)">
                  Delete
                </button>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
    <CriticalDialog v-model="modalOpen" title="Delete?" message="Gift will be deleted" confirm-button="Delete"
      cancel-button="Cancel" @confirm="deleteGift()" />
  </main>
</template>

<script setup lang="ts">
import { ref, onMounted, watch } from 'vue'
import { supabase } from '@/database/supabase'
import { useI18n } from 'vue-i18n'
import type { Tables } from '@/database/database.types'
import { useToast } from 'vue-toast-notification'
import CriticalDialog from '@/components/CriticalDialog.vue'

const gifts = ref<Tables<'all_gifts'>[]>([])
const toast = useToast()
const { locale } = useI18n()
const modalOpen = ref(false)
const giftToDeleteId = ref(-1)

watch(locale, () => {
  getGifts()
})

async function getGifts() {
  const { data, error } = await supabase.from('all_gifts').select().eq('language', locale.value)
  if (error) {
    toast.error('Error fetching gifts')
  } else {
    gifts.value = data
  }
}

function tryDelete(id: number) {
  giftToDeleteId.value = id
  modalOpen.value = true
}

async function deleteGift() {
  if (giftToDeleteId.value >= 0) {
    const { error } = await supabase.from('gift_translations').delete().eq('gift', giftToDeleteId.value)
    if (error) {
      toast.error('Error deleting gift translations: ' + error.message)
    } else {
      const { error } = await supabase.from('gifts').delete().eq('id', giftToDeleteId.value)
      if (error) {
        toast.error('Error deleting gift: ' + error.message)
      } else {
        gifts.value = gifts.value.filter((gift) => gift.id !== giftToDeleteId.value)
        giftToDeleteId.value = -1
        toast.success('Gift deleted')
      }
    }
  }
}

onMounted(() => {
  getGifts()
})
</script>
