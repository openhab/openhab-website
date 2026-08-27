import { defineConfig } from 'vitepress'
import { tabsMarkdownPlugin } from 'vitepress-plugin-tabs'
import { RssPlugin } from 'vitepress-plugin-rss'
import { fileURLToPath } from 'url'
import path from 'path'
import fs from 'fs'

// Load TextMate grammars
import openhabDslGrammar from './grammars/openhab-dsl.tmLanguage.json' with { type: 'json' }

const __dirname = path.dirname(fileURLToPath(import.meta.url))

// Helper to safely load CommonJS / generated sidebar files if they exist
function safeRequire(filePath: string, fallback: any = []) {
  const resolved = path.resolve(__dirname, filePath)
  if (fs.existsSync(resolved)) {
    try {
      const content = fs.readFileSync(resolved, 'utf-8')
      const fn = new Function('module', 'exports', content)
      const module = { exports: {} as any }
      fn(module, module.exports)
      return module.exports || fallback
    } catch {
      return fallback
    }
  }
  return fallback
}

// Convert VuePress docs sidebar structure to VitePress sidebar items
function transformDocsSidebar(items: any[]): any[] {
  if (!Array.isArray(items)) return []
  return items.map((item) => {
    if (Array.isArray(item) && item.length === 2) {
      const [p, title] = item
      const link = p.startsWith('/') ? p : ('/docs/' + p).replace(/\/+/g, '/')
      return { text: title, link }
    }
    if (typeof item === 'string') {
      const p = item.trim()
      const link = p === '' ? '/docs/' : (p.startsWith('/') ? p : ('/docs/' + p)).replace(/\/+/g, '/')
      const text = p === '' ? 'Introduction' : p.split('/').pop()?.replace(/[_-]/g, ' ').replace(/\b\w/g, (c) => c.toUpperCase())
      return { text, link }
    }
    if (item && typeof item === 'object') {
      const children = item.children || item.items
      let collapsed: boolean | undefined = undefined
      if (item.collapsable === false || item.collapsible === false) {
        collapsed = item.collapsed !== undefined ? Boolean(item.collapsed) : undefined
      } else if (item.collapsed !== undefined) {
        collapsed = Boolean(item.collapsed)
      } else if (item.expanded !== undefined) {
        collapsed = !item.expanded
      } else if (item.open !== undefined) {
        collapsed = !item.open
      } else if (item.initialOpen !== undefined) {
        collapsed = !item.initialOpen
      } else if (children) {
        collapsed = true
      }

      return {
        text: item.title || item.text,
        link: item.path || item.link ? (item.path || item.link).replace(/\/+/g, '/') : undefined,
        items: children ? transformDocsSidebar(children) : undefined,
        collapsed,
      }
    }
    return item
  })
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
      const children = item.children || item.items
      let collapsed: boolean | undefined = undefined
      if (item.collapsable === false || item.collapsible === false) {
        collapsed = item.collapsed !== undefined ? Boolean(item.collapsed) : undefined
      } else if (item.collapsed !== undefined) {
        collapsed = Boolean(item.collapsed)
      } else if (item.expanded !== undefined) {
        collapsed = !item.expanded
      } else if (item.open !== undefined) {
        collapsed = !item.open
      } else if (item.initialOpen !== undefined) {
        collapsed = !item.initialOpen
      } else if (children) {
        collapsed = true
      }

      return {
        text: item.title || item.text,
        link: item.path || item.link,
        items: children ? transformAddonSidebar(children) : undefined,
        collapsed,
      }
    }
    return item
  })
}

const docsSidebar = transformDocsSidebar(safeRequire('./openhab-docs/.vuepress/docs-sidebar.js', []))
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
  ignoreDeadLinks: true,
  head: [
    ['meta', { name: 'viewport', content: 'width=device-width, initial-scale=1' }],
    ['link', { rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' }],
    ['link', { rel: 'icon', type: 'image/svg+xml', href: '/openhab-logo-square.svg' }],
    ['link', { rel: 'shortcut icon', href: '/favicon.ico' }],
    ['link', { rel: 'apple-touch-icon', sizes: '180x180', href: '/apple-icon.png' }],
    ['meta', { property: 'og:type', content: 'website' }],
    ['meta', { property: 'og:image', content: 'https://www.openhab.org/og-image.png' }],
    ['link', { rel: 'preconnect', href: 'https://fonts.googleapis.com' }],
    ['link', { rel: 'preconnect', href: 'https://fonts.gstatic.com', crossorigin: '' }],
    ['link', { rel: 'stylesheet', href: 'https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,300..800;1,300..800&display=swap' }],
  ],
  markdown: {
    languages: [
      openhabDslGrammar
    ],
    languageAlias: {
      shell: 'bash',
      sh: 'bash',
      shell_session: 'bash'
    },
    config(md) {
      md.use(tabsMarkdownPlugin)

      // Transform legacy VuePress tab syntax (::: tabs / ::: tab Title / :::) to vitepress-plugin-tabs syntax (:::tabs / == Title)
      function transformLegacyTabs(src: string): string {
        const lines = src.split('\n')
        const result: string[] = []
        let inTabsBlock = false
        let tabsIndent = ''
        let inTab = false

        for (let i = 0; i < lines.length; i++) {
          const line = lines[i]
          const trimmed = line.trim()

          const startTabsMatch = trimmed.match(/^:{3,}\s*tabs\b/)
          if (startTabsMatch && !inTabsBlock) {
            inTabsBlock = true
            tabsIndent = line.match(/^[ \t]*/)?.[0] || ''
            result.push(`${tabsIndent}:::tabs`)
            inTab = false
            continue
          }

          if (inTabsBlock) {
            const tabMatch = trimmed.match(/^:{3,}\s*tab(?:\s+(.*))?$/)
            if (tabMatch) {
              let title = tabMatch[1] ? tabMatch[1].trim() : 'Tab'
              if ((title.startsWith('"') && title.endsWith('"')) || (title.startsWith("'") && title.endsWith("'"))) {
                title = title.slice(1, -1)
              }
              result.push(`${tabsIndent}== ${title}`)
              inTab = true
              continue
            }

            if (trimmed.match(/^:{3,}$/)) {
              if (inTab) {
                inTab = false
                continue
              } else {
                inTabsBlock = false
                result.push(`${tabsIndent}:::`)
                continue
              }
            }

            result.push(line)
            continue
          }

          result.push(line)
        }

        if (inTabsBlock) {
          result.push(`${tabsIndent}:::`)
        }

        return result.join('\n')
      }

      // Pre-processing rule to clean up legacy Jekyll/Liquid syntax and legacy tabs
      md.core.ruler.before('normalize', 'clean_jekyll_syntax', (state) => {
        state.src = transformLegacyTabs(state.src)
          // Remove Jekyll includes and tags: {% include ... %}, {% raw %}, etc.
          .replace(/\{%\s*include\s+[^%]+\s*%\}/g, '')
          .replace(/\{%[^{}%]*%\}/g, '')
          // Replace {{base}} with the actual base path (or empty string if relative/root)
          .replace(/\{\{\s*base\s*\}\}/g, '')
          // Clean up Kramdown attribute syntax like {:target="_blank"} or {: .class}
          .replace(/\{:[^}]+\}/g, '')
          // Replace VuePress 1 webpack require() in component props like :src="require('./...')"
          .replace(/:src="require\((['"])(.*?)\1\)"/g, 'src="$2"')
      })

      // Discover all custom Vue components in component directories
      function getComponentTags(...dirs: string[]) {
        const tags = new Set<string>()
        for (const dir of dirs) {
          const resolved = path.resolve(__dirname, dir)
          if (!fs.existsSync(resolved)) continue
          function scan(currentDir: string) {
            for (const entry of fs.readdirSync(currentDir, { withFileTypes: true })) {
              if (entry.isDirectory()) {
                scan(path.join(currentDir, entry.name))
              } else if (entry.isFile() && entry.name.endsWith('.vue')) {
                const baseName = path.basename(entry.name, '.vue')
                tags.add(baseName.toLowerCase())
                tags.add(baseName.replace(/([a-z0-9])([A-Z])/g, '$1-$2').toLowerCase())
              }
            }
          }
          scan(resolved)
        }
        return tags
      }

      const HTML_TAGS = [
        'a', 'abbr', 'address', 'area', 'article', 'aside', 'audio', 'b', 'base', 'bdi', 'bdo', 'blockquote',
        'body', 'br', 'button', 'canvas', 'caption', 'cite', 'code', 'col', 'colgroup', 'data', 'datalist',
        'dd', 'del', 'details', 'dfn', 'dialog', 'div', 'dl', 'dt', 'em', 'embed', 'fieldset', 'figcaption',
        'figure', 'footer', 'form', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'head', 'header', 'hgroup', 'hr',
        'html', 'i', 'iframe', 'img', 'input', 'ins', 'kbd', 'label', 'legend', 'li', 'link', 'main', 'map',
        'mark', 'math', 'menu', 'meter', 'nav', 'noscript', 'object', 'ol', 'optgroup', 'option',
        'output', 'p', 'param', 'picture', 'pre', 'progress', 'q', 'rb', 'rp', 'rt', 'rtc', 'ruby', 's',
        'samp', 'script', 'search', 'section', 'select', 'slot', 'small', 'source', 'span', 'strong', 'style',
        'sub', 'summary', 'sup', 'svg', 'table', 'tbody', 'td', 'template', 'textarea', 'tfoot', 'th', 'thead',
        'time', 'title', 'tr', 'track', 'u', 'ul', 'var', 'video', 'wbr',
      ]

      const BUILTIN_TAGS = ['clientonly', 'client-only', 'content', 'badge', 'tab', 'tabs', 'outboundlink', 'outbound-link', 'plugintabs', 'plugintabstab', 'plugin-tabs', 'plugin-tabs-tab']
      const customComponents = getComponentTags('./components', '../components', './.vuepress/components', '../.vuepress/components')

      const KNOWN_TAGS = new Set([
        ...HTML_TAGS.map((t) => t.toLowerCase()),
        ...BUILTIN_TAGS,
        ...customComponents,
      ])

      function escapeText(text: string) {
        return text
          .replace(/\{\{/g, '&#123;&#123;')
          .replace(/}}/g, '&#125;&#125;')
      }

      function escapeUnknownTags(html: string) {
        // Matches opening, closing, or self-closing tags: <tag>, </tag>, <tag attr="val">, <tag/>
        return html.replace(/<(\/?)([a-zA-Z][a-zA-Z0-9_\-:]*)([^>]*)>/g, (match, closeSlash, tagName, rest) => {
          const lowerName = tagName.toLowerCase()

          // If it's a recognized HTML tag or Vue component, keep it as HTML
          if (KNOWN_TAGS.has(lowerName)) {
            return match
          }

          // Otherwise, escape the angle brackets so it renders as plain MD / text
          return `&lt;${closeSlash}${tagName}${rest}&gt;`
        })
      }

      const defaultTextRender = md.renderer.rules.text || ((tokens, idx) => md.utils.escapeHtml(tokens[idx].content))
      md.renderer.rules.text = (tokens, idx, options, env, self) => {
        const rendered = defaultTextRender(tokens, idx, options, env, self)
        return escapeText(rendered)
      }

      const defaultCodeInlineRender = md.renderer.rules.code_inline || ((tokens, idx, options, env, self) => self.renderToken(tokens, idx, options))
      md.renderer.rules.code_inline = (tokens, idx, options, env, self) => {
        const rendered = defaultCodeInlineRender(tokens, idx, options, env, self)
        return escapeText(rendered)
      }

      // Post-processing rule to escape unknown tags, clean up unmatched / stray closing tags and balance unclosed elements
      md.core.ruler.push('clean_unmatched_html', (state) => {
        const VOID_TAGS = new Set(['area', 'base', 'br', 'col', 'embed', 'hr', 'img', 'input', 'link', 'meta', 'param', 'source', 'track', 'wbr'])

        function processTokens(tokens: any[], openTags: string[] = []) {
          for (const token of tokens) {
            if (token.type === 'link_open') {
              openTags.push('a')
            } else if (token.type === 'link_close') {
              const idx = openTags.lastIndexOf('a')
              if (idx !== -1) openTags.splice(idx, 1)
            } else if (token.type === 'html_inline' || token.type === 'html_block') {
              if (!token.content.startsWith('<!--')) {
                token.content = token.content.replace(/<(\/?)([a-zA-Z][a-zA-Z0-9_\-:]*)([^>]*)>/g, (match: string, closeSlash: string, tagName: string, rest: string) => {
                  const lower = tagName.toLowerCase()
                  // Unknown tag -> escape as text
                  if (!KNOWN_TAGS.has(lower)) {
                    return `&lt;${closeSlash}${tagName}${rest}&gt;`
                  }
                  if (VOID_TAGS.has(lower) || rest.trim().endsWith('/')) {
                    return match
                  }
                  if (closeSlash === '/') {
                    const idx = openTags.lastIndexOf(lower)
                    if (idx !== -1) {
                      const unclosed = openTags.splice(idx)
                      unclosed.shift()
                      const closingPrefix = unclosed.reverse().map((t) => `</${t}>`).join('')
                      return closingPrefix + match
                    }
                    return `&lt;/${tagName}${rest}&gt;`
                  } else {
                    openTags.push(lower)
                    return match
                  }
                })
              }
            }
            if (token.children) {
              processTokens(token.children, openTags)
            }
          }
        }

        processTokens(state.tokens)
      })

      // Safe fence renderer: don't fail the build on invalid code fence content, log a warning instead
      const defaultFenceRender = md.renderer.rules.fence
      md.renderer.rules.fence = (tokens, idx, options, env, self) => {
        try {
          if (defaultFenceRender) {
            return defaultFenceRender(tokens, idx, options, env, self)
          }
          return self.renderToken(tokens, idx, options)
        } catch (err: any) {
          console.warn(`[markdown fence warning] Failed to highlight code fence:`, err?.message || err)
          const token = tokens[idx]
          const info = token.info ? md.utils.unescapeAll(token.info).trim() : ''
          const lang = info ? info.split(/\s+/g)[0] : 'txt'
          return `<div class="language-${lang}"><pre class="vp-code" v-pre><code>${md.utils.escapeHtml(token.content)}</code></pre></div>`
        }
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
        copyright: 'Copyright by the openHAB Community and the openHAB Foundation e.V.'
      }),
    ],
  },
  themeConfig: {
    logo: {
      light: '/openhab-logo-empowering.svg',
      dark: '/openhab-logo-empowering-dark.svg',
    },
    siteTitle: false,
    socialLinks: [
      { icon: 'github', link: 'https://github.com/openhab' },
      { icon: 'x', link: 'https://x.com/openhab' },
      { icon: 'youtube', link: 'https://www.youtube.com/channel/UC7OK88DW0La_BJlcXZg8ydQ' },
    ],
    outline: {
      level: [2, 3],
      label: 'On this page',
    },
    search: {
      provider: 'local',
      options: {
        detailedView: true,
      },
    },
    nav: [
      { text: 'Download', link: '/download/' },
      { text: 'Documentation', link: '/docs/', activeMatch: '^/docs/' },
      { text: 'Add-ons', link: '/addons/', activeMatch: '^/addons/' },
      { text: 'Community', link: '/community/' },
      { text: 'Blog', link: '/blog/', activeMatch: '^/blog/' },
      {
        text: 'About',
        activeMatch: '^/about/|^/privacy|^/imprint|^/artwork',
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
      '/addons/': [
        { text: 'Bindings', collapsed: false, items: addonsBindings },
        { text: 'System Integrations', collapsed: true, items: addonsIntegrations },
        { text: 'Automation', collapsed: true, items: addonsAutomation },
        { text: 'Data Persistence', collapsed: true, items: addonsPersistence },
        { text: 'Data Transformation', collapsed: true, items: addonsTransformations },
        { text: 'Voice', collapsed: true, items: addonsVoice },
        { text: 'User Interface', collapsed: true, items: addonsUi },
      ],
    },
  },
})
