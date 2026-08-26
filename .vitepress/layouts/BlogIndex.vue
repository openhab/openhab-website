<template>
  <div class="blog-index">
    <div class="page-header">
      <img draggable="false" class="header-pattern" :src="withBase('/pattern.png')" alt="" />
      <h1 class="page-title">
        {{ frontmatter.title || 'openHAB Blog' }}
      </h1>
    </div>
    <div class="content-wrapper">
      <BlogPostList />
    </div>
    <Footer />
  </div>
</template>

<script setup lang="ts">
import { useData, withBase } from 'vitepress'
import BlogPostList from '../components/BlogPostList.vue'
import Footer from '../components/Footer.vue'

const { frontmatter } = useData()
</script>

<style scoped>
.blog-index {
  width: 100%;
}
.page-header {
  background: var(--vp-c-brand-1, #ff6600);
  height: 250px;
  position: relative;
  display: flex;
  justify-content: center;
  align-items: center;
  overflow: hidden;
}
.header-pattern {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  object-fit: cover;
  opacity: 0.15;
  pointer-events: none;
}
.page-title {
  color: white;
  font-family: 'Open Sans', sans-serif;
  font-size: 2.8rem;
  font-weight: 300;
  z-index: 1;
  text-shadow: 0 2px 8px rgba(0, 0, 0, 0.3);
  margin: 0;
  text-align: center;
}
.content-wrapper {
  max-width: 1100px;
  margin: 2rem auto 4rem;
  padding: 0 1.5rem;
}
</style>
