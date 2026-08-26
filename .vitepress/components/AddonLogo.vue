<template>
  <img v-if="logoSrc" :src="logoSrc" class="addon-logo" :alt="frontmatter.label || 'Addon logo'" />
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { useData, withBase } from 'vitepress'

const { frontmatter } = useData()

const logoSrc = computed(() => {
  if (!frontmatter.value.logo) return null
  const cleanPath = frontmatter.value.logo.replace('images/addons/', '/logos/')
  return withBase(cleanPath)
})
</script>

<style scoped>
@media (min-width: 720px) {
  .addon-logo {
    float: right;
    margin-left: 4rem;
    margin-top: -3.5rem;
  }
}
.addon-logo {
  width: 200px;
  height: 200px;
  object-fit: contain;
  padding: 5px;
}
</style>
