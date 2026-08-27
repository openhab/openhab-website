<template>
  <div class="jumbotron">
    <div class="hero-image"></div>
    <img draggable="false" class="jumbotron-pattern" :src="withBase('/pattern.png')" alt="" />
    <div class="hero-content">
      <div class="white-logo">
        <img :src="withBase('/openhab-logo.svg')" class="white-logo-img" alt="openHAB" />
      </div>
      <h1 class="hero">empowering the smart home</h1>
      <h2 class="lead">a vendor and technology agnostic open source automation software for your home</h2>
      <div class="hero-actions">
        <a :href="withBase('/docs/')" class="action-button">Get Started ➜</a>
        <a class="demo-button" target="_blank" href="https://demo.openhab.org" rel="noopener noreferrer">Try It ➜</a>
      </div>
    </div>
    <div class="phone">
      <div class="iframe-wrapper">
        <iframe :src="withBase('/demo')" frameborder="0" scrolling="no" title="openHAB Interactive Demo" />
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { withBase } from 'vitepress'
</script>

<style scoped>
@keyframes slideIn1 {
  0% {
    transform: translateY(10px);
    opacity: 0;
  }
  40% {
    transform: translateY(0);
    opacity: 1;
  }
}

@keyframes slideIn2 {
  0% {
    transform: translateY(10px);
    opacity: 0;
  }
  40% {
    transform: translateY(10px);
    opacity: 0;
  }
  70% {
    transform: translateY(0);
    opacity: 1;
  }
}

@keyframes slideIn3 {
  0% {
    transform: translateY(10px);
    opacity: 0;
  }
  70% {
    transform: translateY(10px);
    opacity: 0;
  }
  100% {
    transform: translateY(0);
    opacity: 1;
  }
}

.jumbotron {
  background: var(--vp-c-brand-1, #ff6600);
  position: relative;
  min-height: 640px;
  display: flex;
  justify-content: center;
  align-items: center;
  overflow: hidden;
  padding: 4rem 1.5rem 2rem;
  box-sizing: border-box;
}
.jumbotron-pattern {
  opacity: 0.1;
  width: 100%;
  height: 100%;
  position: absolute;
  top: 0;
  left: 0;
  object-fit: cover;
  user-select: none;
}
.hero-content {
  align-self: center;
  margin: 0 2rem;
  z-index: 1;
  max-width: 960px;
}
.white-logo {
  width: 240px;
  height: 80px;
}
.white-logo-img {
  filter: invert(1) grayscale(1) brightness(100) drop-shadow(0 0 10px #666);
}
h1.hero {
  animation: 0.5s ease-out 0s 1 slideIn1;
  color: white;
  font-family: 'Open Sans', sans-serif;
  font-weight: 300;
  font-size: 60px;
  line-height: 1.2;
  text-shadow: 0 0 10px #666;
  margin-top: 15px;
  margin-bottom: 2rem;
}
h2.lead {
  animation: 0.75s ease-out 0s 1 slideIn2;
  color: white;
  border: none;
  font-family: 'Open Sans', sans-serif;
  font-weight: normal;
  font-size: 1.25rem;
  line-height: 1.5;
  text-shadow: 0 0 10px #333;
  margin-top: 0;
  margin-bottom: 2.5rem;
  max-width: 650px;
}
.hero-actions {
  display: flex;
  flex-direction: row;
  flex-wrap: wrap;
  gap: 1.25rem;
  margin-top: 1.5rem;
}
.action-button {
  animation: 1s ease-out 0s 1 slideIn3;
  display: inline-block;
  font-family: 'Open Sans', sans-serif;
  font-size: 1.2rem;
  color: #fff;
  background-color: rgba(255, 51, 0, 0.87);
  padding: 0.9rem 1.8rem;
  border-radius: 4px;
  box-sizing: border-box;
  border: 1px solid #fff;
  text-decoration: none !important;
  transition: all 0.2s;
}
.action-button:hover {
  background-color: #fff;
  color: #ff3300;
  text-decoration: none !important;
}
.demo-button {
  animation: 1.25s ease-out 0s 1 slideIn3;
  display: inline-block;
  font-family: 'Open Sans', sans-serif;
  font-size: 1.2rem;
  color: #fff;
  padding: 0.9rem 1.8rem;
  border-radius: 4px;
  background-color: rgba(255, 255, 255, 0.2);
  box-sizing: border-box;
  border: 1px solid #fff;
  text-decoration: none !important;
  transition: all 0.2s;
}
.demo-button:hover {
  background-color: rgba(255, 255, 255, 0.4);
  text-decoration: none !important;
}
.phone {
  animation: 2s ease-out 0s 1 slideIn3;
  flex-shrink: 0;
  box-shadow: 0 0 20px 10px rgba(0, 0, 0, 0.2);
  width: 385px;
  height: 640px;
  padding: 5px;
  border-radius: 25px;
  background: #000;
  align-self: center;
  margin-left: 60px;
  position: relative;
  margin-right: 20px;
  box-sizing: border-box;
  margin-top: 0;
  z-index: 2;
}
.iframe-wrapper {
  position: relative;
  border-radius: 20px;
  overflow: hidden;
  height: 100%;
}
.iframe-wrapper iframe {
  width: 100%;
  height: 100%;
  border-radius: 20px;
}
.hero-image {
  background: url(/hero3.jpg) bottom 0 left 50% / contain no-repeat;
  width: 95%;
  height: 100%;
  max-height: 700px;
  position: absolute;
  bottom: 0;
  left: 50%;
  transform: translateX(-50%);
  opacity: 0.5;
}
.dark .hero-image {
  background: url(/hero3-dark.jpg) bottom 0 left 50% / contain no-repeat !important;
}
@media (max-width: 1023px) {
  .jumbotron {
    min-height: auto;
    padding: 3.5rem 1.5rem 2.5rem;
  }
  .phone {
    display: none;
  }
}
@media (max-width: 768px) {
  h1.hero {
    font-size: 42px;
    line-height: 1.2;
    margin-bottom: 1rem;
  }
  h2.lead {
    font-size: 1.1rem;
    line-height: 1.4;
  }
}
@media (max-width: 419px) {
  h1.hero {
    font-size: 32px;
    line-height: 1.25;
  }
  h2.lead {
    font-size: 1rem;
    line-height: 1.4;
  }
}
</style>
