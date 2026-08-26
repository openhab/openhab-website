<template>
  <div class="cloud-section">
    <div class="cloud-text">
      <div class="cloud-left">
        <h2 class="slide">No Cloud Required...</h2>
        <p class="slide">
          openHAB runs on your hardware, doesn't require any cloud service to work, keeps your data privately at home and talks directly to your local devices whenever possible.
          At the core of our <a :href="withBase('/about/who-we-are.html')">philosophy</a> is that you always remain in control.
        </p>
      </div>
      <div class="cloud-right">
        <h2 class="slide">...but Cloud-Friendly</h2>
        <p class="slide">
          Integrations are available for the most popular cloud-based smart home platforms, including
          <a :href="withBase('/docs/ecosystem/google-assistant')">Google Assistant</a>,
          <a :href="withBase('/docs/ecosystem/alexa')">Amazon Alexa</a>,
          <a :href="withBase('/addons/integrations/homekit/')">Apple HomeKit</a> and more.
          Use the openHAB Cloud connector with the free
          <a target="_blank" href="https://www.myopenhab.org/" rel="noopener noreferrer">myopenhab.org</a> service or host your own.
        </p>
      </div>
    </div>
    <div class="cloud-bkg">
      <div class="cloud-left-bkg">
        <img class="cloud-left-bkg-img" :src="withBase('/components/home/images/lock-bkg.png')" alt="" />
      </div>
      <div class="cloud-right-bkg">
        <img class="cloud-right-bkg-img" :src="withBase('/components/home/images/cloud-bkg.png')" alt="" />
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { onMounted } from 'vue'
import { withBase } from 'vitepress'

onMounted(async () => {
  try {
    const ScrollReveal = (await import('scrollreveal')).default
    const sr = ScrollReveal()
    sr.reveal('.cloud-left-bkg-img', { origin: 'left', scale: 1.0, distance: '120px', duration: 1000 })
    sr.reveal('.cloud-right-bkg-img', { origin: 'right', scale: 1.0, distance: '120px', duration: 1000 })
  } catch {
    // Ignore in SSR
  }
})
</script>

<style scoped>
.cloud-section {
  background-color: var(--vp-c-bg-alt, #f2f2f2);
  width: 100%;
  overflow: hidden;
  display: flex;
  flex-direction: column;
}
.cloud-text {
  width: 100%;
  display: flex;
  text-align: center;
  z-index: 10;
}
.cloud-left, .cloud-right {
  width: 50%;
  padding: 1rem;
  box-sizing: border-box;
}
.cloud-text h2 {
  margin: 2rem 0 1rem;
  font-size: 2rem;
  font-family: 'Open Sans', sans-serif;
  font-weight: 300;
  color: #5599ff;
}
.cloud-text p {
  font-family: 'Open Sans', sans-serif;
  margin: 0 2rem;
}
.cloud-text a {
  color: #5599ff;
}
.cloud-bkg {
  height: 28vw;
  width: 100%;
  overflow: hidden;
  position: relative;
  margin-top: -60px;
}
.cloud-left-bkg {
  position: absolute;
  left: 0;
  width: 50%;
  height: 100%;
  overflow: hidden;
}
.cloud-left-bkg img {
  max-height: 28vw;
}
.cloud-right-bkg {
  position: absolute;
  right: 0;
  width: 50%;
  height: 100%;
  overflow: hidden;
}
.cloud-right-bkg img {
  float: right;
  max-height: 28vw;
}
@media (max-width: 719px) {
  .cloud-text {
    flex-direction: column;
  }
  .cloud-left, .cloud-right {
    width: 100%;
  }
  .cloud-bkg {
    height: 100px;
    margin-top: 0;
  }
  .cloud-left-bkg, .cloud-right-bkg {
    height: 100px;
  }
  .cloud-left-bkg img, .cloud-right-bkg img {
    width: 180px;
    height: 100px;
  }
}
</style>
