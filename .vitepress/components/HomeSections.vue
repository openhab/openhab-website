<template>
  <div class="home-sections">
    <AlertBannerSection v-if="frontmatter.alert" />
    <WhySection />
    <OpenhabianSection />
    <CloudSection />
    <FeaturedAddons />
    <OpenSourceSection />
    <CommunitySection />
    <EventsSection />
  </div>
</template>

<script setup lang="ts">
import { useData } from 'vitepress'
import AlertBannerSection from './home/AlertBannerSection.vue'
import WhySection from './home/WhySection.vue'
import CloudSection from './home/CloudSection.vue'
import FeaturedAddons from './home/FeaturedAddons.vue'
import OpenhabianSection from './home/OpenhabianSection.vue'
import OpenSourceSection from './home/OpenSourceSection.vue'
import CommunitySection from './home/CommunitySection.vue'
import EventsSection from './home/EventsSection.vue'

const { frontmatter } = useData()
</script>

<style scoped>
.home-sections {
  width: 100%;
}
</style>
