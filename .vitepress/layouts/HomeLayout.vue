<template>
  <div class="home-layout">
    <div class="home-header">
      <Jumbotron />
      <div class="after-jumbotron">
        <div class="placeholder"></div>
      </div>
    </div>
    <HomeSections />
    <Footer />
    <ConsentBanner />
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
      setTimeout(() => {
        header.classList.add('ready')
        header.classList.remove('homepage')
      }, 1500)
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
.after-jumbotron .placeholder {
  height: 760px;
}
.home-layout {
  width: 100%;
}
</style>
