<template>
  <div class="editLink" v-if="editUrl">
    <em>
      Caught a mistake or want to contribute to the documentation?
      <a target="_blank" :href="editUrl" rel="noopener noreferrer">Edit this page on GitHub</a>
    </em>
    <div v-if="isEsh" class="esh-note">
      <br />
      &#128712; This page comes from the Eclipse SmartHome project, which has specific
      <a target="_blank" href="https://github.com/eclipse/smarthome/blob/master/CONTRIBUTING.md" rel="noopener noreferrer">
        legal and technical
      </a>
      requirements for accepting contributions, please read them before submitting a change.
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { useData } from 'vitepress'

const { frontmatter } = useData()

const isEsh = computed(() => {
  return Boolean(frontmatter.value.source && frontmatter.value.source.indexOf('eclipse/smarthome') > 0)
})

const editUrl = computed(() => {
  if (!frontmatter.value.source) return null
  return frontmatter.value.source.replace('/blob/', '/edit/').replace('/developer/', '/developers/')
})
</script>

<style scoped>
.editLink {
  border-top: 1px solid var(--vp-c-divider, #eee);
  padding: 1rem 0 1rem 0;
  font-size: 10pt;
  margin-top: 2rem;
}
.esh-note {
  color: #999;
  font-size: 8pt;
}
</style>
