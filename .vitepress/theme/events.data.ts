import { createContentLoader } from 'vitepress'

export interface EventItem {
  url: string
  title: string
  date: string
  end_date?: string
  location?: string
  link?: string
  layout?: string
}

declare const data: EventItem[]
export { data }

export default createContentLoader('about/events/*.md', {
  transform(raw): EventItem[] {
    return raw
      .map(({ url, frontmatter }) => ({
        url,
        title: frontmatter.title,
        date: frontmatter.date,
        end_date: frontmatter.end_date,
        location: frontmatter.location,
        link: frontmatter.link,
        layout: frontmatter.layout,
      }))
      .sort((a, b) => new Date(a.date).getTime() - new Date(b.date).getTime())
  },
})
