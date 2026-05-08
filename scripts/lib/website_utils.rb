# frozen_string_literal: true

require "English"
require "csv"
require "fileutils"

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

#
# Re-generate a VuePress-compatible version of an iconset's documentation
#
# - Load the list of icons from the original iconset
# - Load the categories from the CSV files
# - Generate a markdown file with the list of icons and their categories
# - Copy the icons to the public folder (.vuepress/public/iconsets/<iconset>)
#
# @param iconset [String] the name of the iconset (e.g. "classic")
# @param src [Pathname, String] the path to the original iconsets (e.g. ".vuepress/openhab-docs/_addons_iconsets")
# @param dst [Pathname, String] the path to the output directory (e.g. "docs/configuration/iconsets")
# @param data [Pathname, String] the path to the CSV data files (e.g. ".vuepress/openhab-docs/_data")
#
def process_iconset(iconset:, src:, dst:, data:)
  src = Pathname(src)
  data = Pathname(data)
  dst = Pathname(dst)

  icons_path = src / iconset / "src/main/resources/icons"
  icons_list = icons_path.glob("*.svg").map { |path| path.basename.to_s }

  categories_channels = {}
  CSV.foreach(data / "categories.csv", headers: true) do |row|
    # Using a standard loop over compact Ruby shorthands for better clarity
    type = row["type"]
    name = row["name"]

    categories_channels[type] ||= []
    categories_channels[type] << name
  end
  categories_places = CSV.foreach(data / "categories_places.csv", headers: true).map { |row| row["name"] }
  categories_thing = CSV.foreach(data / "categories_thing.csv", headers: true).map { |row| row["name"] }

  iconset_readme = dst / iconset / "readme.md"
  iconset_readme.dirname.mkpath
  iconset_readme.open("w+") do |f|
    f.puts "---"
    f.puts "title: Icons"
    f.puts "categories:"

    f.puts "  channels:"
    categories_channels.each do |type, channels|
      f.puts "    #{type}:"
      channels.each { |channel| f.puts "      - #{channel.downcase}" }
    end

    f.puts "  places:"
    categories_places.each { |place| f.puts "    - #{place.downcase}" }

    f.puts "  things:"
    categories_thing.each { |thing| f.puts "    - #{thing.downcase}" }

    f.puts "---"
    f.puts # Blank line
    f.puts "# Icons"
    f.puts
    f.puts "These are the classic icons from Eclipse SmartHome."
    f.puts
    f.puts "These icons can be used when describing Items. You can also add your own. See the [instructions](/docs/configuration/items.html#icons) to learn more."
    f.puts
    f.puts "<IconsetDisplay icons=\"#{icons_list.join(",")}\"/>"
  end

  puts "   ➡️ File written in #{iconset_readme}"

  # FileUtils.mkdir_p(".vuepress/public/iconsets")
  FileUtils.cp_r(icons_path, ".vuepress/public/iconsets/#{iconset}")

  puts "   ➡️ Icons copied to .vuepress/public/iconsets/#{iconset}"
end
