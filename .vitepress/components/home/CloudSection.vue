<template>
  <div class="cloud-section">
    <div class="cloud-text">
      <ScrollOnReveal classes="cloud-left" :delay="0" :scale="1.0">
        <h2>No Cloud Required...</h2>
        <p>
          openHAB runs on your hardware, doesn't require any cloud service to work, keeps your data privately at home and talks directly to your local devices whenever possible.
          At the core of our <a :href="withBase('/about/who-we-are.html')">philosophy</a> is that you always remain in control.
        </p>
      </ScrollOnReveal>
      <ScrollOnReveal classes="cloud-right" :delay="200" :scale="1.0">
        <h2>...but Cloud-Friendly</h2>
        <p>
          Integrations are available for the most popular cloud-based smart home platforms, including
          <a :href="withBase('/docs/ecosystem/google-assistant')">Google Assistant</a>,
          <a :href="withBase('/docs/ecosystem/alexa')">Amazon Alexa</a>,
          <a :href="withBase('/addons/integrations/homekit/')">Apple HomeKit</a> and more.
          Use the openHAB Cloud connector with the free
          <a target="_blank" href="https://www.myopenhab.org/" rel="noopener noreferrer">myopenhab.org</a> service or host your own.
        </p>
      </ScrollOnReveal>
    </div>
    <div class="cloud-bkg">
      <div class="cloud-left-bkg">
        <ScrollOnReveal origin="left" distance="120px" :duration="800" :delay="400" :scale="1.0">
          <img class="cloud-left-bkg-img" src="./images/lock-bkg.png" alt="" />
        </ScrollOnReveal>
      </div>
      <div class="cloud-right-bkg">
        <ScrollOnReveal origin="right" distance="120px" :duration="800" :delay="400" :scale="1.0">
          <img class="cloud-right-bkg-img" src="./images/cloud-bkg.png" alt="" />
        </ScrollOnReveal>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { withBase } from 'vitepress'
import ScrollOnReveal from '../ScrollOnReveal.vue'
</script>

<style scoped>
.cloud-section {
  background-color: #f2f2f2;
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
  text-decoration: none;
}
.cloud-text a:hover {
  text-decoration: underline;
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
