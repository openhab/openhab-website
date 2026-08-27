<template>
  <div class="openhabian-section">
    <div class="openhabian-container">
      <small class="case-attribution">
        <a target="_blank" href="https://www.thingiverse.com/thing:3859848" rel="noopener noreferrer">3d printed case by sumpfing</a>
      </small>
      <img class="openhabian-background" src="./images/pi_case.jpg" alt="raspberry pi" />
      <div class="openhabian-text">
        <h2 class="slide-seq">Set up your own openHAB system in just a few steps</h2>
        <p class="slide-seq">
          Try the provided hassle-free "openHABian" image for the Raspberry Pi and other devices.
          Flash an SD card, boot, and enjoy your up-to-date openHAB setup with conveniently pre-configured system settings and software.
        </p>
        <a :href="withBase('/docs/installation/openhabian.html')" class="learn-how-button slide-seq">Learn How ➜</a>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { withBase } from 'vitepress'
</script>

<style scoped>
.openhabian-section {
  height: 435px;
  background: black;
  color: white;
  z-index: 1;
  display: flex;
  font-family: 'Open Sans', sans-serif;
  font-weight: normal;
  overflow: hidden;
}
.openhabian-container {
  position: relative;
  height: 90vh;
  width: 100%;
  overflow: hidden;
}
.openhabian-background {
  position: absolute;
  object-fit: cover;
  object-position: center;
  margin-top: -20%;
  width: 50%;
  height: 120%;
}
.case-attribution {
  display: none;
  opacity: 0.4;
  z-index: 100;
  position: absolute;
  top: 5px;
  left: 5px;
  font-size: 10px;
}
.case-attribution a {
  color: black;
}
.openhabian-text {
  position: absolute;
  width: 50%;
  left: 50%;
  top: 0;
  text-align: center;
  z-index: 12;
  padding-top: 2rem;
}
.openhabian-text h2 {
  margin: 1.5rem 2rem;
  font-size: 2.3rem;
  line-height: 1.25;
  font-weight: 300;
  border: none;
  text-shadow: 2px 2px 8px #777;
}
.openhabian-text p {
  margin: 0 2rem;
  font-size: 1.05rem;
  line-height: 1.6;
  text-shadow: 2px 2px 10px #333;
}
.learn-how-button {
  display: inline-block;
  font-size: 1rem;
  color: #fff;
  margin: 2rem;
  padding: 0.8rem 1.6rem;
  border-radius: 4px;
  background-color: rgba(0, 0, 0, 0.3);
  transition: all 0.2s;
  box-sizing: border-box;
  border: 1px solid #fff;
  text-decoration: none !important;
}
.learn-how-button:hover {
  background-color: #fff;
  color: black;
  text-decoration: none !important;
}
@media (max-width: 1024px) {
  .openhabian-section {
    height: 400px;
  }
  .openhabian-background {
    width: 100%;
    margin-top: -30%;
    height: 150%;
    opacity: 0.7;
  }
  .openhabian-container {
    height: 550px;
  }
  .openhabian-text {
    width: 100%;
    left: 0;
  }
}
@media (max-width: 480px) {
  .openhabian-section {
    height: 550px;
  }
  .openhabian-text h2 {
    font-size: 1.8rem;
    margin: 1rem;
  }
}
</style>
