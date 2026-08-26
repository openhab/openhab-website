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
  excerpt: true,
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
        abstract: frontmatter.abstract,
        excerpt: excerpt || frontmatter.abstract,
      }))
      .sort((a, b) => new Date(a.date).getTime() - new Date(b.date).getTime())
  },
})
