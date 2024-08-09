<template>
  <button
    class="center text-md font-bold bg-teal-400 text-gray-700 mt-4 px-2 py-1 rounded-md"
    v-if="active"
    @click="$emit('contribute')"
  >
    <GiftIcon></GiftIcon>
    {{ t('gift.contribute') }}
  </button>
  <div class="disable center text-md font-bold text-green-600 mt-4 px-2 py-1" disabled v-else>
    <CheckIcon> </CheckIcon>{{ t('gift.already_contributed') }}
  </div>
</template>

<script setup lang="ts">
import { useI18n } from 'vue-i18n'
import { GiftIcon, CheckIcon } from '@heroicons/vue/20/solid'

defineProps<{
  active: boolean
}>()

const { t } = useI18n()
</script>
