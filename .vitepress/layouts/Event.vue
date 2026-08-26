<template>
  <div class="event-page">
    <div class="event-header">
      <div class="header-inner">
        <h1 class="event-title">{{ frontmatter.title }}</h1>
        <div class="event-meta">
          <span v-if="frontmatter.date" class="meta-item">
            <strong>Date:</strong> {{ frontmatter.date }}
            <span v-if="frontmatter.end_date"> - {{ frontmatter.end_date }}</span>
          </span>
          <span v-if="frontmatter.location" class="meta-item">
            <strong>Location:</strong> {{ frontmatter.location }}
          </span>
        </div>
      </div>
    </div>
    <div class="event-body">
      <div v-if="frontmatter.event_image" class="preview-image-container">
        <img :src="withBase(frontmatter.event_image)" :alt="frontmatter.title" class="preview-image" />
      </div>
      <div class="vp-doc">
        <Content />
      </div>
    </div>
    <Footer />
  </div>
</template>

<script setup lang="ts">
import { useData, withBase } from 'vitepress'
import Footer from '../components/Footer.vue'

const { frontmatter } = useData()
</script>

<style scoped>
.event-page {
  width: 100%;
}
.event-header {
  background: var(--vp-c-brand-1, #ff6600);
  padding: 3.5rem 1.5rem 2.5rem;
  color: white;
  text-align: center;
}
.header-inner {
  max-width: 800px;
  margin: 0 auto;
}
.event-title {
  font-family: 'Open Sans', sans-serif;
  font-size: 2.4rem;
  font-weight: 400;
  margin: 0 0 1rem;
}
.event-meta {
  font-size: 0.95rem;
  opacity: 0.9;
  display: flex;
  justify-content: center;
  gap: 1.5rem;
  flex-wrap: wrap;
}
.event-body {
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
}
</style>
