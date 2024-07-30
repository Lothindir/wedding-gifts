<template>
  <div class="bg-gray-300 w-full p-4 flex flex-col flex-1">
    <h2 class="text-4xl my-4 font-medium text-gray-900">Actions</h2>
    <ul role="list" class="grid grid-cols-1 gap-5 sm:grid-cols-2 sm:gap-6 lg:grid-cols-4">
      <li v-for="action in actions" :key="action.name" class="col-span-1 flex rounded-md shadow-sm">
        <div
          :class="[
            action.bgColor,
            'flex w-16 flex-shrink-0 items-center justify-center rounded-l-md text-sm font-medium text-white',
          ]"
        >
          {{ action.initials }}
        </div>
        <div
          class="flex flex-1 items-center justify-between truncate rounded-r-md border-b border-r border-t border-gray-200 bg-white"
        >
          <div class="flex-1 truncate px-4 py-2 text-sm">
            <a :href="action.href" class="font-medium text-gray-900 hover:text-gray-600">{{
              action.name
            }}</a>
          </div>
          <div class="flex-shrink-0 pr-2">
            <button
              type="button"
              class="inline-flex h-8 w-8 items-center justify-center rounded-full bg-transparent bg-white text-gray-400 hover:text-gray-500 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2"
            >
              <span class="sr-only">Open options</span>
              <EllipsisVerticalIcon class="h-5 w-5" aria-hidden="true" />
            </button>
          </div>
        </div>
      </li>
    </ul>
  </div>
</template>

<script setup lang="ts">
import { EllipsisVerticalIcon } from '@heroicons/vue/20/solid'

const actions = [
  { name: 'View all gifts', initials: 'G', href: '/admin/gifts', bgColor: 'bg-pink-600' },
  { name: 'View donors', initials: 'D', href: '#', bgColor: 'bg-purple-600' },
  { name: 'View transactions', initials: 'T', href: '#', bgColor: 'bg-yellow-500' },
  { name: 'View users', initials: 'U', href: '#', bgColor: 'bg-blue-600' },
]
</script>
