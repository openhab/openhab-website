# frozen_string_literal: true

# This will clone https://github.com/openhab/openhab-docs and migrate content into the website

require "optparse"
require "fileutils"
require "pathname"
require "uri"
require "open-uri"
require "json"

require_relative "lib/website_utils"

DOCS_REPO_URL = "https://github.com/openhab/openhab-docs"
DOCS_REPO_BRANCH = ENV.fetch("OH_DOCS_VERSION", "final").then { |v| (v.count(".") == 1) ? "#{v}.0" : v }

DOCS_SRC = Pathname(".vuepress/openhab-docs")
DOCS_DST = Pathname("docs")
ADDONS_DST = Pathname("addons")
LOGOS_DST = Pathname(".vuepress/public/logos")

$verbose = false

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: prepare-website.rb [options]"
  opts.on("--no-clone", "Don't clone the openhab-docs repository, but use an existing clone if available") do
    options[:no_clone] = true
    verbose "➡️ no-clone: existing clone will be used"
  end

  opts.on("--pull-request PR_NUMBER", "Use a specific pull request from the openhab-docs repository instead of cloning a branch") do |pr_number|
    options[:pull_request] = pr_number
    verbose "➡️ PR ##{pr_number} will be used to build documentation"
  end

  opts.on("--verbose", "Run the script with verbose output") do
    $verbose = true
  end
end.parse!

puts "➡️ Generating docs from openhab-docs branch '#{DOCS_REPO_BRANCH}'"

if options[:no_clone] && DOCS_SRC.exist?
  puts "➡️ Re-using existing clone"
else
  puts "🧹 Cleaning #{DOCS_SRC} ..."
  DOCS_SRC.rmtree if DOCS_SRC.exist?
end

if options[:pull_request]
  DOCS_SRC.mkpath
  checkout_pull_request(options[:pull_request], DOCS_SRC)
elsif !DOCS_SRC.exist?
  puts "➡️ Cloning repository #{DOCS_REPO_URL}/#{DOCS_REPO_BRANCH} into #{DOCS_SRC} 📦 ..."
  `git clone --depth 1 --branch #{DOCS_REPO_BRANCH} #{DOCS_REPO_URL} #{DOCS_SRC}`
end

raise "Cannot find openhab-docs repository directory. Please check if cloning/checkout was successful." unless DOCS_SRC.exist?

if options[:pull_request]
  puts "➡️ Processing docs and addons for the pull request..."
  Dir.chdir(DOCS_SRC) do
    # Run the prepare-docs.rb to generate processed docs
    system("ruby scripts/prepare-docs.rb")
  end
end

raise "Cannot find openhab-docs docs folder. Please check if the processing scripts ran successfully." unless (DOCS_SRC / "docs").exist?

clean_ignored_files(DOCS_DST)
clean_ignored_files(ADDONS_DST)

puts "➡️ Migrating logos"
LOGOS_DST.rmtree if LOGOS_DST.exist?
if Dir.exist?(DOCS_SRC / "images/addons")
  FileUtils.cp_r(DOCS_SRC / "images/addons", LOGOS_DST)
end

puts "➡️ Copying pre-processed docs from openhab-docs"
FileUtils.cp_r(DOCS_SRC / "docs/.", DOCS_DST)

unless options[:pull_request]
  ADDONS_DST.mkpath
  # Map pre-processed addon folders to their correct destination names
  FileUtils.cp_r(DOCS_SRC / "addons/automation/.", ADDONS_DST / "automation")
  FileUtils.cp_r(DOCS_SRC / "addons/bindings/.", ADDONS_DST / "bindings")
  FileUtils.cp_r(DOCS_SRC / "addons/integrations/.", ADDONS_DST / "integrations")
  FileUtils.cp_r(DOCS_SRC / "addons/persistence/.", ADDONS_DST / "persistence")
  FileUtils.cp_r(DOCS_SRC / "addons/transformations/.", ADDONS_DST / "transformations")
  FileUtils.cp_r(DOCS_SRC / "addons/ui/.", ADDONS_DST / "ui")
  FileUtils.rm_rf(ADDONS_DST / "ui/org.openhab.ui")
  FileUtils.cp_r(DOCS_SRC / "addons/voice/.", ADDONS_DST / "voice")
end

# Write arrays of addons by type to include in VuePress config.js
puts "➡️ Writing add-ons arrays to files for sidebar navigation"
%w[bindings persistence automation integrations transformations voice ui].each do |type|
  type_dir = ADDONS_DST / type

  module_exports = []
  if type_dir.directory?
    # Find all subdirectories excluding hidden ones
    module_exports = type_dir.children.select(&:directory?).filter_map do |addon_path|
      readme = addon_path / "readme.md"
      next unless readme.exist?

      # Find the first line starting with "label: "
      label_line = readme.each_line.find { |line| line.start_with?("label: ") }
      next unless label_line

      title = label_line.delete_prefix("label: ").strip
      next if title.include?("1.x")

      path = "#{type}/#{addon_path.basename}/"

      # Return the pair for the module_exports array
      [path, title]
    end
  end

  formatted_exports = module_exports.map { |path, title| "  [ '#{path}', '#{title}' ]" }.join(",\n")

  dest_file = ".vuepress/addons-#{type}.js"
  puts "   ↪️ Writing #{dest_file} (#{module_exports.size} items)"
  File.write(dest_file, <<~JS)
    module.exports = [
    #{formatted_exports}
    ]
  JS
end

# Clean-Ups required for repeated local build
verbose "🧹 Cleaning existing JavaDoc ..."
FileUtils.rm Dir.glob("javadoc-latest.*"), force: true
FileUtils.rm_rf(".vuepress/public/javadoc/latest")

# Publish latest Javadoc
puts "➡️ Downloading and extracting latest Javadoc from Jenkins"
begin
  `wget -nv https://ci.openhab.org/job/openHAB-JavaDoc/lastSuccessfulBuild/artifact/target/javadoc-latest.tgz`
  if File.exist?("javadoc-latest.tgz")
    `tar xzvf javadoc-latest.tgz --strip 2 && mv apidocs/ .vuepress/public/javadoc/latest`
    FileUtils.rm "javadoc-latest.tgz"
    puts "✅ Downloaded and extracted Javadoc"
  else
    puts "⚠️ Could not download Javadoc - skipping"
  end
rescue => e
  puts "⚠️ Javadoc download failed: #{e.message} - skipping"
end

# Copy the thing-types.json file to the proper location
thing_types_src = DOCS_SRC / ".vuepress/thing-types.json"
if thing_types_src.exist?
  FileUtils.cp(thing_types_src, ".vuepress")
  puts "✅ Copied Thing Types"
else
  puts "⏩ Thing Types not found - skipping"
end

puts "✅ Website prepared"
