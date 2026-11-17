<template>
  <div class="tweet-embed">
    <a
      :href="`https://x.com/i/web/status/${id}`"
      target="_blank"
      rel="noopener noreferrer"
    >
      View post on X
    </a>
  </div>
</template>

<script setup lang="ts">
defineProps<{
  id: string
}>()
</script>

<style scoped>
.tweet-embed {
  display: flex;
  justify-content: center;
  margin: 0.75rem 0;
  width: 100%;
}
</style>
