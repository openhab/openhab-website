# frozen_string_literal: true

# Adds the OpenGraph & Twitter meta tags to the blog articles
require "fileutils"
require "pathname"
require "tmpdir"

REPO_ROOT = Pathname(__dir__).parent.realpath

def process_file(src, dst)
  in_frontmatter = false
  parsing_multiline_excerpt = false
  og_title = "openHAB"
  og_description = "a vendor and technology agnostic open source automation software for your home"
  og_image = nil

  # Feed Meta
  fm_author = nil
  meta_present = false

  File.open(dst, "w+") do |out|
    File.open(src).each do |line|
      # FIXME: require "yaml" and parse properly one day...
      if parsing_multiline_excerpt
        if line =~ /^  /
          og_description += " "
          og_description += line.gsub(/^  /, "").gsub("\n", "")
          next
        else
          og_description.strip!
          parsing_multiline_excerpt = false
        end
      end

      og_title = line.gsub("title: ", "").gsub("\n", "") if in_frontmatter && line =~ /^title:/

      # detect if meta: block already exists in frontmatter to avoid duplicate insertion
      meta_present = true if in_frontmatter && line =~ /^\s*meta:/

      if in_frontmatter && line =~ /^excerpt:/
        og_description = line.gsub("excerpt: ", "").gsub("\n", "").gsub("[", "").gsub("]", "").gsub(%r{\(http[:/\-0-9A-Za-z\.]+\)}, "")
        if og_description == ">-"
          og_description = ""
          parsing_multiline_excerpt = true
          next
        end
      end

      og_image = line.gsub("previewimage: ", "").gsub("\n", "") if in_frontmatter && line =~ /^previewimage:/

      fm_author = line.gsub("author: ", "").gsub("\n", "") if in_frontmatter && line =~ /^author:/

      if line =~ /^---$/
        if in_frontmatter
          # Add OpenGraph tags
          unless meta_present
            out.puts "meta:"
            out.puts "  - name: twitter:card"
            out.puts "    content: summary_large_image"
            out.puts "  - property: og:title"
            out.puts "    content: \"#{og_title.gsub('"', '\\"')}\""
            out.puts "  - property: og:description"
            out.puts "    content: #{og_description}"
            out.puts "  - property: og:image" if og_image
            out.puts "    content: https://www.openhab.org#{og_image}" if og_image

            # Add feed meta tags, when something relevant is available
            if !fm_author.nil? || !og_image.nil?
              out.puts "feed:"
              out.puts "  image: https://www.openhab.org#{og_image}" if og_image
              out.puts "  author:"
              out.puts "    - name: #{fm_author}"
            end
          end

          in_frontmatter = false
        else
          in_frontmatter = true
          meta_present = false
        end
      end

      out.puts line
    end
  end
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
