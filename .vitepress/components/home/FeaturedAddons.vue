<template>
  <div class="featured-addons-section">
    <h2>More than 3000 supported things!</h2>
    <div class="logos">
      <a :href="withBase(addon.url)" v-for="addon in featuredAddons" :key="addon.url" class="logo-container">
        <img
          v-if="addon.logo"
          :src="withBase(addon.logo.replace('images/addons/', '/logos/'))"
          class="featured-logo"
          :alt="addon.label || 'Binding logo'"
        />
      </a>
    </div>
    <div class="addons-button-container">
      <a :href="withBase('/addons/')" class="all-addons-button slide">Browse All Add-ons ➜</a>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed, onMounted } from 'vue'
import { withBase } from 'vitepress'
import { data as allAddons } from '../../theme/addons.data'

const featuredAddons = computed(() => {
  return (allAddons || []).filter((p) => p.logo && p.type === 'binding')
})

onMounted(async () => {
  try {
    const ScrollReveal = (await import('scrollreveal')).default
    ScrollReveal().reveal('.featured-logo', {})
  } catch {
    // Ignore in SSR
  }
})
</script>

<style scoped>
.featured-addons-section {
  background: var(--vp-c-bg, white);
  display: flex;
  flex-direction: column;
  padding: 2rem 0;
}
.featured-addons-section h2 {
  text-align: center;
  font-family: 'Open Sans', sans-serif;
  font-weight: normal;
  font-size: 2.5em;
  border: none;
}
.logos {
  padding: 0 5rem;
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  gap: 10px;
}
.logo-container {
  width: 180px;
  height: 180px;
  padding: 10px;
  display: flex;
  align-items: center;
  justify-content: center;
}
.featured-logo {
  margin: auto;
  max-height: 120px;
  max-width: 120px;
  object-fit: contain;
  transition: transform 0.2s;
}
.logo-container:hover .featured-logo {
  transform: scale(1.05);
}
.addons-button-container {
  padding: 2rem;
  text-align: center;
}
.all-addons-button {
  display: inline-block;
  font-family: 'Open Sans', sans-serif;
  font-size: 1rem;
  font-weight: bold;
  color: var(--vp-c-brand-1, #ff6600);
  padding: 0.8rem 1.6rem;
  border-radius: 4px;
  box-sizing: border-box;
  border: 2px solid var(--vp-c-brand-1, #ff6600);
  text-decoration: none;
  transition: all 0.2s;
}
.all-addons-button:hover {
  background-color: var(--vp-c-brand-1, #ff6600);
  color: white;
}
@media (max-width: 768px) {
  .logos {
    padding: 0;
  }
  .logo-container {
    width: 90px;
    height: 100px;
  }
  .featured-logo {
    max-height: 80px;
    max-width: 80px;
  }
}
</style>
