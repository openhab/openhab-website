<template>
  <div class="redirect-container"></div>
</template>

<script setup lang="ts">
import { onMounted } from 'vue'
import { useData } from 'vitepress'

const { frontmatter } = useData()

onMounted(() => {
  const target = frontmatter.value.redirect_to
  if (target) {
    window.location.href = target
  }
})
</script>
