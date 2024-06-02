<template>
  <TransitionRoot as="template" :show="open">
    <Dialog class="relative z-10" @close="open = false">
      <TransitionChild as="template" enter="ease-out duration-300" enter-from="opacity-0" enter-to="opacity-100"
        leave="ease-in duration-200" leave-from="opacity-100" leave-to="opacity-0">
        <div class="fixed inset-0 bg-gray-500 bg-opacity-75 transition-opacity" />
      </TransitionChild>

      <div class="fixed inset-0 z-10 w-screen overflow-y-auto">
        <div class="flex min-h-full items-end justify-center p-4 text-center sm:items-center sm:p-0">
          <TransitionChild as="template" enter="ease-out duration-300"
            enter-from="opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95"
            enter-to="opacity-100 translate-y-0 sm:scale-100" leave="ease-in duration-200"
            leave-from="opacity-100 translate-y-0 sm:scale-100"
            leave-to="opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95">
            <DialogPanel
              class="relative transform overflow-hidden rounded-lg w-48 h-96 bg-white text-left shadow-xl transition-all sm:my-8 sm:w-full sm:max-w-lg">
              <DialogTitle as="h3" class="text-2xl font-semibold pt-4 px-4 leading-6 text-gray-900">{{ props.title }}
              </DialogTitle>
              <div class="px-4">
                <div class="sm:hidden">
                  <label for="tabs" class="sr-only">Select a tab</label>
                  <!-- Use an "onChange" listener to redirect the user to the selected tab URL. -->
                  <select id="tabs" name="tabs"
                    class="block w-full rounded-md border-gray-300 focus:border-indigo-500 focus:ring-indigo-500">
                    <option v-for="tab in tabs" :key="tab.name" :selected="tab.tab == activeTab">{{ tab.name }}</option>
                  </select>
                </div>
                <div class="hidden sm:block">
                  <div class="border-b border-gray-200">
                    <nav class="-mb-px flex space-x-8" aria-label="Tabs">
                      <a v-for="tab in tabs" :key="tab.name" @click="activeTab = tab.tab"
                        :class="[tab.tab == activeTab ? 'border-indigo-500 text-indigo-600' : 'border-transparent text-gray-500 hover:border-gray-300 hover:text-gray-700', 'group inline-flex items-center border-b-2 py-4 px-1 text-sm font-medium']"
                        :aria-current="tab.tab == activeTab ? 'page' : undefined">
                        <component :is="tab.icon"
                          :class="[tab.tab == activeTab ? 'text-indigo-500' : 'text-gray-400 group-hover:text-gray-500', '-ml-0.5 mr-2 h-5 w-5']"
                          aria-hidden="true" />
                        <span>{{ tab.name }}</span>
                      </a>
                    </nav>
                  </div>
                </div>
              </div>

              <!-- Upload file -->
              <div class="col-span-full px-4 pt-4" v-if="activeTab == 0">
                <label for="cover-photo" class="block text-sm font-medium leading-6 text-gray-900">Cover photo</label>
                <div class="mt-2 flex justify-center rounded-lg border border-dashed border-gray-900/25 px-6 py-10">
                  <div v-if="!file" class="text-center">
                    <PhotoIcon class="mx-auto h-12 w-12 text-gray-300" aria-hidden="true" />
                    <div class="mt-4 flex text-sm leading-6 text-gray-600">
                      <label for="file-upload"
                        class="relative cursor-pointer rounded-md bg-white font-semibold text-indigo-600 focus-within:outline-none focus-within:ring-2 focus-within:ring-indigo-600 focus-within:ring-offset-2 hover:text-indigo-500">
                        <span>Upload a file</span>
                        <input id="file-upload" name="file-upload" type="file" class="sr-only"
                          accept=".png, .jpg, .jpeg, .gif" @change="fileChange" />
                      </label>
                      <p class="pl-1">or drag and drop</p>
                    </div>
                    <p class="text-xs leading-5 text-gray-600">PNG, JPG, GIF up to 10MB</p>
                  </div>
                  <img v-else :src="url" class="w-16 h16" />
                </div>
              </div>

              <!-- Load URL -->
              <div class="bg-white px-4 pb-4 pt-5 sm:p-6 sm:pb-4" v-if="activeTab == 1">
                <div class="mt-3 text-center sm:ml-4 sm:mt-0 sm:text-left">
                  <DialogTitle as="h3" class="text-base font-semibold leading-6 text-gray-900">Load from URL
                  </DialogTitle>
                  <div class="mt-2">
                    <div class="mt-1">
                      <input type="text" name="url" id="url" placeholder="https://" v-model="url"
                        class="block w-full rounded-md border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm sm:leading-6" />
                    </div>
                  </div>
                </div>
              </div>

              <div class="relative bottom-0 pt-2 py-3 sm:flex sm:flex-row-reverse sm:px-6">
                <button type="button"
                  class="inline-flex w-full justify-center rounded-md bg-green-600 px-3 py-2 text-sm font-semibold text-white shadow-sm hover:bg-green-500 sm:ml-3 sm:w-auto"
                  @click="save">
                  Save
                </button>
                <button type="button"
                  class="mt-3 inline-flex w-full justify-center rounded-md bg-white px-3 py-2 text-sm font-semibold text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50 sm:mt-0 sm:w-auto"
                  @click="open = false" ref="cancelButtonRef">
                  Cancel
                </button>
              </div>
            </DialogPanel>
          </TransitionChild>
        </div>
      </div>
    </Dialog>
  </TransitionRoot>
</template>

<script setup lang="ts">
interface HTMLInputEvent extends Event {
  target: HTMLInputElement & EventTarget;
  dataTransfer?: DataTransfer;
}

import { ref } from 'vue'
import { Dialog, DialogPanel, DialogTitle, TransitionChild, TransitionRoot } from '@headlessui/vue'
import { useI18n } from 'vue-i18n'
import { useToast } from 'vue-toast-notification';
import { supabase } from '@/database/supabase'
import { DocumentArrowUpIcon, LinkIcon, PhotoIcon } from '@heroicons/vue/20/solid'

const { t } = useI18n()
const toast = useToast()
const activeTab = ref(0)
const file = ref<File | null>(null)
const uploadedFilePath = ref('')
const url = ref('')

const props = defineProps<{
  title: string
  message: string
}>()

const emits = defineEmits<{
  uploaded: [url: string]
}>()

function fileChange(e: HTMLInputEvent) {
  if (!e.target) {
    toast.error('No file selected')
    return
  }
  let files = e.target.files || e.dataTransfer?.files
  if (!files?.length) {
    toast.error('No file selected')
    return
  }
  file.value = files[0]
  createAndUploadImage(files[0])
}

async function createAndUploadImage(file: File) {
  const fileExt = file.name.split('.').pop()
  const filePath = `${Math.random()}.${fileExt}`
  toast.info('Uploading image...')

  const { error: uploadError } = await supabase.storage.from('images').upload(filePath, file)

  if (uploadError) {
    toast.error('Error uploading image: ' + uploadError.message)
  } else {
    toast.success('Image uploaded')
    uploadedFilePath.value = filePath
    downloadImage()
  }
}

async function downloadImage() {
  try {
    const { data } = await supabase.storage.from('images').getPublicUrl(uploadedFilePath.value)
    url.value = data.publicUrl
    toast.success('Image URL retrieved')
  } catch (error) {
    toast.error('Error downloading image')
  }
}

function save() {
  // Check
  if (activeTab.value == 0) {
    if (url.value) {
      emits('uploaded', url.value)
      reset()
      open.value = false
    } else {
      toast.error('No file uploaded')
    }
  } else if (activeTab.value == 1) {
    if (url.value) {
      emits('uploaded', url.value)
      reset()
      open.value = false
    } else {
      toast.error('No URL entered')
    }
  }
}

const tabs = [
  { name: 'File Upload', icon: DocumentArrowUpIcon, tab: 0 },
  { name: 'URL', icon: LinkIcon, tab: 1 },
]

const open = defineModel('open', { default: false })

function reset() {
  file.value = null
  uploadedFilePath.value = ''
  url.value = ''
  activeTab.value = 0
}
</script>
