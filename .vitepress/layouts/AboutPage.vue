<template>
  <DefaultTheme.Layout>
    <template #page-top>
      <div class="page-header">
        <img draggable="false" class="header-pattern" :src="withBase('/pattern.png')" alt="" />
        <h1 class="page-title">
          {{ frontmatter.title }}
        </h1>
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
    transform: translateX(-10px);
    opacity: 0;
  }
  40% {
    transform: translateX(0);
    opacity: 1;
  }
}

.page-header {
  background: var(--vp-c-brand-1, #ff6600);
  position: absolute;
  left: 0;
  right: 0;
  margin-bottom: 4rem;
  height: 130px;
  top: var(--vp-nav-height, 3.6rem);
  padding-top: 80px;
  overflow: hidden;
}

.page-header .header-pattern {
  opacity: 0.15;
  width: 100vw;
  height: 100vh;
  position: absolute;
  top: 0;
  object-fit: cover;
  user-select: none;
}

.page-header .page-title {
  animation: 1s ease-out 0s 1 headerSlideIn;
  font-family: 'Open Sans', sans-serif;
  font-weight: 300;
  font-size: 40px;
  color: white;
  text-shadow: 0px 0px 10px #999;
  margin: 25px;
}

@media (max-width: 419px) {
  .page-header .page-title {
    font-size: 30px;
  }
}

:deep(.vp-doc) {
  margin-top: calc(var(--vp-nav-height, 3.6rem) + 150px) !important;
  min-height: 80vh !important;
}
</style>
