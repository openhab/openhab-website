<template>
  <div class="prop-option">
    <dt><code>{{ value }}</code></dt>
    <dd>{{ label }}</dd>
  </div>
</template>

<script setup lang="ts">
defineProps<{
  value?: string
  label?: string
}>()
</script>
