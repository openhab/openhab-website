<template>
  <section class="alternativeto-banner">
    <ScrollOnReveal :delay="0" :scale="1.0">
      <div class="text">
        openHAB is the
        <a target="_blank" href="https://alternativeto.net/tag/home-automation/?sort=likes" rel="noopener noreferrer">
          Best home automation app
        </a>
        &nbsp;according to crowdsourced software recommendations on
      </div>
    </ScrollOnReveal>
    <ScrollOnReveal :delay="150" :scale="1.0">
      <a class="alternativeto-button" target="_blank" href="https://alternativeto.net/software/openhab/about/" rel="noopener noreferrer">
        <img src="./images/alternativeTo.png" alt="AlternativeTo" />
      </a>
    </ScrollOnReveal>
  </section>
</template>

<script setup lang="ts">
import ScrollOnReveal from '../ScrollOnReveal.vue'
</script>

<style scoped>
.alternativeto-banner {
  background: linear-gradient(#2c4961, #7091a7);
  font-size: 1rem;
  padding: 2rem;
  color: white;
  text-align: center;
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 1rem;
}
.text {
  line-height: 1.7rem;
}
.text a {
  white-space: nowrap;
  background: #3c84b4;
  color: #f4f8fa;
  padding: 4px 8px;
  border-radius: 3px;
  text-decoration: none;
}
.text a:hover {
  color: white;
}
@media (max-width: 768px) {
  .alternativeto-banner {
    flex-direction: column;
  }
}
</style>
