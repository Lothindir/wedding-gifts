<template>
  <main>
    <div class="bg-white relative">
      <!-- Background color split screen for large screens -->
      <div class="absolute left-0 top-0 hidden h-full w-1/2 bg-white lg:block" aria-hidden="true" />
      <div class="absolute right-0 top-0 hidden h-full w-1/2 bg-gray-50 lg:block" aria-hidden="true" />

      <div class="relative mx-auto grid max-w-7xl grid-cols-1 gap-x-16 lg:grid-cols-2 lg:px-8 xl:gap-x-48">
        <h1 class="sr-only">{{ t('checkout.order_information') }}</h1>

        <section aria-labelledby="summary-heading"
          class="bg-gray-50 px-4 pb-10 pt-16 sm:px-6 lg:col-start-2 lg:row-start-1 lg:bg-transparent lg:px-0 lg:pb-16">
          <div class="mx-auto max-w-lg lg:max-w-none">
            <h2 id="summary-heading" class="text-lg font-medium text-gray-900">{{ t('checkout.order_summary') }}</h2>

            <ul role="list" class="divide-y divide-gray-200 text-sm font-medium text-gray-900">
              <li class="flex items-start space-x-4 py-6" v-for="gift in cartStore.getCart()" :key="gift.id">
                <img :src="gift.img" :alt="gift.title"
                  class="h-20 w-20 flex-none rounded-md object-cover object-center" />
                <div class="flex-auto space-y-1 mt-4 relative">
                  <h3>{{ gift.title }}</h3>
                  <p class="text-gray-500" v-if="gift.mode == 'parts'">{{ t('checkout.quantity') + ' ' + gift.quantity
                    }}</p>
                  <TrashIcon class="w-6 text-gray-700 absolute inset-y-0 right-0 hover:cursor-pointer"
                    @click="deleteItem(gift.id)" />
                </div>
                <p class="flex-none text-base font-medium">{{ settingsStore.currency + ' ' + gift.cost *
                  gift.quantity
                  }}</p>
              </li>
            </ul>

            <dl class="hidden space-y-6 border-t border-gray-200 pt-6 text-gray-900 lg:block">
              <div class="flex items-center justify-between">
                <dt class="text-xl">{{ t('checkout.total') }}</dt>
                <dd class="text-xl">{{ settingsStore.currency + ' ' + cartStore.total() }}</dd>
              </div>
            </dl>
          </div>

          <form class="mt-2">
            <Checkbox v-model="recaptchaResponse" />
            <div class="mt-6 flex space-x-2 w-full">
              <button type="button" @click.prevent="checkout" :disabled="cartStore.cartCount <= 0 || !recaptchaResponse"
                class="w-full items-center justify-center rounded-md border border-transparent bg-indigo-600 px-8 py-3 text-base font-medium text-white hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2 focus:ring-offset-gray-50 disabled:cursor-not-allowed disabled:bg-gray-800 disabled:hover:bg-gray-800">{{
                  t('checkout.confirm') }}</button>
              <button type="button" @click="$router.push('/')"
                class="w-full items-center justify-center rounded-md border border-transparent bg-gray-200 px-8 py-3 text-base font-medium text-gray-900 hover:bg-gray-300 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2 focus:ring-offset-gray-50">{{
                  t('utils.back') }}</button>
            </div>
          </form>
        </section>

        <form class="px-4 pb-36 pt-16 sm:px-6 lg:col-start-1 lg:row-start-1 lg:px-0 lg:pb-16">
          <div>
            <div>
              <h2 class="text-lg font-medium text-gray-900">{{ t('checkout.personal_information') }}</h2>
              <div class="mt-4 grid grid-cols-1 gap-y-6 sm:grid-cols-2 sm:gap-x-4">
                <div>
                  <label for="first-name" class="block text-sm font-medium text-gray-700">{{ t('checkout.first_name')
                    }} <span class="text-red-500">*</span></label>
                  <div class="mt-1">
                    <input type="text" id="first-name" name="first-name" autocomplete="given-name" required
                      v-model="purchaserForm.firstName"
                      class="block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm" />
                  </div>
                </div>

                <div>
                  <label for="last-name" class="block text-sm font-medium text-gray-700">{{ t('checkout.last_name')
                    }} <span class="text-red-500">*</span></label>
                  <div class="mt-1">
                    <input type="text" id="last-name" name="last-name" autocomplete="family-name" required
                      v-model="purchaserForm.lastName"
                      class="block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm" />
                  </div>
                </div>

                <div class="sm:col-span-2">
                  <label for="email-address" class="block text-sm font-medium text-gray-700">{{ t('checkout.email')
                    }} <span class="text-red-500">*</span></label>
                  <div class="mt-1">
                    <input type="email" id="email-address" name="email-address" autocomplete="email" required
                      v-model="purchaserForm.email"
                      class="block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm" />
                  </div>
                </div>
              </div>
            </div>

            <div class="mt-8 border-t border-gray-200 pt-4">
              <h2 class="text-lg font-medium text-gray-900">{{ t('checkout.aknowledgements_information') }}</h2>

              <div class="mt-4 grid grid-cols-1 gap-y-6 sm:grid-cols-2 sm:gap-x-4">
                <div class="sm:col-span-2">
                  <label for="address" class="block text-sm font-medium text-gray-700">{{ t('checkout.address')
                    }}</label>
                  <div class="mt-1">
                    <input type="text" name="address" id="address" autocomplete="street-address"
                      v-model="purchaserForm.address"
                      class="block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm" />
                  </div>
                </div>

                <div>
                  <label for="postal-code" class="block text-sm font-medium text-gray-700">{{
                    t('checkout.postal_code')
                    }}</label>
                  <div class="mt-1">
                    <input type="text" name="postal-code" id="postal-code" autocomplete="postal-code"
                      v-model="purchaserForm.postalCode"
                      class="block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm" />
                  </div>
                </div>

                <div>
                  <label for="city" class="block text-sm font-medium text-gray-700">{{ t('checkout.city') }}</label>
                  <div class="mt-1">
                    <input type="text" name="city" id="city" autocomplete="address-level2" v-model="purchaserForm.city"
                      class="block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm" />
                  </div>
                </div>

                <div>
                  <label for="country" class="block text-sm font-medium text-gray-700">{{ t('checkout.country')
                    }}</label>
                  <div class="mt-1">
                    <input type="text" name="city" id="city" autocomplete="country" v-model="purchaserForm.country"
                      class="block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500
                    focus:ring-indigo-500 sm:text-sm" />
                  </div>
                </div>
              </div>

              <div class="mt-8 border-t border-gray-200 pt-4">
                <label for="message">
                  <h2 class="text-lg font-medium text-gray-900">{{ t('checkout.message_information') }}
                  </h2>
                </label>

                <div>
                  <div class="mt-1">
                    <textarea rows="4" name="message" id="message" v-model="purchaserForm.message"
                      class="block w-full rounded-md border-0 py-1.5 px-1 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6" />
                  </div>
                </div>
              </div>
            </div>

            <div class="mt-8 text-sm text-gray-700"><span class="text-red-500">*</span> {{ t('checkout.required') }}
            </div>
          </div>
        </form>
      </div>
    </div>
    <CheckoutModal v-model="checkoutModal" @close="closeModal" />
  </main>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { TrashIcon } from '@heroicons/vue/20/solid'
import CheckoutModal from '@/components/CheckoutModal.vue';
import { useCartStore, type Purchaser } from '@/stores/cart';
import { useSettingsStore } from '@/stores/settings';
import { useI18n } from 'vue-i18n';
import { useRouter } from 'vue-router';
import { useToast } from 'vue-toast-notification';
import { Checkbox } from 'vue-recaptcha';

const cartStore = useCartStore()
const settingsStore = useSettingsStore()
const router = useRouter()
const { t } = useI18n()
const toast = useToast();
const recaptchaResponse = ref('')
const purchaserForm = ref({
  firstName: '',
  lastName: '',
  email: '',
  address: '',
  postalCode: '',
  city: '',
  country: '',
  message: ''
})

const checkoutModal = ref(false)

function checkInformations(): boolean {
  let valid = true

  if (purchaserForm.value.firstName == '') {
    toast.error(t('checkout.errors.fill_first_name'))
    valid = false
  }

  if (!purchaserForm.value.lastName) {
    toast.error(t('checkout.errors.fill_last_name'))
    valid = false
  }

  if (purchaserForm.value.email == '') {
    toast.error(t('checkout.errors.fill_email'))
    valid = false
  }
  else {
    const re = /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
    if (!purchaserForm.value.email.match(re)) {
      toast.error(t('checkout.errors.invalid_email'))
      valid = false
    }
  }

  return valid
}

async function checkout() {
  console.log('Checkout')
  if (!checkInformations() || !recaptchaResponse.value) return
  checkoutModal.value = true
  let purchaser: Purchaser = {
    name: purchaserForm.value.firstName,
    surname: purchaserForm.value.lastName,
    email: purchaserForm.value.email,
    address: purchaserForm.value.address,
    postalCode: purchaserForm.value.postalCode,
    city: purchaserForm.value.city,
    country: purchaserForm.value.country,
    message: purchaserForm.value.message
  }

  cartStore.purchase(purchaser)
}

function deleteItem(id: number) {
  cartStore.removeFromCart(id)
}

function closeModal() {
  checkoutModal.value = false
  cartStore.clearCart()
  router.push('/')
}
</script>

<style scoped>
input {
  @apply px-1 h-8 text-gray-700 border border-gray-300 focus:ring focus:ring-indigo-500 rounded-md shadow-sm;
}
</style>