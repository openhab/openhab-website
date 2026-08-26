<template>
  <div class="section-opensource">
    <div class="left">
      <div class="logos">
        <a target="_blank" href="https://www.openhabfoundation.org/" rel="noopener noreferrer">
          <img class="foundation-logo" :src="withBase('/components/home/images/foundation-logo-dark.svg')" alt="openHAB Foundation" />
        </a>
      </div>
    </div>
    <div class="right">
      <h2>
        <div class="slide-seq3">100% Open Source.</div>
        <div class="slide-seq3 reliable">100% Reliable.</div>
      </h2>
      <p class="slide">
        openHAB is developed in <a target="_blank" href="https://www.java.com/" rel="noopener noreferrer">Java™</a> and built on top of
        <a target="_blank" href="https://karaf.apache.org/" rel="noopener noreferrer">Apache Karaf™</a>, an industry-grade
        <a target="_blank" href="https://www.osgi.org/" rel="noopener noreferrer">OSGi®</a> runtime.<br />
        openHAB and its development are supported by the
        <a target="_blank" href="https://www.openhabfoundation.org/" rel="noopener noreferrer">openHAB Foundation</a>, a registered non-profit organisation.<br />
        Without having a company behind openHAB, it will always stay absolutely vendor-neutral and never lock you in.
      </p>
    </div>
  </div>
</template>

<script setup lang="ts">
import { withBase } from 'vitepress'
</script>

<style scoped>
.section-opensource {
  background-color: #01324d;
  color: white;
  display: flex;
  flex-direction: row;
  text-align: left;
  font-family: 'Open Sans', sans-serif;
  padding: 2rem 0;
}
.left {
  width: 40%;
  text-align: center;
  display: flex;
  flex-direction: row;
}
.logos {
  margin: auto;
  display: flex;
  flex-direction: column;
  align-items: center;
}
.foundation-logo {
  width: 300px;
  object-fit: contain;
}
.right {
  width: 60%;
  padding-right: 2rem;
}
.right h2 {
  margin: 1.5rem 0;
  font-size: 2.5em;
  font-weight: 300;
  border: none;
}
.right h2 div.reliable {
  font-weight: 400;
}
.right p {
  margin: 0;
  line-height: 1.6;
}
.right a {
  color: var(--vp-c-brand-1, #ff6600);
  text-decoration: none;
}
.right a:hover {
  color: var(--vp-c-brand-2, #e55d00);
  text-decoration: underline !important;
}
@media (max-width: 768px) {
  .section-opensource {
    flex-direction: column;
  }
  .left, .right {
    width: 100%;
    padding: 1rem;
    box-sizing: border-box;
  }
  .right h2, .right p {
    text-align: center;
  }
}
</style>
