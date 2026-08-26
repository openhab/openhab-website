<template>
  <div v-if="discourseData" class="topics" v-show="showTopics">
    <article v-for="topic in topics" :key="topic.id" class="topic">
      <a target="_blank" :href="'https://community.openhab.org/t/' + topic.id" class="topic-link" rel="noopener noreferrer">
        <h3 class="post-title">{{ topic.title }}</h3>
        <img v-if="topic.image_url && topic.image_url.indexOf('favicon.ico') < 0" :src="topic.image_url" alt="" />
        <div class="post-stats">{{ topic.views }} views - {{ topic.posts_count }} posts</div>
        <div class="read-more">
          <div class="read-more-button">Read more ➜</div>
        </div>
      </a>
    </article>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'

const discourseData = ref<any>(null)
const showTopics = ref(true)

const topics = computed(() => {
  if (!discourseData.value || !discourseData.value.topic_list) return []
  return discourseData.value.topic_list.topics || []
})

onMounted(async () => {
  const url = window.location.host.indexOf('localhost') === 0
    ? '/all.json'
    : 'https://community.openhab.org/c/tutorials-examples/10/l/top.json?period=all'

  try {
    const resp = await fetch(url)
    const json = await resp.json()
    if (json.topic_list) {
      discourseData.value = json
    }
  } catch {
    console.log('Failed fetching topic list from community.openhab.org')
  }
})
</script>

<style scoped>
.topics {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
  gap: 1.5rem;
  width: 100%;
  box-sizing: border-box;
  margin-top: 1.5rem;
}
.topic {
  width: 100%;
  border: 1px solid var(--vp-c-border, #ddd);
  border-radius: 8px;
  box-shadow: 2px 2px 6px rgba(0, 0, 0, 0.08);
  padding: 1.25rem;
  background: var(--vp-c-bg-elv, #fff);
  box-sizing: border-box;
  display: flex;
  flex-direction: column;
}
.topic-link {
  color: var(--vp-c-text-1, #000);
  text-decoration: none;
  display: flex;
  flex-direction: column;
  height: 100%;
}
.topic-link:hover {
  text-decoration: none;
}
.post-stats {
  font-size: 10pt;
  font-weight: normal;
  color: var(--vp-c-text-2, #666);
  margin-top: 0.5rem;
}
h3 {
  margin-top: 0.4rem;
  font-size: 1.1rem;
}

.read-more {
  margin-top: auto;
  padding-top: 1rem;
}
.read-more-button {
  display: inline-block;
  padding: 0.3rem 0.8rem;
  border: 1px solid var(--vp-c-brand-1, #ff6600);
  border-radius: 4px;
  color: var(--vp-c-brand-1, #ff6600);
  font-size: 0.8rem;
  transition: all 0.2s;
}
.read-more-button:hover {
  color: white;
  background-color: var(--vp-c-brand-1, #ff6600);
}
</style>
