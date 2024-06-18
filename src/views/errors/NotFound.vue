<template>
  <!--
    This example requires updating your template:

    ```
    <html class="h-full">
    <body class="h-full">
    ```
  -->
  <div class="grid min-h-full grid-cols-1 grid-rows-[1fr,auto,1fr] bg-white lg:grid-cols-[max(50%,36rem),1fr]">
    <header class="mx-auto w-full max-w-7xl px-6 pt-6 sm:pt-10 lg:col-span-2 lg:col-start-1 lg:row-start-1 lg:px-8">
      <a href="#">
        <span class="sr-only">{{ t("errors.home") }}</span>
        <img class="h-10 w-auto sm:h-12" :src="logo" alt="Logo" />
      </a>
    </header>
    <main class="mx-auto w-full max-w-7xl px-6 py-24 sm:py-32 lg:col-span-2 lg:col-start-1 lg:row-start-2 lg:px-8">
      <div class="max-w-lg">
        <p class="text-base font-semibold leading-8 text-indigo-600">404</p>
        <h1 class="mt-4 text-3xl font-bold tracking-tight text-gray-900 sm:text-5xl">{{ t("errors.404.title") }}</h1>
        <p class="mt-6 text-base leading-7 text-gray-600">{{ message }}</p>
        <div class="mt-10">
          <a href="#" class="text-sm font-semibold leading-7 text-indigo-600"><span aria-hidden="true">&larr;</span>
            {{ t("errors.home-message") }}</a>
        </div>
      </div>
    </main>
    <div class="hidden lg:relative lg:col-start-2 lg:row-start-1 lg:row-end-4 lg:block">
      <img
        src="https://images.unsplash.com/photo-1470847355775-e0e3c35a9a2c?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1825&q=80"
        alt="" class="absolute inset-0 h-full w-full object-cover" />
    </div>
  </div>
</template>

<script setup lang="ts">
import { useHead } from '@unhead/vue'
import { useI18n } from 'vue-i18n';
import { useRoute, useRouter } from 'vue-router';
import { onMounted, ref, watch } from 'vue';

import logo from '@/assets/logo.svg'

useHead({
  bodyAttrs: {
    class: 'h-full',
  },
  htmlAttrs: {
    class: 'h-full',
  },
});

const { t } = useI18n();
const route = useRoute();
const router = useRouter();

const message = ref('')

onMounted(() => {
  if (route.params.pathMatch === 'unknown locale')
    message.value = t('errors.404.language')
  else
    message.value = t('errors.404.description')
  if (route.params.pathMatch !== '404')
    router.replace({ name: 'not-found', params: { pathMatch: '404' } })
})
</script>