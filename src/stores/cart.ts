import { ref } from 'vue'
import { defineStore } from 'pinia'
import { supabase } from '@/database/supabase'
import type { TablesInsert } from '@/database/database.types'

export interface CartItem {
  id: number
  title: string
  quantity: number
  cost: number
  img: string
  mode: 'price' | 'parts'
}

export interface Purchaser {
  name: string
  surname: string
  email: string
  address?: string
  postalCode?: string
  city?: string
  country?: string
  message?: string
}

export const useCartStore = defineStore('cart', () => {
  const cart = ref<CartItem[]>([])
  const cartCount = ref(0)

  function addToCart(item: CartItem) {
    const existingItem = cart.value.find((cartItem) => cartItem.id === item.id)

    if (existingItem && item.mode == 'parts') {
      existingItem.quantity = item.quantity
    } else if (existingItem) {
      existingItem.cost = item.cost
    } else {
      cart.value.push(item)
      cartCount.value++
    }
  }

  function removeFromCart(id: number) {
    const index = cart.value.findIndex((cartItem) => cartItem.id === id)

    if (index !== -1) {
      cart.value.splice(index, 1)
      cartCount.value--
    }
  }

  function clearCart() {
    cart.value = []
    cartCount.value = 0
  }

  function total() {
    return cart.value.reduce((acc, item) => acc + item.cost * item.quantity, 0)
  }

  function getAmountById(id: number, mode: 'price' | 'parts') {
    const item = cart.value.find((cartItem) => cartItem.id === id)

    if (item) {
      if (mode == 'parts') {
        return item.quantity
      } else {
        return item.cost
      }
    }

    return 0
  }

  function getCart() {
    // Clone the cart to prevent mutation
    return cart.value.map((item) => ({ ...item }))
  }

  async function purchase(purchaser: Purchaser) {
    const donor: TablesInsert<'donors'> = {
      name: purchaser.name,
      surname: purchaser.surname,
      email: purchaser.email,
      address:
        purchaser.address +
        ', ' +
        purchaser.postalCode +
        ' ' +
        purchaser.city +
        ', ' +
        purchaser.country,
    }

    const res = await supabase.from('donors').insert(donor).select('id').single()

    if (res.error) {
      throw new Error(res.error.message)
    }
    for (const gift of cart.value) {
      const data: TablesInsert<'transactions'> = {
        amount: gift.quantity ? gift.quantity : gift.cost,
        donor: res.data!.id,
        gift: gift.id,
      }

      supabase.from('transactions').insert([data])
    }
  }

  return {
    cartCount,
    cart,
    addToCart,
    removeFromCart,
    clearCart,
    total,
    purchase,
    getAmountById,
    getCart,
  }
})
