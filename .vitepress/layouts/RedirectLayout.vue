<template>
  <div class="redirect-page">
    <p>Redirecting to <a :href="targetUrl">{{ targetUrl }}</a>...</p>
  </div>
</template>

<script setup lang="ts">
import { computed, onMounted } from 'vue'
import { useData } from 'vitepress'

const { frontmatter } = useData()

const targetUrl = computed(() => frontmatter.value.target || '/')

onMounted(() => {
  if (typeof window !== 'undefined' && targetUrl.value) {
    window.location.replace(targetUrl.value)
  }
})
</script>

<style scoped>
.redirect-page {
  padding: 4rem 2rem;
  text-align: center;
  font-family: 'Open Sans', sans-serif;
}
</style>
