import path from 'path'
import { writeFileSync } from 'fs'
import { type SiteConfig, createContentLoader } from 'vitepress'
import { Feed } from 'feed'

function resolveDescription(post: any): string {
  if (post.frontmatter.description) {
    return post.frontmatter.description
  }

  // Look for og:description inside meta frontmatter
  const ogDesc = post.frontmatter.meta?.find(
    (m: any) => m.property === 'og:description' || m.name === 'description'
  )?.content

  if (ogDesc) return ogDesc

  // Fallback: extract the first paragraph from raw markdown
  const firstParagraph = post.src
    ?.replace(/^---[\s\S]*?---/, '') // strip frontmatter
    .trim()
    .split(/\n\s*\n/)[0]
    ?.replace(/\[(.*?)\]\(.*?\)/g, '$1') // strip markdown links
    ?.replace(/[*_#`]/g, '') // strip formatting
    ?.trim()

  return firstParagraph || ''
}

function resolveImage(post: any, baseUrl: string): string | undefined {
  const img =
    post.frontmatter.feed?.image ||
    post.frontmatter.previewimage ||
    post.frontmatter.meta?.find((m: any) => m.property === 'og:image')?.content

  if (!img) return undefined
  return img.startsWith('http') ? img : `${baseUrl}${img}`
}

export async function genFeed(config: SiteConfig): Promise<void> {
  const baseUrl = 'https://www.openhab.org'

  const feed = new Feed({
    title: 'openHAB',
    description: 'openHAB News and Announcements',
    id: baseUrl,
    link: baseUrl,
    language: 'en',
    copyright: 'Copyright by the openHAB Community and the openHAB Foundation e.V.',
    feedLinks: {
      rss2: `${baseUrl}/rss.xml`,
      atom: `${baseUrl}/feed.atom`,
      json: `${baseUrl}/feed.json`
    }
  })

  const posts = await createContentLoader('blog/**/*.md', {
    includeSrc: true,
    render: false
  }).load()

  const filteredPosts = posts
    .filter((post) => {
      return (
        post.url.startsWith('/blog/') &&
        post.url !== '/blog/' &&
        post.url !== '/blog/index.html'
      )
    })
    .sort((a, b) => +new Date(b.frontmatter.date) - +new Date(a.frontmatter.date))

  for (const post of filteredPosts) {
    const postUrl = `${baseUrl}${post.url.replace(/\.md$/, '.html')}`
    const imageUrl = resolveImage(post, baseUrl)

    feed.addItem({
      title: post.frontmatter.title,
      id: postUrl,
      link: postUrl,
      guid: postUrl,
      date: new Date(post.frontmatter.date),
      description: resolveDescription(post),
      ...(imageUrl ? { image: imageUrl } : {})
    })
  }

  // Write all three feed formats to the VitePress output directory
  writeFileSync(path.join(config.outDir, 'rss.xml'), feed.rss2())
  writeFileSync(path.join(config.outDir, 'feed.atom'), feed.atom1())
  writeFileSync(path.join(config.outDir, 'feed.json'), feed.json1())
}
