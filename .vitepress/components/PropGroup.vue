<template>
  <div class="prop-group">
    <slot />
  </div>
</template>

<script setup lang="ts">
defineProps<{
  name?: string
  label?: string
}>()
</script>

<style scoped>
:deep(h3.prop-group-header) {
  margin-top: -3.5rem;
  padding-top: 4.6rem;
}
</style>
