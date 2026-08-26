<template>
  <div class="events-container">
    <div class="events-block">
      <h2>Upcoming events</h2>
      <ul v-if="upcomingEvents.length > 0" class="event-list">
        <li v-for="item in upcomingEvents" :key="item.url" class="event">
          <div class="calendar">
            <CalendarIcon :date="item.date" :end-date="item.end_date" />
          </div>
          <a v-if="item.link" :href="item.link" target="_blank" class="event-link" rel="noopener noreferrer">
            <img class="event-image" :src="withBase('/openhab-logo-empowering.svg')" alt="" />
          </a>
          <div class="event-info">
            <a v-if="item.link" :href="item.link" target="_blank" rel="noopener noreferrer">
              <h3 class="event-title">{{ item.title }}</h3>
            </a>
            <h3 v-else class="event-title">{{ item.title }}</h3>
            <div v-if="item.location" class="event-location">{{ item.location }}</div>
          </div>
        </li>
      </ul>
      <p v-else>No upcoming events currently scheduled.</p>
    </div>

    <div class="events-block" v-if="pastEvents.length > 0">
      <h2>Past events</h2>
      <div v-for="year in pastYears" :key="year">
        <h3>{{ year }}</h3>
        <ul class="event-list">
          <li v-for="item in pastEventsByYear(year)" :key="item.url" class="event">
            <div class="calendar">
              <CalendarIcon :date="item.date" :end-date="item.end_date" />
            </div>
            <div class="event-info">
              <a v-if="item.link" :href="item.link" target="_blank" rel="noopener noreferrer">
                <h3 class="event-title">{{ item.title }}</h3>
              </a>
              <h3 v-else class="event-title">{{ item.title }}</h3>
              <div v-if="item.location" class="event-location">{{ item.location }}</div>
            </div>
          </li>
        </ul>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { withBase } from 'vitepress'
import CalendarIcon from './CalendarIcon.vue'
import { data as allEvents } from '../theme/events.data'

const upcomingEvents = computed(() => {
  const now = new Date()
  return (allEvents || [])
    .filter((p) => {
      const d = p.end_date ? new Date(p.end_date) : new Date(p.date)
      return d >= now
    })
    .sort((a, b) => new Date(a.date).getTime() - new Date(b.date).getTime())
})

const pastEvents = computed(() => {
  const now = new Date()
  return (allEvents || [])
    .filter((p) => {
      const d = p.end_date ? new Date(p.end_date) : new Date(p.date)
      return d < now
    })
    .sort((a, b) => new Date(b.date).getTime() - new Date(a.date).getTime())
})

const pastYears = computed(() => {
  const years = new Set<number>()
  pastEvents.value.forEach((e) => {
    if (e.date) {
      years.add(new Date(e.date).getFullYear())
    }
  })
  return Array.from(years).sort((a, b) => b - a)
})

function pastEventsByYear(year: number) {
  return pastEvents.value.filter((e) => e.date && new Date(e.date).getFullYear() === year)
}
</script>

<style scoped>
.events-container {
  margin-top: 2rem;
}
.event-list {
  list-style: none;
  padding-left: 0;
}
.event-list .event {
  clear: both;
  display: flex;
  margin-bottom: 2rem;
  align-items: center;
  gap: 1.5rem;
}
.event-list .event .event-link {
  display: flex;
  height: 6rem;
  width: 100px;
}
.event-list .event .event-image {
  max-height: 6em;
  max-width: 6em;
  object-fit: contain;
}
.event-list .event .event-info {
  flex: 1;
}
.event-list .event .event-info .event-title {
  margin: 0;
  font-family: 'Open Sans', sans-serif;
  font-size: 1.3rem;
}
.event-list .event .event-info .event-location {
  font-family: 'Open Sans', sans-serif;
  font-weight: bold;
  color: var(--vp-c-text-2, #666);
}
@media (max-width: 719px) {
  .event-list .event {
    flex-wrap: wrap;
  }
}
</style>
