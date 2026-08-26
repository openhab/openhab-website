<template>
  <img :src="src ? withBase(src) : undefined" :style="{ height: imgHeight, verticalAlign: imgVerticalAlign }" :alt="alt || ''" />
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
const imgVerticalAlign = computed(() => props.verticalAlign || 'text-bottom')
</script>
