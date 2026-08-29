<template>
  <img
    class="inline-image"
    :src="src ? withBase(src) : undefined"
    :style="{
      display: 'inline-block',
      height: imgHeight,
      verticalAlign: imgVerticalAlign,
    }"
    :alt="alt || ''"
  />
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { withBase } from 'vitepress'

const props = defineProps<{
  src?: string
  alt?: string
  height?: string
  verticalAlign?: string
}>()

const imgHeight = computed(() => props.height || '1.5em')
const imgVerticalAlign = computed(() => props.verticalAlign || 'middle')
</script>

<style scoped>
.inline-image,
img {
  display: inline-block !important;
  max-width: none;
}
</style>
