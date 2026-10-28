import path from 'path'
import fs from 'fs'

import type { Plugin } from 'vite'

/**
 * Vite plugin to prevent build or dev-server crash when an image is missing.
 */
function fallbackMissingImagesPlugin(): Plugin {
  const IMAGE_EXTENSIONS = /\.(png|jpe?g|gif|svg|webp|avif|ico|bmp|tiff?)$/i
  return {
    name: 'vite-plugin-fallback-missing-images',
    enforce: 'pre',
    resolveId(source: string, importer: string | undefined) {
      if (importer && source.startsWith('.') && IMAGE_EXTENSIONS.test(source)) {
        const cleanPath = source.split(/[?#]/)[0]
        // Strip any Vite query params from importer if present
        const importerFile = importer.split('?')[0]
        const resolved = path.resolve(path.dirname(importerFile), cleanPath)
        if (!fs.existsSync(resolved)) {
          this.warn({
            message: `Missing image asset: "${source}" could not be resolved at "${resolved}".`,
            id: importerFile,
          })
          return `\0virtual:missing-image:${encodeURIComponent(source)}`
        }
      }
      return null
    },
    load(id: string) {
      if (id.startsWith('\0virtual:missing-image:')) {
        const rawSource = decodeURIComponent(id.slice('\0virtual:missing-image:'.length))
        return `export default ${JSON.stringify(rawSource)};`
      }
      return null
    },
  }
}

export default fallbackMissingImagesPlugin
