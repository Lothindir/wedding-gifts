<template>
  <TransitionRoot as="template" :show="open">
    <Dialog class="relative z-10" @close="open = false">
      <TransitionChild
        as="template"
        enter="ease-out duration-300"
        enter-from="opacity-0"
        enter-to="opacity-100"
        leave="ease-in duration-200"
        leave-from="opacity-100"
        leave-to="opacity-0"
      >
        <div class="fixed inset-0 hidden bg-gray-500 bg-opacity-75 transition-opacity md:block" />
      </TransitionChild>

      <div class="fixed inset-0 z-10 w-screen overflow-y-auto">
        <div
          class="flex min-h-full items-stretch justify-center text-center md:items-center md:px-2 lg:px-4"
        >
          <TransitionChild
            as="template"
            enter="ease-out duration-300"
            enter-from="opacity-0 translate-y-4 md:translate-y-0 md:scale-95"
            enter-to="opacity-100 translate-y-0 md:scale-100"
            leave="ease-in duration-200"
            leave-from="opacity-100 translate-y-0 md:scale-100"
            leave-to="opacity-0 translate-y-4 md:translate-y-0 md:scale-95"
          >
            <DialogPanel
              class="flex w-full transform text-left text-base transition md:my-8 md:max-w-2xl md:px-4 lg:max-w-4xl"
            >
              <div
                class="relative flex w-full items-center overflow-hidden bg-white px-4 pb-8 pt-14 shadow-2xl sm:px-6 sm:pt-8 md:p-6 lg:p-8"
              >
                <button
                  type="button"
                  class="absolute right-4 top-4 text-gray-400 hover:text-gray-500 sm:right-6 sm:top-8 md:right-6 md:top-6 lg:right-8 lg:top-8"
                  @click="open = false"
                >
                  <span class="sr-only">{{ t('utils.close') }}</span>
                  <XMarkIcon class="h-12 w-12 sm:h-6 sm:w-6" aria-hidden="true" />
                </button>

                <div
                  class="grid w-full grid-cols-1 items-start gap-x-6 gap-y-8 sm:grid-cols-12 lg:gap-x-8"
                >
                  <div class="sm:col-span-4 lg:col-span-5">
                    <div class="aspect-h-1 aspect-w-1 overflow-hidden rounded-lg bg-gray-100">
                      <img
                        :src="gift!.image!"
                        :alt="gift!.title!"
                        class="object-cover object-center"
                      />
                    </div>
                  </div>
                  <div class="sm:col-span-8 lg:col-span-7">
                    <h2 class="text-2xl font-bold text-gray-900 sm:pr-12">{{ gift?.title }}</h2>

                    <section aria-labelledby="information-heading" class="mt-3">
                      <h3 id="information-heading" class="sr-only">
                        {{ t('gift.product_information') }}
                      </h3>

                      <p class="text-2xl text-gray-900" v-if="!isFreeParticipation">
                        {{ gift?.price }} {{ settingsStore.currency }}
                      </p>

                      <div class="mt-6">
                        <h4 class="sr-only">{{ t('gift.description') }}</h4>

                        <p class="text-sm text-gray-700">{{ gift?.description }}</p>
                      </div>
                    </section>

                    <section aria-labelledby="options-heading" class="mt-6">
                      <h3 id="options-heading" class="sr-only">{{ t('gift.participate') }}</h3>

                      <form>
                        <GiftPrice
                          :total-price="gift!.price!"
                          :gifted-amount="gift!.amount_gifted"
                          :giftable="false"
                          v-if="pricingMode"
                        />
                        <GiftParts
                          :total-parts="gift!.parts!"
                          :gifted-parts="gift!.amount_gifted"
                          :giftable="false"
                          :part-price="gift!.price!"
                          v-else
                        />

                        <div class="flex justify-between mt-2">
                          <label
                            for="price"
                            class="inline text-sm font-medium mt-1 align-middle leading-6 text-gray-900"
                            >{{ t('gift.amount_gifted') }}</label
                          >

                          <!-- Price -->
                          <div class="relative rounded-md shadow-sm" v-if="pricingMode">
                            <input
                              type="text"
                              name="price"
                              id="price"
                              class="w-full rounded-md border-0 py-1.5 pl-2 pr-12 text-gray-900 ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
                              placeholder="0.00"
                              aria-describedby="price-currency"
                              v-model="amount"
                              min="0"
                              :max="remainingAmount"
                            />
                            <div
                              class="pointer-events-none absolute inset-y-0 right-0 flex items-center pr-3"
                            >
                              <span class="text-gray-500 sm:text-sm" id="price-currency">{{
                                settingsStore.currency
                              }}</span>
                            </div>
                          </div>

                          <!-- Parts -->
                          <div class="relative rounded-md shadow-sm" v-else>
                            <select
                              id="parts"
                              name="parts"
                              v-model="amount"
                              class="mt-2 w-full rounded-md border-0 py-1.5 pl-3 pr-10 text-gray-900 ring-1 ring-inset ring-gray-300 focus:ring-2 focus:ring-indigo-600 sm:text-sm sm:leading-6"
                            >
                              <option disabled value="0">{{ t('gift.select_amount') }}</option>
                              <option v-for="i in remainingAmount" :key="i" :value="i">
                                {{ i }}
                              </option>
                            </select>
                          </div>
                        </div>

                        <div class="mt-6 flex space-x-2 w-full">
                          <button
                            type="submit"
                            @click.prevent="addToCart(false)"
                            class="items-center justify-center rounded-md border border-transparent bg-indigo-600 px-2 sm:px-8 py-3 text-base font-medium text-white hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2 focus:ring-offset-gray-50"
                          >
                            {{ t('gift.add_to_cart_checkout') }}
                          </button>
                          <button
                            type="submit"
                            @click.prevent="addToCart(true)"
                            class="w-full items-center justify-center rounded-md border border-transparent bg-gray-200 px-2 sm:px-8 py-3 text-base font-medium text-gray-900 hover:bg-gray-300 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2 focus:ring-offset-gray-50"
                          >
                            {{ t('gift.add_to_cart_continue') }}
                          </button>
                        </div>
                      </form>
                    </section>
                  </div>
                </div>
              </div>
            </DialogPanel>
          </TransitionChild>
        </div>
      </div>
    </Dialog>
  </TransitionRoot>
</template>

<script setup lang="ts">
import { computed, onBeforeUpdate, ref } from 'vue'
import { Dialog, DialogPanel, TransitionChild, TransitionRoot } from '@headlessui/vue'
import { XMarkIcon } from '@heroicons/vue/24/outline'
import { useGiftsStore } from '@/stores/gifts'
import { useSettingsStore } from '@/stores/settings'
import { useCartStore } from '@/stores/cart'
import { useI18n } from 'vue-i18n'
import GiftParts from './GiftParts.vue'
import GiftPrice from './GiftPrice.vue'
import { useToast } from 'vue-toast-notification'
import { useRouter } from 'vue-router'

const props = defineProps<{
  id: number
}>()

const giftsStore = useGiftsStore()
const settingsStore = useSettingsStore()
const cartStore = useCartStore()
const router = useRouter()
const toast = useToast()
const { t } = useI18n()

const gift = computed(() => giftsStore.getGiftById(props.id))
const isFreeParticipation = computed(() => gift.value!.price == 0)
const pricingMode = computed(() => gift.value && gift.value.parts == 0)
const remainingAmount = computed(() => {
  if (pricingMode.value) return gift.value!.price! - gift.value!.amount_gifted!
  return gift.value!.parts! - gift.value!.amount_gifted!
})
const amount = ref(0)

const open = defineModel({ default: false })

function addToCart(continueShopping: boolean = false) {
  if (amount.value <= 0 || isNaN(amount.value)) {
    toast.error(t('errors.enter_valid_amount'))
    return
  }
  if (amount.value > remainingAmount.value && !isFreeParticipation.value) {
    toast.error(t('errors.amount_exceeds_remaining'))
    return
  }

  if (pricingMode.value) {
    cartStore.addToCart({
      id: gift.value!.id!,
      title: gift.value!.title!,
      quantity: 1,
      cost: amount.value,
      img: gift.value!.image!,
      mode: 'price',
    })
  } else {
    cartStore.addToCart({
      id: gift.value!.id!,
      title: gift.value!.title!,
      quantity: amount.value,
      cost: gift.value!.price!,
      img: gift.value!.image!,
      mode: 'parts',
    })
  }

  toast.success(t('gift.added_to_cart'))

  if (continueShopping) open.value = false
  else router.push('/checkout')
}

onBeforeUpdate(() => {
  amount.value = cartStore.getAmountById(props.id, pricingMode.value ? 'price' : 'parts')
})
</script>
