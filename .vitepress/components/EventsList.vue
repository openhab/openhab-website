<template>
  <div class="events-container">
    <div class="events-block">
      <h2>Upcoming events</h2>
      <ul v-if="upcomingEvents.length > 0" class="event-list">
        <li v-for="item in upcomingEvents" :key="item.url" class="event">
          <div class="calendar">
            <CalendarIcon :date="item.date" :end-date="item.end_date" />
          </div>
          <!--
          <a :href="item.link || item.url" target="_blank" class="event-link" rel="noopener noreferrer">
            <img class="event-image" :src="withBase(item.event_image || '/openhab-logo-empowering.svg')" alt="" />
          </a>
          -->
          <div class="event-info">
            <a :href="item.link || item.url" target="_blank" rel="noopener noreferrer">
              <h3 class="event-title">{{ item.title }}</h3>
            </a>
            <div v-if="item.location" class="event-location">{{ item.location }}</div>
            <p v-if="item.excerpt || item.abstract" v-html="item.excerpt || item.abstract"></p>
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
            <!--
            <a :href="item.link || item.url" target="_blank" class="event-link" rel="noopener noreferrer">
              <img class="event-image" :src="withBase(item.event_image || '/openhab-logo-empowering.svg')" alt="" />
            </a>
            -->
            <div class="event-info">
              <a :href="item.link || item.url" target="_blank" rel="noopener noreferrer">
                <h3 class="event-title">{{ item.title }}</h3>
              </a>
              <div v-if="item.location" class="event-location">{{ item.location }}</div>
              <p v-if="item.excerpt || item.abstract" v-html="item.excerpt || item.abstract"></p>
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
}
.event-list .event .event-link {
  display: flex;
  height: 8rem;
  width: 128px;
  margin-right: 2rem;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
}
.event-list .event .event-image {
  max-height: 8em;
  max-width: 8em;
  margin-left: 1rem;
  margin-right: 1rem;
  object-fit: contain;
}
.event-list .event .event-info {
  margin-left: 1rem;
  flex: 1;
}
.event-list .event .event-info .event-title {
  margin-bottom: 0;
  margin-top: 0;
  font-family: 'Open Sans', sans-serif;
  font-size: 1.35rem;
}
.event-list .event .event-info .event-location {
  font-family: 'Open Sans', sans-serif;
  font-weight: bold;
}
.event-list .event .event-info p {
  margin-top: 0.5rem;
  margin-bottom: 0;
}
@media (max-width: 719px) {
  .event-list .event {
    flex-wrap: wrap;
  }
}
</style>
