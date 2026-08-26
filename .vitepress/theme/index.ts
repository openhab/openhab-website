import { h } from 'vue'
import type { Theme } from 'vitepress'
import DefaultTheme from 'vitepress/theme'
import { enhanceAppWithTabs } from 'vitepress-plugin-tabs/client'
import './style.css'
import './openhab.css'

export default {
  extends: DefaultTheme,
  Layout: () => {
    return h(DefaultTheme.Layout, null, {
      // Slot customization can be hooked here as layouts and components are added
    })
  },
  enhanceApp({ app }) {
    enhanceAppWithTabs(app)
  },
} satisfies Theme
