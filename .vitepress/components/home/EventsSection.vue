<template>
  <div class="events-section" v-show="events.length > 0">
    <div class="events-container">
      <ClientOnly>
        <parallax :speed-factor="0.15">
          <img src="./images/shd.jpg" alt="event" />
        </parallax>
      </ClientOnly>
      <div class="events-text">
        <ScrollOnReveal :scale="1.0" :viewFactor="0.0">
          <h2>Let's Meet Up!</h2>
        </ScrollOnReveal>
        <div class="upcoming-events" v-show="events.length > 0">
          <ScrollOnReveal :delay="200" :scale="1.0" :viewFactor="0.0">
            <h3>Next event{{ events.length > 1 ? 's' : '' }}</h3>
          </ScrollOnReveal>
          <ScrollOnReveal tag="ul" classes="event-list" selector=".event" :interval="200" :scale="1.0" :viewFactor="0.0">
            <li v-for="item in events" :key="item.url" class="event">
              <div class="calendar">
                <CalendarIcon :date="item.date" :end-date="item.end_date" />
              </div>
              <div class="event-info">
                <h3 class="event-title">
                  <a :href="item.link || withBase(item.url)" target="_blank" rel="noopener noreferrer">
                    {{ item.title }}
                  </a>
                </h3>
                <div class="event-location">{{ item.location }}</div>
              </div>
            </li>
          </ScrollOnReveal>
        </div>
        <ScrollOnReveal :delay="400" :scale="1.0" :viewFactor="0.0">
          <a :href="withBase('/about/events.html')" class="see-all-events-button">See All Events ➜</a>
        </ScrollOnReveal>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { withBase } from 'vitepress'
import ScrollOnReveal from '../ScrollOnReveal.vue'
import parallax from '@lucien144/vue3-parallaxy'
import CalendarIcon from '../CalendarIcon.vue'
import { data as allEvents } from '../../theme/events.data'

const events = computed(() => {
  const now = new Date()
  return (allEvents || [])
    .filter((p) => {
      if (p.end_date) return new Date(p.end_date) >= now
      return p.date ? new Date(p.date) >= now : false
    })
    .slice(0, 2)
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
  top: 0;
  bottom: 0;
  left: 0;
  right: 55%;
  height: 100%;
  z-index: 12;
  padding: 3rem;
  background-color: rgba(0, 0, 0, 0.4);
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  text-align: center;
  box-sizing: border-box;
}
.events-text h2 {
  font-size: 2.5em;
  font-weight: 300;
  border: none;
  margin-top: 0;
  margin-bottom: 0.5rem;
  text-shadow: 0px 0px 10px #666;
}
.upcoming-events {
  width: 100%;
  max-width: 520px;
}
.upcoming-events h3 {
  margin: 0.5rem 0 1.25rem;
  font-size: 1.3rem;
  font-weight: 300;
  color: #eee;
  border: none;
}
.event-list {
  padding-left: 0;
  list-style: none;
  margin: 0 0 1.5rem 0;
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
.event-title a {
  color: #fff;
  text-decoration: none;
}
.event-title a:hover {
  text-decoration: underline;
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
@media (max-width: 1024px) {
  .events-text {
    right: 40%;
    padding: 2rem;
  }
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
