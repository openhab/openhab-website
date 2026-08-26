<template>
  <DefaultTheme.Layout>
    <template #page-top>
      <div class="event-page-header">
        <img draggable="false" class="header-pattern" :src="withBase('/pattern.png')" alt="" />
        <h1 class="page-title">
          {{ frontmatter.title }}
        </h1>
      </div>
      <div class="event-content">
        <div class="event-inner">
          <div class="back-link">
            <a :href="withBase('/about/events.html')">« All Events</a>
          </div>
          <a v-if="frontmatter.link" :href="frontmatter.link" target="_blank" rel="noopener noreferrer">
            <img v-if="frontmatter.event_image" :src="withBase(frontmatter.event_image)" class="event-banner" alt="Event image" />
          </a>
          <img v-else-if="frontmatter.event_image" :src="withBase(frontmatter.event_image)" class="event-banner" alt="Event image" />
          <dl class="event-details">
            <dt>Date</dt>
            <dd>
              <span>{{ formattedStartDate }}</span>
              <span v-if="frontmatter.end_date"> - {{ formattedEndDate }}</span>
            </dd>
            <dt v-if="frontmatter.location">Location</dt>
            <dd v-if="frontmatter.location">{{ frontmatter.location }}</dd>
          </dl>
          <hr />
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
import { useData, withBase } from 'vitepress'
import Footer from '../components/Footer.vue'

const { frontmatter } = useData()

const dateOptions: Intl.DateTimeFormatOptions = {
  weekday: 'long',
  year: 'numeric',
  month: 'long',
  day: 'numeric',
}

const formattedStartDate = computed(() => {
  if (!frontmatter.value.date) return ''
  return new Date(frontmatter.value.date).toLocaleDateString('en-GB', dateOptions)
})

const formattedEndDate = computed(() => {
  if (!frontmatter.value.end_date) return ''
  return new Date(frontmatter.value.end_date).toLocaleDateString('en-GB', dateOptions)
})
</script>

<style scoped>
@keyframes eventHeaderSlideIn {
  0% {
    transform: translateX(-10px);
    opacity: 0;
  }
  40% {
    transform: translateX(0);
    opacity: 1;
  }
}

.event-page-header {
  background: var(--vp-c-brand-1, #ff6600);
  position: absolute;
  top: var(--vp-nav-height, 3.6rem);
  left: 0;
  right: 0;
  margin-bottom: 4rem;
  height: 130px;
  padding-top: 80px;
  overflow: hidden;
}

.event-page-header .header-pattern {
  opacity: 0.15;
  width: 100vw;
  position: absolute;
  top: 0;
  object-fit: cover;
  user-select: none;
}

.event-page-header .page-title {
  animation: 1s ease-out 0s 1 eventHeaderSlideIn;
  font-family: 'Open Sans', sans-serif;
  font-weight: 300;
  font-size: 40px;
  color: white;
  text-shadow: 0px 0px 10px #999;
  margin: 25px;
}

@media (max-width: 419px) {
  .event-page-header .page-title {
    font-size: 30px;
  }
}

.event-content {
  margin-top: calc(var(--vp-nav-height, 3.6rem) + 150px);
  max-width: 900px;
  margin-left: auto;
  margin-right: auto;
  padding: 0 1.5rem;
}

.event-content .back-link {
  font-size: 1.2rem;
  margin-bottom: 2rem;
}

.event-banner {
  max-width: 100%;
  border-radius: 8px;
  margin-bottom: 1.5rem;
}

.event-details {
  display: grid;
  grid-template-columns: 100px 1fr;
  gap: 0.5rem 1rem;
  margin: 1.5rem 0;
}

.event-details dt {
  font-weight: bold;
}
</style>
