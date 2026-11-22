import { createContentLoader } from 'vitepress'

export interface Post {
  title: string
  url: string
  date: string
  author: string
  previewimage?: string
  excerpt?: string
}

declare const data: Post[]
export { data }

export default createContentLoader('blog/*.md', {
  excerpt(file) {
    if (!file.content) return
    const moreMatch = file.content.match(/<!--\s*more\s*-->/i)
    if (moreMatch && moreMatch.index !== undefined) {
      file.excerpt = file.content.slice(0, moreMatch.index).trim()
    } else if (file.data.excerpt) {
      file.excerpt = file.data.excerpt
    } else if (file.data.description) {
      file.excerpt = file.data.description
    } else {
      const paragraphs = file.content.trim().split(/\n\s*\n/)
      const intro = paragraphs.find(
        (p) => p.trim() && !p.trim().startsWith('#') && !p.trim().startsWith('<') && !p.trim().startsWith('![')
      )
      file.excerpt = intro ? intro.trim() : paragraphs[0]?.trim() || ''
    }
  },
  transform(raw): Post[] {
    return raw
      .filter(({ url }) => url !== '/blog/' && url !== '/blog/index.html')
      .map(({ url, frontmatter, excerpt }) => ({
        title: frontmatter.title,
        url,
        date: frontmatter.date,
        author: frontmatter.author,
        previewimage: frontmatter.previewimage,
        excerpt: excerpt || frontmatter.excerpt || frontmatter.description,
      }))
      .sort((a, b) => new Date(b.date).getTime() - new Date(a.date).getTime())
  },
})
