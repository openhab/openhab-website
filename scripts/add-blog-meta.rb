# frozen_string_literal: true

# Adds the OpenGraph & Twitter meta tags to the blog articles
require "date"
require "fileutils"
require "json"
require "pathname"
require "tmpdir"
require "yaml"

REPO_ROOT = Pathname(__dir__).parent.realpath

DEFAULT_DESCRIPTION = "a vendor and technology agnostic open source automation software for your home"
SITE = "https://www.openhab.org"

def clean_description(text)
  text.to_s
      .gsub(/\[([^\]]*)\]\([^)]*\)/, '\1') # markdown links -> link text
      .gsub("&colon;", ":")
      .gsub(/\s+/, " ")
      .strip
end

def absolute_url(path)
  path.start_with?("/") ? "#{SITE}#{path}" : path
end

def process_file(src, dst)
  content = File.read(src)
  match = content.match(/\A(---\r?\n)(.*?)(^---\r?\n)/m)
  return File.write(dst, content) unless match

  frontmatter = YAML.safe_load(match[2], permitted_classes: [Date, Time]) || {}
  # Leave posts that already have head: or meta: untouched
  return File.write(dst, content) if frontmatter.key?("head") || frontmatter.key?("meta")

  og_title = frontmatter["title"].to_s.strip
  og_title = "openHAB" if og_title.empty?
  og_description = clean_description(frontmatter["excerpt"])
  og_description = DEFAULT_DESCRIPTION if og_description.empty?
  og_image = frontmatter["previewimage"]&.to_s
  author = frontmatter["author"]&.to_s

  # JSON strings are valid YAML double-quoted scalars, so this is always safe
  meta = +"head:\n"
  meta << "  - - meta\n    - name: twitter:card\n      content: summary_large_image\n"
  meta << "  - - meta\n    - property: og:title\n      content: #{og_title.to_json}\n"
  meta << "  - - meta\n    - property: og:description\n      content: #{og_description.to_json}\n"
  meta << "  - - meta\n    - property: og:image\n      content: #{absolute_url(og_image).to_json}\n" if og_image

  if author || og_image
    meta << "feed:\n"
    meta << "  image: #{absolute_url(og_image).to_json}\n" if og_image
    meta << "  author:\n    - name: #{author.to_json}\n" if author
  end

  File.write(dst, content.sub(match[0]) { "#{match[1]}#{match[2]}#{meta}#{match[3]}" })
end

puts "➡️ Adding metadata to blog posts"

Dir.mktmpdir do |tmp_dir|
  tmp_workspace = Pathname(tmp_dir)

  Pathname.glob(REPO_ROOT / "blog/*.md").each do |src|
    next if src.basename.fnmatch?("index.md")

    dst = tmp_workspace / src.basename
    puts "   ➡️ #{src.basename}"
    process_file(src, dst)
    FileUtils.mv(dst, src) if dst.exist? && !FileUtils.identical?(src, dst)
  end
end
