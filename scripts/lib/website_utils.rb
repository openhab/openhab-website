# frozen_string_literal: true

require "English"
require "fileutils"
require "json"
require "yaml"

def verbose(message)
  puts message if $verbose
end

def checkout_pull_request(pull_request, target_directory)
  pull_request_url = "https://api.github.com/repos/openhab/openhab-docs/pulls/#{pull_request}"

  response = JSON.parse(URI.parse(pull_request_url).read)
  repository_url = response["head"]["repo"]["clone_url"]
  label = response["head"]["label"]
  sha = response["head"]["sha"]
  branch = response["head"]["ref"]
  title = response["title"]

  puts "➡️ Cloning repository 📦 #{label} ..."
  puts "   ↪️ PR ##{pull_request}: #{title}"

  system("OH_DOCS_VERSION=#{branch}")

  FileUtils.cd(target_directory, verbose: false) do
    system("git clone --depth 1 #{repository_url} --branch #{branch} #{$verbose ? "" : "--quiet"} .")
    system("git reset ##{sha} #{$verbose ? "" : "--quiet"}")
  end
end

def clean_ignored_files(path, dry_run: false)
  return true unless Dir.exist?(path)

  # -f: Force (delete)
  # -n: Dry-run (show what would happen)
  # -d: Remove directories
  # -X: Remove ONLY ignored files
  # -q: Quiet (suppress output)

  mode = dry_run ? "-ndX" : "-fdXq"

  Dir.chdir(path) do
    puts "🧹 Cleaning ignored files in #{path} #{dry_run ? "(dry run)" : ""}..."
    output = `git clean #{mode}`
    puts output if dry_run
    $CHILD_STATUS.success?
  end
rescue Errno::ENOENT, Errno::EACCES => e
  puts "Error accessing #{path}: #{e.message}"
  false
end

def extract_addon_metadata(addon_path, type)
  readme = addon_path / "readme.md"
  return nil unless readme.exist?

  front_matter = extract_front_matter(readme)

  title = front_matter[:label] if front_matter.is_a?(Hash)
  return nil unless title && !title.include?("1.x")

  path = "#{type}/#{addon_path.basename}/"
  children = front_matter[:children]

  [path, title, children]
end

def extract_front_matter(pathname)
  content = pathname.read

  match = content.match(/\A---(?<yaml>.*?)^---/m)
  return nil unless match

  begin
    YAML.safe_load(match[:yaml], symbolize_names: true)
  rescue Psych::SyntaxError => e
    puts "⚠️  YAML syntax error in front-matter of #{pathname} - skipping front-matter extraction: #{e.message}"
    nil
  end
rescue Errno::ENOENT
  nil
end

def create_addon_entry(path, title, children)
  if children && !children.empty?
    {
      path: "/addons/#{path}",
      title:,
      children: [[path, "Overview"]] + normalize_child_path(path, children)
    }
  else
    [path, title]
  end
end

def path_exists?(path)
  ADDONS_DST.join("#{path}.md").exist?
end

def normalize_path(prefix, path)
  (path.start_with?("/") || path.start_with?(prefix)) ? path : "#{prefix}#{path}"
end

#
# Loop through the children and normalize their paths, ensuring they exist in the destination.
#
# The children define their path relative to itself, e.g. "doc/filename".
# We need to prepend the prefix to this path so vuepress can find it.
# The children can be a mix of strings, arrays, and hashes, so we need to handle each case accordingly.
#
# Case 1:
#   children:
#     - "doc/filename"
#
# Case 2:
#   children:
#     - ["doc/filename", "Title"]
#
# Case 3 (mixed - nested children is possible but untested!):
#   children:
#     - "doc/filename"
#     - ["doc/filename", "Title"]
#     - path: "doc/filename"
#       title: "Title"
#
def normalize_child_path(prefix, item)
  case item
  when Array
    # If it is a flat [path, title] pair, treat it as a single node
    if item.size == 2 && item.all? { |el| el.is_a?(String) }
      process_single_node(prefix, item[0], item[1])
    else
      # Otherwise, it is a list of children to recursively map and clean
      item.map { |child| normalize_child_path(prefix, child) }.compact
    end
  when String
    process_single_node(prefix, item)
  when Hash
    process_hash_node(prefix, item)
  else
    item
  end
end

def process_single_node(prefix, path, title = nil)
  normalized_path = normalize_path(prefix, path)

  if path_exists?(normalized_path)
    title ? [normalized_path, title] : normalized_path
  else
    puts "⚠️  Skipping #{normalized_path} as the file does not exist"
    nil
  end
end

def process_hash_node(prefix, node)
  updated = node.dup

  if updated[:path]
    normalized_path = normalize_path(prefix, updated[:path])
    return nil unless path_exists?(normalized_path)

    updated[:path] = normalized_path
  end

  updated[:children] = normalize_child_path(prefix, updated[:children]).compact if updated[:children]

  updated
end
