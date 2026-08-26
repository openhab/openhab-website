<template>
  <DefaultTheme.Layout>
    <template #page-top>
      <div class="blogindex-header">
        <img draggable="false" class="header-pattern" :src="withBase('/pattern.png')" alt="" />
        <h1 class="page-title">
          {{ frontmatter.title }}
        </h1>
        <h2 class="page-description">
          {{ frontmatter.description }}
        </h2>
      </div>
    </template>
    <template #page-bottom>
      <Footer />
    </template>
  </DefaultTheme.Layout>
</template>

<script setup lang="ts">
import DefaultTheme from 'vitepress/theme'
import { useData, withBase } from 'vitepress'
import Footer from '../components/Footer.vue'

const { frontmatter } = useData()
</script>

<style scoped>
@keyframes headerSlideIn {
  0% {
    transform: translateY(30px);
    opacity: 0;
  }
  40% {
    transform: translateY(0);
    opacity: 1;
  }
}

@keyframes headerSlideIn2 {
  0% {
    transform: translateY(30px);
    opacity: 0;
  }
  40% {
    transform: translateY(30px);
    opacity: 0;
  }
  100% {
    transform: translateY(0);
    opacity: 1;
  }
}

.blogindex-header {
  background: var(--vp-c-brand-1, #ff6600);
  position: absolute;
  left: 0;
  right: 0;
  margin-bottom: 4rem;
  height: 320px;
  top: var(--vp-nav-height, 3.6rem);
  padding-top: 20px;
  overflow: hidden;
}

.blogindex-header .header-pattern {
  opacity: 0.15;
  width: 100vw;
  position: absolute;
  top: 0;
  object-fit: cover;
  user-select: none;
}

.blogindex-header .page-title {
  animation: 1.5s ease-out 0s 1 headerSlideIn;
  font-family: 'Open Sans', sans-serif;
  font-weight: 300;
  font-size: 40px;
  color: white;
  text-shadow: 0px 0px 10px #999;
  margin-top: 60px;
  margin-left: 60px;
}

.blogindex-header .page-description {
  animation: 1.5s ease-out 0s 1 headerSlideIn2;
  font-family: 'Open Sans', sans-serif;
  font-weight: 300;
  font-size: 22px;
  color: white;
  text-shadow: 0px 0px 10px #999;
  border: none;
  margin-left: 60px;
  margin-top: 20px;
}

@media (max-width: 719px) {
  .blogindex-header {
    height: 200px;
  }
  .blogindex-header .page-title {
    font-size: 30px;
    margin-top: 20px;
    margin-left: 20px;
  }
  .blogindex-header .page-description {
    font-size: 18px;
    margin: 20px;
  }
}

:deep(.vp-doc) {
  margin-top: calc(var(--vp-nav-height, 3.6rem) + 320px) !important;
  min-height: 80vh !important;
}

@media (max-width: 719px) {
  :deep(.vp-doc) {
    margin-top: calc(var(--vp-nav-height, 3.6rem) + 200px) !important;
  }
}
</style>
