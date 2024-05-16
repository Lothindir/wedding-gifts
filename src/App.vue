<script setup lang="ts">
import { RouterLink, RouterView } from 'vue-router'
import { supabase } from '../utils/supabase'
</script>

<template>
  <header>
    <h1 class="text-2xl font-bold p-4">Mariage de Katja & Francesco</h1>
  </header>
  <RouterView />
</template>
