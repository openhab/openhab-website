<template>
  <div class="blog-post">
    <div
      class="post-header"
      :style="frontmatter.previewimage ? { backgroundImage: 'url(' + withBase(frontmatter.previewimage) + ')' } : undefined"
    >
      <div class="post-cover">
        <h1 class="post-title">
          {{ frontmatter.title }}
        </h1>
      </div>
    </div>
    <div class="post-body">
      <div v-if="frontmatter.author || formattedDate" class="page-author">
        <span v-if="frontmatter.author"><strong>{{ frontmatter.author }}</strong></span>
        <span v-if="frontmatter.author && formattedDate"> posted on </span>
        <span v-if="formattedDate" style="white-space: nowrap">{{ formattedDate }}</span>
      </div>
      <div class="vp-doc">
        <Content />
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { useData, withBase } from 'vitepress'

const { frontmatter } = useData()

const formattedDate = computed(() => {
  if (!frontmatter.value.date) return ''
  try {
    const d = new Date(frontmatter.value.date)
    return d.toLocaleDateString('en-GB', { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' })
  } catch {
    return frontmatter.value.date
  }
})
</script>

<style scoped>
.blog-post {
  width: 100%;
}

.post-header {
  background-color: var(--vp-c-brand-1, #ff6600);
  background-size: cover !important;
  background-position: center !important;
  background-repeat: no-repeat !important;
  height: 280px;
  position: relative;
  overflow: hidden;
  text-align: center;
}

.post-cover {
  background-color: rgba(255, 102, 0, 0.72);
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 1.5rem;
}

:deep(.dark) .post-cover,
.dark .post-cover {
  background-color: rgba(127, 51, 0, 0.72);
}

.post-title {
  color: white;
  font-family: 'Open Sans', sans-serif;
  font-weight: 300;
  font-size: 2.5rem;
  margin: 0;
  text-align: center;
  max-width: 900px;
  text-shadow: 0 2px 8px rgba(0, 0, 0, 0.35);
  line-height: 1.25;
}

.post-body {
  max-width: 850px;
  margin: 2rem auto 4rem;
  padding: 0 1.5rem;
}

.page-author {
  font-size: 0.95rem;
  font-family: 'Open Sans', sans-serif;
  font-weight: 300;
  color: var(--vp-c-text-2, #666);
  text-align: center;
  margin-bottom: 2rem;
}

@media (max-width: 768px) {
  .post-header {
    height: 200px;
  }
  .post-title {
    font-size: 1.8rem;
  }
}
</style>
