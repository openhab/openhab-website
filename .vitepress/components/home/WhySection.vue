<template>
  <div class="section2">
    <h2>Why openHAB?</h2>
    <div class="features">
      <ScrollOnReveal classes="feature" :delay="0" :scale="1.0">
        <IntegrateEverythingIcon />
        <h3>Integrate Everything</h3>
        <p>
          With its <a :href="withBase('/docs/#a-deeper-dive-openhab-structure-for-advanced-users')">pluggable architecture</a>,
          openHAB supports more than <a :href="withBase('/addons/')">400 different technologies and systems</a> and thousands of devices!
        </p>
      </ScrollOnReveal>
      <ScrollOnReveal classes="feature" :delay="200" :scale="1.0">
        <RotatingGearsIcon />
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
      </ScrollOnReveal>
      <ScrollOnReveal classes="feature" :delay="400" :scale="1.0">
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
      </ScrollOnReveal>
    </div>
  </div>
</template>

<script setup lang="ts">
import { withBase } from 'vitepress'
import ScrollOnReveal from '../ScrollOnReveal.vue'
import IntegrateEverythingIcon from './IntegrateEverythingIcon.vue'
import RotatingGearsIcon from './RotatingGearsIcon.vue'
import RunsEverywhereIcon from './RunsEverywhereIcon.vue'
</script>

<style scoped>
.section2 {
  font-family: 'Open Sans', sans-serif;
  background: var(--vp-c-bg, white);
  text-align: center;
  padding: 2.5rem 1.5rem 3.5rem;
}
.section2 h2 {
  margin: 0 0 2.5rem;
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
  gap: 2.5rem;
}
.feature {
  flex-grow: 1;
  flex-basis: 28%;
  max-width: 32%;
  display: flex;
  flex-direction: column;
  align-items: center;
}
.feature h3 {
  font-size: 1.4rem;
  font-weight: 500;
  border-bottom: none;
  padding-bottom: 0;
  color: var(--vp-c-text-1, #222);
  margin-top: 1.5rem;
  margin-bottom: 0.75rem;
}
.feature p {
  margin: 0;
  color: var(--vp-c-text-2, #555);
  line-height: 1.6;
}
.feature a {
  color: var(--vp-c-brand-1, #ff6600);
  text-decoration: none;
}
.feature a:hover {
  color: var(--vp-c-brand-2, #e55d00);
  text-decoration: underline;
}
@media (max-width: 768px) {
  .features {
    flex-direction: column;
    align-items: center;
  }
  .feature {
    max-width: 100%;
    margin-top: 1.5rem;
  }
}
</style>
