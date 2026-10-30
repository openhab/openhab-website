<template>
  <div class="rendered" v-html="rendered" />
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'

const rendered = ref('Please wait...')

onMounted(async () => {
  try {
    const MarkdownIt = (await import('markdown-it')).default
    const md = new MarkdownIt()
    const baseUrl = 'https://raw.githubusercontent.com/openhab/openhab-docs/final/_addons_bindings/zwave'

    const urlParams = new URLSearchParams(window.location.search)
    let url = ''
    const thingTypeUID = urlParams.get('thingTypeUID')

    if (thingTypeUID) {
      const thingUIDParts = thingTypeUID.split('_')
      const manufacturer = thingUIDParts.shift()
      const model = thingUIDParts.map((part, idx) => (idx > 0 ? parseInt(part, 10) : part)).join('_')
      url = `${baseUrl}/doc/${manufacturer}/${model}.md`
    } else {
      const manufacturer = urlParams.get('manufacturer') || ''
      const file = (urlParams.get('file') || '').replace('.html', '.md')
      url = `${baseUrl}/doc/${manufacturer}/${file}`
    }

    const resp = await fetch(url)
    if (resp.status >= 300) {
      rendered.value = `Cannot render ${url}: ${resp.statusText}`
    } else {
      let text = await resp.text()
      text = text.replace(/---[\s\S]*?.*%}/gm, '')
      rendered.value = md.render(text)
    }
  } catch (e: any) {
    rendered.value = `Cannot render: ${e?.message || e}`
  }
})
</script>

<style scoped>
.rendered :deep(h1:first-child) {
  font-family: 'Open Sans', sans-serif;
  font-weight: 400;
}
</style>
