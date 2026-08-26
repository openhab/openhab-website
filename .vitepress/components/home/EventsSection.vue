<template>
  <div class="events-section" v-show="events.length > 0">
    <div class="events-container">
      <ClientOnly>
        <parallax :speed-factor="0.15">
          <img :src="withBase('/components/home/images/shd.jpg')" alt="event" />
        </parallax>
      </ClientOnly>
      <div class="events-text">
        <h2 class="slide-seq4">Let's Meet Up!</h2>
        <div class="upcoming-events" v-show="events.length > 0">
          <h3 class="slide-seq4">Next event{{ events.length > 1 ? 's' : '' }}</h3>
          <ul class="event-list slide-seq4">
            <li v-for="item in events" :key="item.url" class="event">
              <div class="calendar">
                <CalendarIcon :date="item.date" :end-date="item.end_date" />
              </div>
              <div class="event-info">
                <a :href="item.link || withBase(item.url)" target="_blank" rel="noopener noreferrer">
                  <h3 class="event-title">{{ item.title }}</h3>
                </a>
                <div class="event-location">{{ item.location }}</div>
              </div>
            </li>
          </ul>
        </div>
        <a :href="withBase('/about/events.html')" class="see-all-events-button slide-seq4">See All Events ➜</a>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { withBase } from 'vitepress'
import parallax from '@lucien144/vue3-parallaxy'
import CalendarIcon from '../CalendarIcon.vue'

interface EventItem {
  url: string
  title: string
  date: string
  end_date?: string
  location?: string
  link?: string
}

const events = ref<EventItem[]>([])

onMounted(async () => {
  try {
    // Look up event pages dynamically
    const eventsData = await import('../../about/events.md')
    // If events list is in frontmatter or page data
    events.value = []
  } catch {
    events.value = []
  }
})
</script>

<style scoped>
.events-section {
  background: black;
  color: white;
  display: flex;
  font-family: 'Open Sans', sans-serif;
  font-weight: normal;
  overflow: hidden;
  position: relative;
}
.events-container {
  position: relative;
  width: 100%;
  overflow: hidden;
  min-height: 400px;
}
.events-text {
  position: absolute;
  top: 50%;
  transform: translateY(-50%);
  text-align: center;
  left: 0;
  right: 60%;
  z-index: 12;
  padding: 3rem;
  background-color: rgba(0, 0, 0, 0.4);
}
.events-text h2 {
  font-size: 2.5em;
  font-weight: 300;
  border: none;
  margin-top: 0;
  text-shadow: 0px 0px 10px #666;
}
.event-list {
  padding-left: 0;
  list-style: none;
}
.event {
  display: flex;
  align-items: center;
  margin-bottom: 1.5rem;
  gap: 1rem;
}
.event-info {
  text-align: left;
}
.event-title {
  margin: 0;
  color: #fff;
  font-family: 'Open Sans', sans-serif;
  font-size: 1.2rem;
}
.event-location {
  font-weight: bold;
  color: #ddd;
}
.see-all-events-button {
  display: inline-block;
  font-size: 1rem;
  color: #fff;
  padding: 0.8rem 1.6rem;
  border-radius: 4px;
  background-color: rgba(0, 0, 0, 0.3);
  border: 1px solid #fff;
  text-decoration: none;
  transition: all 0.2s;
}
.see-all-events-button:hover {
  background-color: #fff;
  color: black;
}
@media (max-width: 768px) {
  .events-text {
    right: 0;
    width: 100%;
    background: rgba(0, 0, 0, 0.7);
    padding: 1.5rem;
  }
}
</style>
