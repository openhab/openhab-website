<template>
  <DefaultTheme.Layout>
    <template #page-top>
      <div class="post-header" :style="headerStyle">
        <div class="post-cover">
          <h1 class="post-title">
            {{ frontmatter.title }}
          </h1>
        </div>
      </div>
      <div class="blog-body-header">
        <div class="page-author">
          <strong>{{ frontmatter.author }}</strong> posted on
          <span style="white-space: nowrap">{{ formattedDate }}</span>
        </div>
      </div>
    </template>
    <template #page-bottom>
      <Footer />
    </template>
  </DefaultTheme.Layout>
</template>

<script setup lang="ts">
import DefaultTheme from 'vitepress/theme'
import { computed } from 'vue'
import { useData } from 'vitepress'
import Footer from '../components/Footer.vue'

const { frontmatter } = useData()

const headerStyle = computed(() => {
  const img = frontmatter.value.previewimage
  if (!img) return {}
  return {
    backgroundImage: `url(${img})`,
    backgroundRepeat: 'no-repeat',
    backgroundPosition: 'center',
    backgroundSize: 'cover',
  }
})

const formattedDate = computed(() => {
  if (!frontmatter.value.date) return ''
  const date = new Date(frontmatter.value.date)
  return date.toLocaleDateString('en-GB', {
    weekday: 'long',
    year: 'numeric',
    month: 'long',
    day: 'numeric',
  })
})
</script>

<style scoped>
@keyframes postTitleSlideIn {
  0% {
    transform: translateY(20px);
    opacity: 0;
  }
  40% {
    transform: translateX(0);
    opacity: 1;
  }
}

.post-header {
  background-color: var(--vp-c-brand-1, #ff6600);
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  margin-bottom: 4rem;
  height: calc(400px + var(--vp-nav-height, 3.6rem));
  overflow: hidden;
  text-align: center;
  background-size: cover !important;
}

.post-header .post-cover {
  background-color: rgba(255, 102, 0, 0.67);
  position: absolute;
  left: 0;
  bottom: 0;
  right: 0;
  height: 400px;
  display: flex;
}

.post-header .post-cover .post-title {
  margin: auto;
  animation: 1s ease-out 0s 1 postTitleSlideIn;
  font-family: 'Open Sans', sans-serif;
  font-weight: 300;
  font-size: 40px;
  color: white;
  padding: 64px 24px;
  text-shadow: 0px 0px 10px #999;
  text-align: center;
}

@media (max-width: 419px) {
  .post-header .post-cover .post-title {
    font-size: 30px;
  }
}

.blog-body-header {
  margin-top: calc(400px + var(--vp-nav-height, 3.6rem) + 40px) !important;
}

.blog-body-header .page-author {
  font-size: 14px;
  font-family: 'Open Sans', sans-serif;
  font-weight: 300;
  line-height: 42px;
  margin-top: -2rem;
  margin-bottom: 1rem;
  text-align: center;
  color: var(--vp-c-text-2, #666);
}

:deep(.vp-doc) {
  min-height: 80vh !important;
}
</style>
