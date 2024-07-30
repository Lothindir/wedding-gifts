import { ref } from 'vue'
import { defineStore } from 'pinia'
import { supabase } from '@/database/supabase'
import type { TablesInsert } from '@/database/database.types'
import emailjs from '@emailjs/browser'

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

  async function purchase(purchaser: Purchaser, locale: string): Promise<boolean> {
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

    const donor_res = await supabase.from('donors').insert(donor).select('id').single()

    if (donor_res.error) {
      console.error(donor_res.error)
      return false
    }

    const data: TablesInsert<'transactions'>[] = []
    for (const gift of cart.value) {
      const t: TablesInsert<'transactions'> = {
        amount: gift.mode === 'parts' ? gift.quantity : gift.cost,
        donor: donor_res.data!.id,
        gift: gift.id,
      }
      data.push(t)
    }
    const t_res = await supabase.from('transactions').insert(data)
    if (t_res.error) {
      console.error(t_res.error)
      return false
    }

    const res = await emailjs.send(
      'contact_katjafrancesco',
      'gift_confirmation_' + locale,
      {
        first_name: purchaser.name,
        last_name: purchaser.surname,
        email: purchaser.email,
        amount_gifted: total(),
      },
      { publicKey: 'jb5DTi7ejZOMKTCBs' }
    )

    if (res.status !== 200) {
      console.error(res)
      return false
    }

    return true
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
