import type { MergeDeep } from 'type-fest'
import type { Database as DatabaseGenerated } from './database-generated.types'

export type { Json } from './database-generated.types'

export type Database = MergeDeep<
  DatabaseGenerated,
  {
    public: {
      Views: {
        all_gifts: {
          Row: {
            id: number
            amount_gifted: number
            description: string
            image: string
            language: string
            parts: number
            price: number
            title: string
          }
        }
        gifts_visible: {
          Row: {
            id: number
            amount_gifted: number
            description: string
            image: string
            language: string
            parts: number
            price: number
            title: string
          }
        }
      }
    }
  }
>

export type { Tables, TablesInsert, TablesUpdate } from './database-generated.types'
