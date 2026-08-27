<template>
  <div ref="el" :class="classes">
    <slot></slot>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'

defineProps<{
  classes?: string
}>()

const el = ref<HTMLElement | null>(null)

onMounted(async () => {
  if (el.value) {
    const ScrollReveal = (await import('scrollreveal')).default
    ScrollReveal().reveal(el.value, { delay: 250 })
  }
})
</script>
