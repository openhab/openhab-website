<template>
  <section class="alert-banner">
    <div class="alert">
      {{ frontmatter.alert }}
    </div>
    <div class="alert-button-container">
      <a
        v-if="frontmatter.alert_link && frontmatter.alert_link.indexOf('http') === 0"
        :href="frontmatter.alert_link"
        class="alert-button slide"
      >
        {{ frontmatter.alert_label || 'Read More' }} ➜
      </a>
      <a v-else :href="withBase(frontmatter.alert_link || '/blog/')" class="alert-button slide">
        {{ frontmatter.alert_label || 'Read the Blog' }} ➜
      </a>
    </div>
  </section>
</template>

<script setup lang="ts">
import { useData, withBase } from 'vitepress'

const { frontmatter } = useData()
</script>

<style scoped>
.alert-banner {
  background-color: #ff4411;
  font-size: 1.6rem;
  padding: 0.8rem 1.5rem;
  color: white;
  text-align: center;
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 1rem;
}
.alert {
  font-weight: 500;
}
.alert-button {
  display: inline-block;
  font-family: 'Open Sans', sans-serif;
  font-size: 1rem;
  font-weight: bold;
  color: white;
  padding: 0.6rem 1.4rem;
  border-radius: 4px;
  box-sizing: border-box;
  border: 2px solid white;
  text-decoration: none;
  transition: all 0.2s;
}
.alert-button:hover {
  background-color: white;
  color: #ff6600;
}
@media (max-width: 479px) {
  .alert-banner {
    flex-direction: column;
    font-size: 1.2rem;
  }
}
</style>
