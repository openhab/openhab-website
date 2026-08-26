<template>
  <div class="blog-post">
    <div class="blog-header">
      <div class="header-inner">
        <h1 class="post-title">{{ frontmatter.title }}</h1>
        <div class="post-meta">
          <span v-if="frontmatter.author" class="meta-item">
            <strong>Author:</strong> {{ frontmatter.author }}
          </span>
          <span v-if="formattedDate" class="meta-item">
            <strong>Published:</strong> {{ formattedDate }}
          </span>
        </div>
      </div>
    </div>
    <div class="post-body">
      <div v-if="frontmatter.previewimage" class="preview-image-container">
        <img :src="withBase(frontmatter.previewimage)" :alt="frontmatter.title" class="preview-image" />
      </div>
      <div class="vp-doc">
        <Content />
      </div>
    </div>
    <Footer />
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { useData, withBase } from 'vitepress'
import Footer from '../components/Footer.vue'

const { frontmatter } = useData()

const formattedDate = computed(() => {
  if (!frontmatter.value.date) return ''
  try {
    const d = new Date(frontmatter.value.date)
    return d.toLocaleDateString('en-US', { year: 'numeric', month: 'long', day: 'numeric' })
  } catch {
    return frontmatter.value.date
  }
})
</script>

<style scoped>
.blog-post {
  width: 100%;
}
.blog-header {
  background: var(--vp-c-brand-1, #ff6600);
  padding: 3.5rem 1.5rem 2.5rem;
  color: white;
  text-align: center;
}
.header-inner {
  max-width: 800px;
  margin: 0 auto;
}
.post-title {
  font-family: 'Open Sans', sans-serif;
  font-size: 2.4rem;
  font-weight: 400;
  margin: 0 0 1rem;
  line-height: 1.25;
}
.post-meta {
  font-size: 0.95rem;
  opacity: 0.9;
  display: flex;
  justify-content: center;
  gap: 1.5rem;
  flex-wrap: wrap;
}
.post-body {
  max-width: 800px;
  margin: 2rem auto 4rem;
  padding: 0 1.5rem;
}
.preview-image-container {
  margin-bottom: 2rem;
  text-align: center;
}
.preview-image {
  max-width: 100%;
  border-radius: 8px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}
@media (max-width: 768px) {
  .post-title {
    font-size: 1.8rem;
  }
}
</style>
