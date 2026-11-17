import { createContentLoader } from 'vitepress'

export interface PreviousVersion {
  version: string
  website: string
}

export interface VersionsData {
  currentVersion: string
  currentSnapshotVersion: string
  previousVersions: PreviousVersion[]
}

declare const data: VersionsData
export { data }

export default createContentLoader('download/index.md', {
  transform(raw): VersionsData {
    const fm = raw[0]?.frontmatter || {}
    return {
      currentVersion: fm.currentVersion || '',
      currentSnapshotVersion: (fm.currentSnapshotVersion || '').replace('-SNAPSHOT', ''),
      previousVersions: fm.previousVersions || [],
    }
  },
})
