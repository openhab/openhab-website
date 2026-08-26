<template>
  <div class="section2">
    <h2>Why openHAB?</h2>
    <div class="features">
      <div class="feature">
        <IntegrateEverythingIcon />
        <h3>Integrate Everything</h3>
        <p>
          With its <a :href="withBase('/docs/#a-deeper-dive-openhab-structure-for-advanced-users')">pluggable architecture</a>,
          openHAB supports more than <a :href="withBase('/addons/')">400 different technologies and systems</a> and thousands of devices!
        </p>
      </div>
      <div class="feature">
        <RotatingGearsIcon />
        <div class="home-icon-container">
          <img :src="withBase('/components/home/images/icons/empty.png')" class="home-icon current" alt="" />
        </div>
        <h3>Automate with Ease</h3>
        <p>
          Use a powerful and flexible engine to design
          <a :href="withBase('/docs/concepts/rules.html#what-are-rules')">rules</a>,
          with time and event-based
          <a :href="withBase('/docs/concepts/rules.html#triggers')">triggers</a>,
          <a :href="withBase('/docs/concepts/rules.html#scripts')">scripts</a>,
          <a :href="withBase('/docs/configuration/actions.html')">actions</a>,
          <a :href="withBase('/docs/configuration/actions.html#cloud-notification-actions')">notifications</a>
          and
          <a :href="withBase('/docs/concepts/audio.html')">voice control</a>.
        </p>
      </div>
      <div class="feature">
        <RunsEverywhereIcon />
        <h3>Runs Everywhere</h3>
        <p>
          Run your server on
          <a :href="withBase('/docs/installation/linux.html')">Linux</a>,
          <a :href="withBase('/docs/installation/macos.html')">macOS</a>,
          <a :href="withBase('/docs/installation/windows.html')">Windows</a>,
          <a :href="withBase('/docs/installation/openhabian.html')">Raspberry Pi</a>,
          <a :href="withBase('/docs/installation/docker.html')">Docker</a>,
          <a :href="withBase('/docs/installation/synology.html')">Synology</a>...
          Access it with apps for the web,
          <a :href="withBase('/docs/apps/ios.html')">iOS</a>,
          <a :href="withBase('/docs/apps/android.html')">Android</a> and others.
        </p>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { withBase } from 'vitepress'
import IntegrateEverythingIcon from './IntegrateEverythingIcon.vue'
import RotatingGearsIcon from './RotatingGearsIcon.vue'
import RunsEverywhereIcon from './RunsEverywhereIcon.vue'
</script>

<style scoped>
.section2 {
  font-family: 'Open Sans', sans-serif;
  background: var(--vp-c-bg, white);
  text-align: center;
  padding: 3rem 1rem;
}
.section2 h2 {
  margin: 1rem 0 2rem;
  text-align: center;
  font-family: 'Open Sans', sans-serif;
  font-weight: normal;
  font-size: 2.5em;
  border: none;
}
.features {
  margin: 0 auto;
  max-width: 1200px;
  display: flex;
  flex-wrap: wrap;
  align-items: flex-start;
  justify-content: space-between;
  gap: 2rem;
}
.feature {
  flex-grow: 1;
  flex-basis: 28%;
  max-width: 32%;
}
.feature h3 {
  font-size: 1.4rem;
  font-weight: 500;
  border-bottom: none;
  padding-bottom: 0;
  color: var(--vp-c-text-1, #222);
  margin-top: 1rem;
}
.feature p {
  margin: 0.5rem 0;
  color: var(--vp-c-text-2, #555);
  line-height: 1.6;
}
.feature a {
  color: var(--vp-c-brand-1, #ff6600);
}
.home-icon-container {
  width: 150px;
  height: 80px;
  margin: 0 auto;
  position: relative;
}
.home-icon {
  width: 150px;
  height: 80px;
  object-fit: contain;
}
@media (max-width: 768px) {
  .features {
    flex-direction: column;
  }
  .feature {
    max-width: 100%;
  }
}
</style>
