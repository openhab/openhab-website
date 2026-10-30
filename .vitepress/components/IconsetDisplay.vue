<template>
  <div>
    <h2>Places</h2>
    <div>
      <div class="iconset-icons">
        <div class="iconset-icon" v-for="icon in existingIcons(categories.places).sort()" :key="icon">
          <img :src="iconFile(icon)" :alt="icon" />
          <span>{{ icon }}</span>
        </div>
      </div>
    </div>
    <h2>Things</h2>
    <div class="iconset-icons">
      <div class="iconset-icon" v-for="icon in existingIcons(categories.things).sort()" :key="icon">
        <img :src="iconFile(icon)" :title="iconTooltip(icon)" :alt="icon" />
        <span>{{ icon }}</span>
      </div>
    </div>
    <h2>Channels</h2>
    <div v-for="subcategory in channelSubcategories" :key="subcategory">
      <h3>{{ subcategory }}</h3>
      <div class="iconset-icons">
        <div class="iconset-icon" v-for="icon in existingIcons(categories.channels[subcategory] || []).sort()" :key="icon">
          <img :src="iconFile(icon)" :title="iconTooltip(icon)" :alt="icon" />
          <span>{{ icon }}</span>
        </div>
      </div>
    </div>
    <h2>Other Icons</h2>
    <div class="iconset-icons">
      <div class="iconset-icon" v-for="icon in icons_without_category.sort()" :key="icon">
        <img :src="iconFile(icon)" :title="iconTooltip(icon.replace('.svg', ''))" :alt="icon" />
        <span>{{ icon.replace('.svg', '') }}</span>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { useData, withBase } from 'vitepress'

const props = defineProps<{
  icons?: string
}>()

const { frontmatter } = useData()

// Load all icon SVG assets directly via Vite
const iconModules = import.meta.glob<string>(
  '../../docs/configuration/iconsets/classic/icons/*.svg',
  { eager: true, import: 'default' }
)

// Map simple filename (e.g. "alarm.svg") to resolved asset URL
const iconMap = new Map<string, string>()
for (const [key, value] of Object.entries(iconModules)) {
  const filename = key.split('/').pop()
  if (filename && typeof value === 'string') {
    iconMap.set(filename, value)
  }
}

const allIconsList = computed(() => {
  if (props.icons) {
    return props.icons.split(',')
  }
  return Array.from(iconMap.keys())
})

const categories = computed(() => frontmatter.value.categories || { places: [], things: [], channels: {} })
const channelSubcategories = computed(() => Object.keys(categories.value.channels || {}))

function existingIcons(category: string[]) {
  if (!Array.isArray(category)) return []
  return category.filter((i) => allIconsList.value.includes(i + '.svg') || iconMap.has(i + '.svg'))
}

function iconFile(icon: string) {
  const filename = icon.endsWith('.svg') ? icon : `${icon}.svg`
  return iconMap.get(filename) || withBase(`/iconsets/classic/${filename}`) || withBase(`/docs/configuration/iconsets/classic/icons/${filename}`)
}

function iconTooltip(icon: string) {
  return allIconsList.value
    .filter((i) => i.indexOf(icon + '.svg') === 0 || i.indexOf(icon + '-') === 0)
    .map((i) => i.replace('.svg', ''))
    .join(' ')
}

const icons_without_category = computed(() => {
  const cats = categories.value
  const places = cats.places || []
  const things = cats.things || []
  const channels = cats.channels || {}

  return allIconsList.value.filter(
    (i) =>
      i.indexOf('-') < 0 &&
      places.indexOf(i.replace('.svg', '')) < 0 &&
      things.indexOf(i.replace('.svg', '')) < 0 &&
      Object.values(channels).every((c: any) => (c || []).indexOf(i.replace('.svg', '')) < 0)
  )
})
</script>

<style scoped>
.iconset-icons {
  display: flex;
  flex-direction: row;
  flex-wrap: wrap;
  gap: 10px;
}
.iconset-icons .iconset-icon {
  width: 96px;
  height: 96px;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-direction: column;
  font-size: 10pt;
  text-align: center;
}
.iconset-icons .iconset-icon img {
  height: 64px;
  width: 64px;
  object-fit: contain;
}
</style>
