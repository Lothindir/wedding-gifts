<template>
  <TransitionRoot as="template" :show="open">
    <Dialog class="relative z-10" @close="close">
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
              class="relative transform overflow-hidden rounded-lg bg-white px-4 pb-4 pt-5 text-left shadow-xl transition-all sm:my-8 sm:w-full sm:max-w-sm sm:p-6">
              <div>
                <div class="mx-auto flex h-12 w-12 items-center justify-center rounded-full bg-green-100">
                  <CheckIcon class="h-6 w-6 text-green-600" aria-hidden="true" />
                </div>
                <div class="mt-3 text-center sm:mt-5">
                  <DialogTitle as="h3" class="text-base font-semibold leading-6 text-gray-900">{{
                    t('checkout.modal_title') }}
                  </DialogTitle>
                  <DialogDescription class="mt-2 text-sm text-gray-500">
                    {{ t('checkout.modal_description') }}
                  </DialogDescription>
                </div>
                <p class="mt-6 text-sm text-black">
                  {{ t('checkout.modal_text') }}
                </p>
              </div>
              <div class="mt-6 border-t border-gray-200 pt-6">
                <fieldset>
                  <legend class="text-lg font-medium text-gray-900">{{ t('checkout.modal_payment') }}</legend>
                  <RadioGroup v-model="selectedPaymentMethod"
                    class="mt-4 grid grid-cols-1 gap-y-6 sm:grid-cols-2 sm:gap-x-4">
                    <RadioGroupOption as="template" v-for="deliveryMethod in settingsStore.payment_methods"
                      :key="deliveryMethod.id" :value="deliveryMethod" :aria-label="deliveryMethod.title"
                      :aria-description="`${deliveryMethod.title}`" v-slot="{ active, checked }">
                      <div
                        :class="[checked ? 'border-transparent' : 'border-gray-300', active ? 'ring-2 ring-indigo-500' : '', 'relative flex cursor-pointer rounded-lg border bg-white p-4 shadow-sm focus:outline-none']">
                        <img :src="deliveryMethod.image" />
                        <span
                          :class="[active ? 'border' : 'border-2', checked ? 'border-indigo-500' : 'border-transparent', 'pointer-events-none absolute -inset-px rounded-lg']"
                          aria-hidden="true" />
                      </div>
                    </RadioGroupOption>
                  </RadioGroup>
                </fieldset>
              </div>
              <div class="text-sm text-gray-700 mt-2">
                <div class="flex flex-col align-middle">
                  <div class="flex justify-center my-1" v-for="method of selectedPaymentMethod.info" :key="method">
                    <component :is="selectedPaymentMethod.info_icon" class="w-6 mr-4"
                      v-if="selectedPaymentMethod.info_icon" />
                    <span class="my-auto">{{ method }}</span>
                  </div>
                </div>
              </div>

              <div class="mt-5 sm:mt-6">
                <button type="button"
                  class="inline-flex w-full justify-center rounded-md bg-indigo-600 px-3 py-2 text-sm font-semibold text-white shadow-sm hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600"
                  @click="close">{{ t('utils.back') }}</button>
              </div>
            </DialogPanel>
          </TransitionChild>
        </div>
      </div>
    </Dialog>
  </TransitionRoot>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { Dialog, DialogDescription, DialogPanel, DialogTitle, TransitionChild, TransitionRoot, RadioGroup, RadioGroupOption } from '@headlessui/vue'
import { CheckIcon } from '@heroicons/vue/24/outline'
import { PhoneIcon, BanknotesIcon, CreditCardIcon, TruckIcon } from '@heroicons/vue/20/solid'
import { useI18n } from 'vue-i18n';
import { useSettingsStore } from '@/stores/settings';
import type { Tables } from '@/database/database.types'

const { t } = useI18n()
const settingsStore = useSettingsStore()

const selectedPaymentMethod = ref<Tables<'payment_methods'>>(settingsStore.payment_methods[0])

const open = defineModel({ default: false })
const emits = defineEmits<{
  close: any
}>()

function close() {
  open.value = false;
  emits('close')
}
</script>