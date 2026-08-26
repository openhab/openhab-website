import { defineConfig } from 'vitepress'
import { tabsMarkdownPlugin } from 'vitepress-plugin-tabs'
import { RssPlugin } from 'vitepress-plugin-rss'
import { fileURLToPath } from 'url'
import path from 'path'
import fs from 'fs'

// Load TextMate grammars
import openhabDslGrammar from './grammars/openhab-dsl.tmLanguage.json' with { type: 'json' }
import openhabRulesGrammar from './grammars/openhab-rules.tmLanguage.json' with { type: 'json' }

const __dirname = path.dirname(fileURLToPath(import.meta.url))

// Helper to safely load CommonJS / generated sidebar files if they exist
function safeRequire(filePath: string, fallback: any = []) {
  const resolved = path.resolve(__dirname, filePath)
  if (fs.existsSync(resolved)) {
    try {
      // In ESM, read or parse JSON/JS
      const content = fs.readFileSync(resolved, 'utf-8')
      if (content.includes('module.exports =')) {
        const jsonStr = content.replace('module.exports =', '').trim()
        return JSON.parse(jsonStr)
      }
      return fallback
    } catch {
      return fallback
    }
  }
  return fallback
}

// Convert VuePress sidebar structure to VitePress sidebar items
function transformAddonSidebar(items: any[]): any[] {
  if (!Array.isArray(items)) return []
  return items.map((item) => {
    if (Array.isArray(item) && item.length === 2) {
      const [p, title] = item
      const link = p.startsWith('/') ? p : `/addons/${p}`
      return { text: title, link }
    }
    if (typeof item === 'string') {
      const link = item.startsWith('/') ? item : `/addons/${item}`
      return { text: item, link }
    }
    if (item && typeof item === 'object') {
      return {
        text: item.title || item.text,
        link: item.path || item.link,
        items: item.children ? transformAddonSidebar(item.children) : (item.items ? transformAddonSidebar(item.items) : undefined),
        collapsed: item.collapsible !== false ? false : undefined,
      }
    }
    return item
  })
}

const noAddons = process.env.OH_NOADDONS

let docsVersion: string
if (!process.env.OH_DOCS_VERSION) {
  docsVersion = 'Pull Request'
} else {
  docsVersion = process.env.OH_DOCS_VERSION
    .replace('final-stable', 'Stable')
    .replace('final-', '')
    .replace('final', 'Latest')
    .replace('.x', '')
}

const docsSidebar = safeRequire('./openhab-docs/.vuepress/docs-sidebar.js', [])
const addonsBindings = transformAddonSidebar(safeRequire('./addons-bindings.js', []))
const addonsIntegrations = transformAddonSidebar(safeRequire('./addons-integrations.js', []))
const addonsAutomation = transformAddonSidebar(safeRequire('./addons-automation.js', []))
const addonsPersistence = transformAddonSidebar(safeRequire('./addons-persistence.js', []))
const addonsTransformations = transformAddonSidebar(safeRequire('./addons-transformations.js', []))
const addonsVoice = transformAddonSidebar(safeRequire('./addons-voice.js', []))
const addonsUi = transformAddonSidebar(safeRequire('./addons-ui.js', []))

export default defineConfig({
  title: 'openHAB',
  description: 'openHAB - a vendor and technology agnostic open source automation software for your home',
  srcExclude: noAddons ? ['addons/**'] : [],
  head: [
    ['meta', { name: 'viewport', content: 'width=device-width, initial-scale=1' }],
    ['link', { rel: 'icon', href: '/favicon.ico' }],
    ['link', { rel: 'shortcut icon', href: '/favicon.ico' }],
    ['link', { rel: 'apple-touch-icon', href: '/apple-icon.png' }],
    ['meta', { property: 'og:type', content: 'website' }],
    ['meta', { property: 'og:image', content: 'https://www.openhab.org/og-image.png' }],
  ],
  markdown: {
    languages: [
      openhabDslGrammar as any,
      openhabRulesGrammar as any,
    ],
    languageAlias: {
      dsl: 'openhab-dsl',
      conf: 'openhab-dsl',
      rules: 'openhab-rules',
      shell: 'bash',
      sh: 'bash',
      shell_session: 'bash',
    },
    config(md) {
      md.use(tabsMarkdownPlugin)
    },
  },
  vite: {
    plugins: [
      RssPlugin({
        title: 'openHAB',
        baseUrl: 'https://www.openhab.org',
        description: 'openHAB News and Announcements',
        filter: (post: any) => post.filepath && post.filepath.startsWith('blog/'),
      }),
    ],
  },
  themeConfig: {
    logo: {
      light: '/openhab-logo-empowering.svg',
      dark: '/openhab-logo-empowering.svg',
    },
    siteTitle: false,
    search: {
      provider: 'local',
      options: {
        detailedView: true,
      },
    },
    nav: [
      { text: 'Download', link: '/download/' },
      { text: 'Documentation', link: '/docs/' },
      { text: 'Add-ons', link: '/addons/' },
      { text: 'Community', link: '/community/' },
      { text: 'Blog', link: '/blog/' },
      {
        text: 'About',
        items: [
          {
            text: 'Get Involved',
            items: [
              { text: 'Who We Are', link: '/about/who-we-are' },
              { text: 'Contribute', link: '/about/contributing' },
              { text: 'Events', link: '/about/events' },
            ],
          },
          {
            text: 'Support openHAB',
            items: [
              { text: 'Foundation', link: 'https://openhabfoundation.org/' },
              { text: 'Donate', link: '/about/donate' },
            ],
          },
          {
            text: 'Resources',
            items: [
              { text: 'Showcase/How-tos', link: '/about/showcase' },
              { text: 'Privacy Policy', link: '/privacy' },
              { text: 'Trademark Policy', link: '/about/trademark' },
              { text: 'Artwork', link: '/artwork' },
              { text: 'Feed Overview', link: '/about/feeds' },
              { text: 'myopenHAB', link: 'https://www.myopenhab.org/' },
            ],
          },
        ],
      },
      { text: 'GitHub', link: 'https://github.com/openhab' },
    ],
    sidebar: {
      '/docs/': docsSidebar.length > 0 ? docsSidebar : [
        {
          text: 'Documentation',
          items: [
            { text: 'Introduction', link: '/docs/' },
          ],
        },
      ],
      '/addons/': noAddons
        ? []
        : [
            { text: 'Bindings', collapsed: false, items: addonsBindings },
            { text: 'System Integrations', collapsed: false, items: addonsIntegrations },
            { text: 'Automation', collapsed: false, items: addonsAutomation },
            { text: 'Data Persistence', collapsed: false, items: addonsPersistence },
            { text: 'Data Transformation', collapsed: false, items: addonsTransformations },
            { text: 'Voice', collapsed: false, items: addonsVoice },
            { text: 'User Interface', collapsed: false, items: addonsUi },
          ],
    },
  },
})
