<template>
  <div class="page-versions">
    <ul class="version-switcher">
      <li>
        <a :href="siteUrl('Stable') || undefined" class="version-button" :class="{ current: currentVersion === 'Stable' }">
          Stable <small v-if="stableVersion">({{ stableVersion }})</small>
        </a>
      </li>
      <li>
        <a :href="siteUrl('Latest') || undefined" class="version-button" :class="{ current: currentVersion === 'Latest' }">
          Latest <small v-if="latestVersion">({{ latestVersion }})</small>
        </a>
      </li>
    </ul>
    <div class="archived-versions" v-if="previousVersions.length > 0">
      <div class="dropdown-wrapper" :class="{ archiveDropdownOpen }">
        <a class="dropdown-title" @click="archiveDropdownOpen = !archiveDropdownOpen">
          <span class="title">Archived</span>
          <span class="arrow down"></span>
        </a>
        <ul class="nav-dropdown" v-show="archiveDropdownOpen">
          <li v-for="version in previousVersions" :key="version.version" class="dropdown-item">
            <a :href="siteUrl(version) || undefined">{{ version.version }}</a>
          </li>
        </ul>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useData } from 'vitepress'

const { page, theme } = useData()

const currentVersion = ref('Pull Request')
const stableVersion = ref('')
const latestVersion = ref('')
const previousVersions = ref<any[]>([])
const archiveDropdownOpen = ref(false)

function siteUrl(version: any) {
  if (version === currentVersion.value) return null
  const currentPath = page.value.relativePath || ''
  const section = currentPath.split('/')[0] || 'docs'

  if (version === 'Stable') {
    return 'https://www.openhab.org/' + section + '/'
  } else if (version === 'Latest') {
    return 'https://next.openhab.org/' + section + '/'
  } else if (version && typeof version === 'object' && version.website) {
    return version.website + section + '/'
  }
  return null
}

onMounted(async () => {
  currentVersion.value = (theme.value as any).docsVersion || 'Latest'
  try {
    // Attempt to load download page frontmatter if present
    const downloadData = await import('../../download/index.md')
    if (downloadData && downloadData.frontmatter) {
      stableVersion.value = downloadData.frontmatter.currentVersion || ''
      latestVersion.value = (downloadData.frontmatter.currentSnapshotVersion || '').replace('-SNAPSHOT', '')
      previousVersions.value = downloadData.frontmatter.previousVersions || []
    }
  } catch {
    // Fallback if not loaded
  }
})
</script>

<style scoped>
.page-versions {
  margin-top: 1rem;
}
.version-switcher {
  list-style-type: none;
  padding: 0.5rem;
  display: flex;
  flex-direction: row;
  justify-content: center;
  gap: 0.5rem;
}
.version-switcher .version-button {
  display: inline-block;
  min-width: 5.5rem;
  border: 1px solid var(--vp-c-text-1, #2c3e50);
  color: var(--vp-c-text-1, #2c3e50);
  background: transparent;
  font-family: 'Open Sans', sans-serif;
  font-weight: 300;
  font-size: 13px;
  padding: 4px 8px;
  cursor: pointer;
  text-align: center;
  border-radius: 4px;
}
.version-switcher .version-button.current {
  background: var(--vp-c-brand-1, #ff6600);
  border-color: var(--vp-c-brand-1, #ff6600);
  color: #fff;
  cursor: default;
}
.archived-versions {
  white-space: nowrap;
  font-size: 9pt;
  user-select: none;
  display: flex;
  flex-direction: row;
  justify-content: center;
  margin-top: 0.5rem;
}
.dropdown-title {
  display: block;
  font-size: 13px;
  color: var(--vp-c-text-2, #666);
  cursor: pointer;
}
.nav-dropdown {
  list-style: none;
  padding: 10px;
  background-color: var(--vp-c-bg-elv, #fff);
  border: 1px solid var(--vp-c-border, #eee);
  border-radius: 6px;
  box-shadow: 0 4px 12px rgba(0,0,0,0.1);
  position: absolute;
  z-index: 99;
}
</style>
