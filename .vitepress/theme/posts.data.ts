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
  excerpt: true,
  transform(raw): Post[] {
    return raw
      .filter(({ url }) => url !== '/blog/' && url !== '/blog/index.html')
      .map(({ url, frontmatter, excerpt }) => ({
        title: frontmatter.title,
        url,
        date: frontmatter.date,
        author: frontmatter.author,
        previewimage: frontmatter.previewimage,
        excerpt: excerpt || frontmatter.excerpt,
      }))
      .sort((a, b) => new Date(b.date).getTime() - new Date(a.date).getTime())
  },
})
