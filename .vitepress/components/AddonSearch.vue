<template>
  <div class="addon-search">
    <input
      type="text"
      class="filter"
      v-model="filter"
      :placeholder="`Search ${addons.length} add-ons & ${things.length} things`"
    />

    <em v-if="results">
      {{ resultsText }}
    </em>
    <em v-else-if="filter.length > 0 && filter.length < 3">
      Please type 3 characters or more...
    </em>
    <div v-else>
      <div v-for="(addontype, typeid) of frontmatter.initial_gallery" :key="typeid">
        <h3 class="addon-type" :id="typeid">
          <a :href="'#' + typeid" aria-hidden="true" class="header-anchor">#</a>
          {{ addontype.title }}
        </h3>
        <p>{{ addontype.description }}</p>
        <ul class="display-mode-toggle" v-if="!addontype.all">
          <li>
            <button :disabled="showAllAddons.indexOf(typeid) < 0" @click="switchDisplayMode(typeid, false)">
              Featured
            </button>
          </li>
          <li>
            <button :disabled="showAllAddons.indexOf(typeid) >= 0" @click="switchDisplayMode(typeid, true)">
              All
            </button>
          </li>
        </ul>
        <ul class="addons">
          <li v-for="addon of galleryAddons[typeid]" class="addon" :key="addon.url">
            <a :href="withBase(addon.url)">
              <div class="version" v-if="addon.since === '1x'"><span class="v1">v1</span></div>
              <div class="main">
                <img
                  v-if="addon.logo"
                  :src="withBase(addon.logo.replace('images/addons/', '/logos/'))"
                  :title="addon.label"
                  :alt="addon.label"
                />
                <strong v-else>
                  <img :src="withBase('/openhab-logo-square.svg')" width="60" alt="" /><br />{{ addon.label }}
                </strong>
              </div>
              <div class="type">{{ addon.label }}</div>
            </a>
          </li>
        </ul>
      </div>
    </div>

    <div v-if="results" class="search-results">
      <ul v-if="results.addons.length > 0" class="addons">
        <li v-for="addon of results.addons" class="addon" :key="addon.url">
          <a :href="withBase(addon.url)">
            <div class="version" v-if="addon.since === '1x'"><span class="v1">v1</span></div>
            <div class="main">
              <img
                v-if="addon.logo"
                :src="withBase(addon.logo.replace('images/addons/', '/logos/'))"
                :title="addon.label"
                :alt="addon.label"
              />
              <strong v-else>
                <img :src="withBase('/openhab-logo-square.svg')" width="60" alt="" /><br />{{ addon.label }}
              </strong>
            </div>
            <div class="type">{{ addon.title }}</div>
          </a>
        </li>
      </ul>
      <em v-else>No Add-on matching your query was found.</em>

      <div v-if="results.things.length > 0">
        <h2>Things</h2>
        <ul class="things">
          <li v-for="thing of results.things" class="thing" :key="thing.id">
            <strong>
              <a
                v-if="thing.bindingId === 'zwave'"
                :href="withBase('/addons/bindings/zwave/thing.html?thingTypeUID=' + thing.id.replace('zwave:', ''))"
              >
                {{ thing.label }}
              </a>
              <span v-else>{{ thing.label }}</span>
            </strong>
            handled by the
            <a :href="withBase('/addons/bindings/' + thing.bindingId + '/')">{{ thing.bindingId }}</a> binding
          </li>
        </ul>
      </div>
      <em v-else-if="filter.length >= 3">No Thing matching your query was found.</em>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'
import { useData, withBase } from 'vitepress'
import { data as allAddons } from '../theme/addons.data'

const { frontmatter } = useData()

const filter = ref('')
const things = ref<any[]>([])
const showAllAddons = ref<string[]>([])

const addons = computed(() => allAddons || [])

function switchDisplayMode(type: string, showAll: boolean) {
  if (showAll) {
    if (!showAllAddons.value.includes(type)) {
      showAllAddons.value.push(type)
    }
  } else {
    const idx = showAllAddons.value.indexOf(type)
    if (idx >= 0) {
      showAllAddons.value.splice(idx, 1)
    }
  }
}

const galleryAddons = computed(() => {
  const gallery = frontmatter.value.initial_gallery || {}
  const res: Record<string, any[]> = {}

  for (const type in gallery) {
    if (!addons.value.length) {
      res[type] = []
      continue
    }

    if (showAllAddons.value.includes(type)) {
      res[type] = addons.value.filter((p) => p.type === type)
    } else {
      const featuredIds = gallery[type]?.featured || []
      res[type] = featuredIds
        .map((id: string) => addons.value.find((p) => p.id === id && p.type === type))
        .filter(Boolean)
    }
  }
  return res
})

const results = computed(() => {
  const query = filter.value.trim().toLowerCase()
  if (query.length < 3) return null

  return {
    addons: addons.value.filter(
      (p) =>
        (p.label && p.label.toLowerCase().includes(query)) ||
        (p.description && p.description.toLowerCase().includes(query)) ||
        (p.id && p.id.toLowerCase().includes(query))
    ),
    things: things.value.filter(
      (t) =>
        (t.label && t.label.toLowerCase().includes(query)) ||
        (t.bindingId && t.bindingId.toLowerCase().includes(query))
    ),
  }
})

const resultsText = computed(() => {
  if (!results.value) return ''
  const found: string[] = []
  if (!results.value.addons.length && !results.value.things.length) return 'Nothing found'
  if (results.value.addons.length) {
    found.push(`${results.value.addons.length} add-on${results.value.addons.length === 1 ? '' : 's'}`)
  }
  if (results.value.things.length) {
    found.push(`${results.value.things.length} thing${results.value.things.length === 1 ? '' : 's'}`)
  }
  return found.join(' and ') + ' found'
})

onMounted(async () => {
  try {
    const res = await fetch(withBase('/thing-types.json'))
    if (res.ok) {
      things.value = await res.json()
    }
  } catch {
    things.value = []
  }
})
</script>

<style scoped>
.filter {
  width: 90%;
  font-size: 1.1rem;
  padding: 0.8rem 1rem 0.8rem 2.5rem;
  border: 1px solid var(--vp-c-border, #ccc);
  border-radius: 2rem;
  background: var(--vp-c-bg-elv, #fff) url(/images/search.svg) 0.7rem 1rem no-repeat;
  outline: none;
  color: var(--vp-c-text-1, #000);
}

.filter:focus,
.filter:active {
  border-color: var(--vp-c-brand-1, #ff6600);
}

h3.addon-type {
  font-family: 'Open Sans', sans-serif;
  font-weight: normal;
  font-size: 1.5rem;
  margin-top: 2rem;
}

.display-mode-toggle {
  list-style-type: none;
  padding: 0.5rem;
  display: flex;
  flex-direction: row;
  justify-content: center;
  gap: 0.5rem;
}

.display-mode-toggle button {
  width: 7rem;
  background: var(--vp-c-bg-elv, #fff);
  border: 1px solid var(--vp-c-brand-1, #ff6600);
  color: var(--vp-c-brand-1, #ff6600);
  font-family: 'Open Sans', sans-serif;
  font-weight: 300;
  font-size: 14px;
  padding: 4px;
  cursor: pointer;
  border-radius: 4px;
}

.display-mode-toggle button[disabled] {
  background: var(--vp-c-brand-1, #ff6600);
  color: #fff;
  cursor: not-allowed;
}

.addon-search em {
  display: block;
  padding-top: 0.5rem;
}

.addons {
  list-style-type: none;
  display: flex;
  flex-wrap: wrap;
  padding-left: 0;
  gap: 10px;
}

.addons .addon {
  width: 190px;
  height: 190px;
  border: 1px solid var(--vp-c-border, #eee);
  border-radius: 8px;
  display: flex;
  background: var(--vp-c-bg-elv, #fff);
  box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.08);
  transition: all 0.3s;
}

.addons .addon:hover {
  border-color: var(--vp-c-brand-1, #ff6600);
  box-shadow: 2px 2px 8px rgba(0, 0, 0, 0.15);
  transform: translateY(-2px);
}

.addons .addon a {
  width: 100%;
  height: 100%;
  padding: 8px;
  text-align: center;
  display: flex;
  flex-direction: column;
  color: var(--vp-c-text-1, #000);
  text-decoration: none;
}

.addons .addon a .main {
  flex-grow: 1;
  display: flex;
  align-items: center;
  justify-content: center;
}

.addons .addon a .main img {
  max-width: 160px;
  max-height: 120px;
  object-fit: contain;
}

.addons .addon a .type {
  font-weight: normal;
  font-size: 10pt;
  margin-top: auto;
}

@media (max-width: 479px) {
  .addons .addon {
    width: 140px;
    height: 140px;
  }
  .addons .addon a .main img {
    max-width: 120px;
    max-height: 80px;
  }
}
</style>
