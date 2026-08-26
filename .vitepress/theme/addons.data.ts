import { createContentLoader } from 'vitepress'

export interface Addon {
  url: string
  id?: string
  label?: string
  title?: string
  type?: string
  description?: string
  logo?: string
  since?: string
}

declare const data: Addon[]
export { data }

export default createContentLoader('addons/**/*.md', {
  transform(raw): Addon[] {
    return raw
      .filter(({ url }) => url !== '/addons/' && url !== '/addons/readme.html' && url !== '/addons/index.html')
      .map(({ url, frontmatter }) => ({
        url,
        id: frontmatter.id,
        label: frontmatter.label || frontmatter.title,
        title: frontmatter.title || frontmatter.label,
        type: frontmatter.type,
        description: frontmatter.description,
        logo: frontmatter.logo,
        since: frontmatter.since,
      }))
  },
})
