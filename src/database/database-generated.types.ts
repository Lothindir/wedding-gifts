export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export type Database = {
  public: {
    Tables: {
      donors: {
        Row: {
          address: string
          email: string
          id: number
          name: string
          surname: string
        }
        Insert: {
          address?: string
          email?: string
          id?: number
          name: string
          surname: string
        }
        Update: {
          address?: string
          email?: string
          id?: number
          name?: string
          surname?: string
        }
        Relationships: []
      }
      gift_translations: {
        Row: {
          description: string
          gift: number
          id: number
          language: string
          title: string
        }
        Insert: {
          description?: string
          gift: number
          id?: number
          language: string
          title: string
        }
        Update: {
          description?: string
          gift?: number
          id?: number
          language?: string
          title?: string
        }
        Relationships: [
          {
            foreignKeyName: "gift_translations_gift_fkey"
            columns: ["gift"]
            isOneToOne: false
            referencedRelation: "all_gifts"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "gift_translations_gift_fkey"
            columns: ["gift"]
            isOneToOne: false
            referencedRelation: "gifts"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "gift_translations_gift_fkey"
            columns: ["gift"]
            isOneToOne: false
            referencedRelation: "gifts_visible"
            referencedColumns: ["id"]
          },
        ]
      }
      gifts: {
        Row: {
          hidden: boolean
          id: number
          image: string
          parts: number
          price: number
        }
        Insert: {
          hidden?: boolean
          id?: number
          image?: string
          parts?: number
          price: number
        }
        Update: {
          hidden?: boolean
          id?: number
          image?: string
          parts?: number
          price?: number
        }
        Relationships: []
      }
      settings: {
        Row: {
          id: number
          key: string
          value: string
        }
        Insert: {
          id?: number
          key: string
          value: string
        }
        Update: {
          id?: number
          key?: string
          value?: string
        }
        Relationships: []
      }
      transactions: {
        Row: {
          amount: number
          created_at: string
          donor: number
          gift: number
          id: number
        }
        Insert: {
          amount: number
          created_at?: string
          donor: number
          gift: number
          id?: number
        }
        Update: {
          amount?: number
          created_at?: string
          donor?: number
          gift?: number
          id?: number
        }
        Relationships: [
          {
            foreignKeyName: "transactions_donor_fkey"
            columns: ["donor"]
            isOneToOne: false
            referencedRelation: "donors"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "transactions_gift_fkey"
            columns: ["gift"]
            isOneToOne: false
            referencedRelation: "all_gifts"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "transactions_gift_fkey"
            columns: ["gift"]
            isOneToOne: false
            referencedRelation: "gifts"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "transactions_gift_fkey"
            columns: ["gift"]
            isOneToOne: false
            referencedRelation: "gifts_visible"
            referencedColumns: ["id"]
          },
        ]
      }
    }
    Views: {
      all_gifts: {
        Row: {
          amount_gifted: number | null
          description: string | null
          id: number | null
          image: string | null
          language: string | null
          parts: number | null
          price: number | null
          title: string | null
        }
        Relationships: []
      }
      gifts_visible: {
        Row: {
          amount_gifted: number | null
          description: string | null
          id: number | null
          image: string | null
          language: string | null
          parts: number | null
          price: number | null
          title: string | null
        }
        Relationships: []
      }
    }
    Functions: {
      [_ in never]: never
    }
    Enums: {
      [_ in never]: never
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
}

type PublicSchema = Database[Extract<keyof Database, "public">]

export type Tables<
  PublicTableNameOrOptions extends
    | keyof (PublicSchema["Tables"] & PublicSchema["Views"])
    | { schema: keyof Database },
  TableName extends PublicTableNameOrOptions extends { schema: keyof Database }
    ? keyof (Database[PublicTableNameOrOptions["schema"]]["Tables"] &
        Database[PublicTableNameOrOptions["schema"]]["Views"])
    : never = never,
> = PublicTableNameOrOptions extends { schema: keyof Database }
  ? (Database[PublicTableNameOrOptions["schema"]]["Tables"] &
      Database[PublicTableNameOrOptions["schema"]]["Views"])[TableName] extends {
      Row: infer R
    }
    ? R
    : never
  : PublicTableNameOrOptions extends keyof (PublicSchema["Tables"] &
        PublicSchema["Views"])
    ? (PublicSchema["Tables"] &
        PublicSchema["Views"])[PublicTableNameOrOptions] extends {
        Row: infer R
      }
      ? R
      : never
    : never

export type TablesInsert<
  PublicTableNameOrOptions extends
    | keyof PublicSchema["Tables"]
    | { schema: keyof Database },
  TableName extends PublicTableNameOrOptions extends { schema: keyof Database }
    ? keyof Database[PublicTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = PublicTableNameOrOptions extends { schema: keyof Database }
  ? Database[PublicTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Insert: infer I
    }
    ? I
    : never
  : PublicTableNameOrOptions extends keyof PublicSchema["Tables"]
    ? PublicSchema["Tables"][PublicTableNameOrOptions] extends {
        Insert: infer I
      }
      ? I
      : never
    : never

export type TablesUpdate<
  PublicTableNameOrOptions extends
    | keyof PublicSchema["Tables"]
    | { schema: keyof Database },
  TableName extends PublicTableNameOrOptions extends { schema: keyof Database }
    ? keyof Database[PublicTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = PublicTableNameOrOptions extends { schema: keyof Database }
  ? Database[PublicTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Update: infer U
    }
    ? U
    : never
  : PublicTableNameOrOptions extends keyof PublicSchema["Tables"]
    ? PublicSchema["Tables"][PublicTableNameOrOptions] extends {
        Update: infer U
      }
      ? U
      : never
    : never

export type Enums<
  PublicEnumNameOrOptions extends
    | keyof PublicSchema["Enums"]
    | { schema: keyof Database },
  EnumName extends PublicEnumNameOrOptions extends { schema: keyof Database }
    ? keyof Database[PublicEnumNameOrOptions["schema"]]["Enums"]
    : never = never,
> = PublicEnumNameOrOptions extends { schema: keyof Database }
  ? Database[PublicEnumNameOrOptions["schema"]]["Enums"][EnumName]
  : PublicEnumNameOrOptions extends keyof PublicSchema["Enums"]
    ? PublicSchema["Enums"][PublicEnumNameOrOptions]
    : never
