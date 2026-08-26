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
  ignoreDeadLinks: true,
  head: [
    ['meta', { name: 'viewport', content: 'width=device-width, initial-scale=1' }],
    ['link', { rel: 'icon', href: '/favicon.ico' }],
    ['link', { rel: 'shortcut icon', href: '/favicon.ico' }],
    ['link', { rel: 'apple-touch-icon', href: '/apple-icon.png' }],
    ['meta', { property: 'og:type', content: 'website' }],
    ['meta', { property: 'og:image', content: 'https://www.openhab.org/og-image.png' }],
    ['link', { rel: 'preconnect', href: 'https://fonts.googleapis.com' }],
    ['link', { rel: 'preconnect', href: 'https://fonts.gstatic.com', crossorigin: '' }],
    ['link', { rel: 'stylesheet', href: 'https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,300..800;1,300..800&display=swap' }],
  ],
  markdown: {
    languages: [
      openhabDslGrammar as any,
      openhabRulesGrammar as any,
    ],
    languageAlias: {
      shell: 'bash',
      sh: 'bash',
      shell_session: 'bash',
    },
    config(md) {
      md.use(tabsMarkdownPlugin)

      const KNOWN_TAGS = new Set([
        'a', 'abbr', 'address', 'article', 'aside', 'audio', 'b', 'bdi', 'bdo', 'blockquote', 'br', 'button',
        'canvas', 'caption', 'cite', 'code', 'col', 'colgroup', 'data', 'datalist', 'dd', 'del', 'details',
        'dfn', 'dialog', 'div', 'dl', 'dt', 'em', 'embed', 'fieldset', 'figcaption', 'figure', 'footer',
        'form', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'header', 'hgroup', 'hr', 'i', 'iframe', 'img', 'input',
        'ins', 'kbd', 'label', 'legend', 'li', 'main', 'map', 'mark', 'menu', 'meter', 'nav', 'noscript',
        'object', 'ol', 'optgroup', 'option', 'output', 'p', 'picture', 'pre', 'progress', 'q', 'rp', 'rt',
        'ruby', 's', 'samp', 'section', 'select', 'small', 'source', 'span', 'strong', 'style', 'sub',
        'summary', 'sup', 'table', 'tbody', 'td', 'template', 'textarea', 'tfoot', 'th', 'thead', 'time',
        'tr', 'track', 'u', 'ul', 'var', 'video', 'wbr', 'svg', 'path', 'g', 'animatetransform', 'use',
        'clientonly', 'client-only', 'editpagelink', 'edit-page-link', 'footer', 'docpreviousversions',
        'doc-previous-versions', 'addonlogo', 'addon-logo', 'addonsearch', 'addon-search', 'blogpostlist',
        'blog-post-list', 'eventslist', 'events-list', 'calendaricon', 'calendar-icon', 'communitytutorials',
        'community-tutorials', 'consentbanner', 'consent-banner', 'homesections', 'home-sections',
        'iconsetdisplay', 'iconset-display', 'inlineimage', 'inline-image', 'installinstructions',
        'install-instructions', 'propblock', 'prop-block', 'propdescription', 'prop-description',
        'propgroup', 'prop-group', 'propoption', 'prop-option', 'propoptions', 'prop-options',
        'scrollonreveal', 'scroll-on-reveal', 'thingdocrenderer', 'thing-doc-renderer', 'tab', 'tabs',
        'content', 'badge', 'vphome', 'vpdoc', 'vpnav', 'vpsidebar', 'vpfooter'
      ])

      function escapeText(text: string) {
        return text
          .replace(/\{\{/g, '&#123;&#123;')
          .replace(/\}\}/g, '&#125;&#125;')
      }

      function escapeUnknownTags(html: string) {
        return html.replace(/<(\/?)([a-zA-Z0-9_\-:]+)([^>]*)>/g, (match, closeSlash, tagName, rest) => {
          const lowerName = tagName.toLowerCase()
          if (KNOWN_TAGS.has(lowerName)) {
            return match
          }
          return `&lt;${closeSlash}${tagName}${rest}&gt;`
        })
      }

      const defaultTextRender = md.renderer.rules.text || ((tokens, idx) => md.utils.escapeHtml(tokens[idx].content))
      md.renderer.rules.text = (tokens, idx, options, env, self) => {
        const rendered = defaultTextRender(tokens, idx, options, env, self)
        return escapeText(rendered)
      }

      const defaultHtmlInlineRender = md.renderer.rules.html_inline || ((tokens, idx) => tokens[idx].content)
      md.renderer.rules.html_inline = (tokens, idx, options, env, self) => {
        const content = tokens[idx].content
        if (content.startsWith('<!--')) return content
        const processed = escapeUnknownTags(content)
        return escapeText(processed)
      }

      const defaultHtmlBlockRender = md.renderer.rules.html_block || ((tokens, idx) => tokens[idx].content)
      md.renderer.rules.html_block = (tokens, idx, options, env, self) => {
        const content = tokens[idx].content
        if (content.startsWith('<!--')) return content
        const processed = escapeUnknownTags(content)
        return escapeText(processed)
      }
    },
  },
  vue: {
    template: {
      transformAssetUrls: {
        includeAbsolute: false,
      },
      compilerOptions: {
        isCustomElement: (tag) => tag.includes('-'),
      },
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
    socialLinks: [
      { icon: 'github', link: 'https://github.com/openhab' },
      { icon: 'x', link: 'https://x.com/openhab' },
      { icon: 'youtube', link: 'https://www.youtube.com/channel/UC7OK88DW0La_BJlcXZg8ydQ' },
    ],
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
