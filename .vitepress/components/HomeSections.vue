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
import { onMounted } from 'vue'
import { useData } from 'vitepress'

import AlertBannerSection from './home/AlertBannerSection.vue'
import WhySection from './home/WhySection.vue'
import CloudSection from './home/CloudSection.vue'
import FeaturedAddons from './home/FeaturedAddons.vue'
import OpenhabianSection from './home/OpenhabianSection.vue'
import OpenSourceSection from './home/OpenSourceSection.vue'
import CommunitySection from './home/CommunitySection.vue'
import EventsSection from './home/EventsSection.vue'
import AlternativeToSection from './home/AlternativeToSection.vue'

const { frontmatter } = useData()

onMounted(async () => {
  try {
    const ScrollReveal = (await import('scrollreveal')).default
    const sr = ScrollReveal()
    sr.reveal('.feature', { scale: 1.0 }, 200)
    sr.reveal('.slide', { scale: 1.0 })
    sr.reveal('.slide-slow', { scale: 1.0, duration: 1000, delay: 500 })
    sr.reveal('.slide-seq', { scale: 1.0, duration: 1000 }, 300)
    sr.reveal('.slide-seq2', { scale: 1.0, duration: 1000 }, 300)
    sr.reveal('.slide-seq3', { origin: 'left', distance: '10px', scale: 1.0, duration: 1000 }, 600)
    sr.reveal('.slide-seq4', { scale: 1.0, viewFactor: 0.0 }, 200)
    sr.reveal('.alert', { origin: 'left', distance: '40px', duration: 1200, scale: 1.0 })
  } catch {
    // Ignore in SSR
  }
})
</script>

<style scoped>
.home-sections {
  width: 100%;
}
</style>
