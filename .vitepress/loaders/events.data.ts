import { createContentLoader } from 'vitepress'

export interface EventItem {
  url: string
  title: string
  date: string
  end_date?: string
  location?: string
  link?: string
  layout?: string
  event_image?: string
  abstract?: string
  excerpt?: string
}

declare const data: EventItem[]
export { data }

export default createContentLoader('about/events/*.md', {
  excerpt(file) {
    if (file.data.abstract?.trim()) {
      file.excerpt = file.data.abstract.trim()
    } else if (file.content) {
      const moreMatch = file.content.match(/<!--\s*more\s*-->/i)
      if (moreMatch && moreMatch.index !== undefined) {
        file.excerpt = file.content.slice(0, moreMatch.index).trim()
      } else {
        file.excerpt = file.content.trim()
      }
    }
  },
  transform(raw): EventItem[] {
    return raw
      .map(({ url, frontmatter, excerpt }) => ({
        url,
        title: frontmatter.title,
        date: frontmatter.date,
        end_date: frontmatter.end_date,
        location: frontmatter.location,
        link: frontmatter.link,
        layout: frontmatter.layout,
        event_image: frontmatter.event_image,
        abstract: frontmatter.abstract ?? excerpt,
        excerpt,
      }))
      .sort((a, b) => new Date(a.date).getTime() - new Date(b.date).getTime())
  },
})
