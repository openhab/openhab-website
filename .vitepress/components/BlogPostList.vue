<template>
  <div class="posts-list page-content">
    <div class="content">
      <ul class="posts">
        <li v-for="post in posts" :key="post.url" class="post">
          <a :href="withBase(post.url)">
            <div class="post-frame">
              <div
                class="post-cover"
                :style="post.previewimage ? { background: 'url(' + withBase(post.previewimage) + ') no-repeat center' } : undefined"
              ></div>
              <h3 class="post-title">{{ post.title }}</h3>
              <div class="post-author">
                <strong>{{ post.author }}</strong> posted on
                <span style="white-space: nowrap">{{ formatDate(post.date) }}</span>
              </div>
              <div class="read-more">
                <div class="read-more-button">Read more ➜</div>
              </div>
            </div>
          </a>
        </li>
      </ul>
    </div>
  </div>
</template>

<script setup lang="ts">
import { onMounted } from 'vue'
import { withBase } from 'vitepress'
import { data as posts } from '../theme/posts.data'

function formatDate(rawDate: string) {
  if (!rawDate) return ''
  return new Date(rawDate).toLocaleDateString('en-GB', {
    weekday: 'long',
    year: 'numeric',
    month: 'long',
    day: 'numeric',
  })
}

onMounted(async () => {
  const ScrollReveal = (await import('scrollreveal')).default
  ScrollReveal().reveal('.post', { scale: 1.0 })
})
</script>

<style scoped>
.posts-list {
  margin-top: 0;
  min-height: 80vh;
}

.posts {
  width: 100%;
  padding: 0;
  list-style: none;
}

.posts .post {
  list-style: none;
  width: 100%;
}

.posts .post:first-child .post-frame {
  margin-top: 0;
}

.posts .post a {
  text-decoration: none !important;
}

.posts .post .post-frame {
  border: 1px solid var(--vp-c-border, #ccc);
  border-radius: 8px;
  width: 100%;
  display: flex;
  flex-direction: column;
  color: var(--vp-c-text-1, #000);
  background: var(--vp-c-bg-elv, #fff);
  margin-top: 40px;
  padding: 15px;
  box-sizing: border-box;
  transition: transform 0.2s, box-shadow 0.2s;
}

.posts .post .post-frame:hover {
  transform: translateY(-2px);
  box-shadow: 0 6px 16px rgba(0, 0, 0, 0.1);
}

.posts .post .post-cover {
  height: 450px;
  background-size: cover !important;
  border-radius: 4px;
}

.posts .post .post-title {
  font-size: 32px;
  font-family: 'Open Sans', sans-serif;
  font-weight: 400;
  line-height: 42px;
  margin-top: 1rem;
  margin-bottom: 0.25rem;
}

.posts .post .post-author {
  font-size: 14px;
  font-family: 'Open Sans', sans-serif;
  font-weight: 300;
  margin-top: 0.35rem;
  margin-bottom: 0.5rem;
  color: var(--vp-c-text-2, #666);
}

.read-more {
  margin-top: 1.2rem;
  font-family: 'Open Sans', sans-serif;
  font-weight: bold;
  font-size: 1.2rem;
  color: var(--vp-c-brand-1, #ff6600);
  width: auto;
  display: flex;
  flex-direction: row;
}

.read-more-button {
  padding: 0.6rem 1.4rem;
  border: 1px solid var(--vp-c-brand-1, #ff6600);
  border-radius: 4px;
  box-sizing: border-box;
  font-weight: bold;
  font-size: 0.95rem;
  color: var(--vp-c-brand-1, #ff6600);
  transition: all 0.2s;
}

.read-more-button:hover {
  color: white;
  background-color: var(--vp-c-brand-1, #ff6600);
}

@media (max-width: 719px) {
  .posts-list {
    margin-top: 0;
  }
  .posts .post .post-cover {
    height: 200px !important;
  }
  .posts .post .post-title {
    font-size: 22px;
    line-height: 28px;
  }
}
</style>
