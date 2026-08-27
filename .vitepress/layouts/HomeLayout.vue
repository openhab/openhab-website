<template>
  <div class="home-layout homepage">
    <div class="home-header">
      <Jumbotron />
    </div>
    <HomeSections />
  </div>
</template>

<script setup lang="ts">
import { onMounted, onUnmounted } from 'vue'

import Jumbotron from '../components/home/Jumbotron.vue'
import HomeSections from '../components/HomeSections.vue'
import Footer from '../components/Footer.vue'
import ConsentBanner from '../components/ConsentBanner.vue'

let hr: any = null

onMounted(async () => {
  const header = document.querySelector('header.VPNav') || document.getElementsByTagName('header')[0]
  if (header) {
    try {
      const HeadroomModule = (await import('headroom.js')).default
      hr = new HeadroomModule(header as HTMLElement)
      hr.init()
    } catch {
      // Ignore if headroom fails
    }
  }

  if (window.location.hash && window.location.hash.indexOf('token') > 0) {
    window.location.href = 'https://www.openhab.org/admin/' + window.location.hash
  }
})

onUnmounted(() => {
  if (hr) {
    hr.destroy()
  }
})
</script>

<style scoped>
.home-layout {
  width: 100%;
}
</style>
