# frozen_string_literal: true

# This will clone https://github.com/openhab/openhab-docs
# and migrate content into the website with some changes

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

# Temporary fallback source for development, until the PR is merged
DEV_SRC = Pathname("../../openhab-docs.worktrees/refactor-prepare-docs")

$verbose = false

IGNORED_ADDONS = %w[transport.modbus transport.feed javasound webaudio oh2].freeze # No longer relevant?

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: prepare-docs.rb [options]"
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
  puts "➡️ Cleaning #{DOCS_SRC}..."
  DOCS_SRC.rmtree if DOCS_SRC.exist?
end

if options[:pull_request]
  checkout_pull_request(options[:pull_request], DOCS_SRC)
elsif !DOCS_SRC.exist?
  puts "➡️ Cloning repository #{DOCS_REPO_URL}/#{DOCS_REPO_BRANCH} into #{DOCS_SRC} 📦 ..."
  `git clone --depth 1 --branch #{DOCS_REPO_BRANCH} #{DOCS_REPO_URL} #{DOCS_SRC}`

  if DOCS_SRC.join("src").exist? # Check if the clone was successful by checking for the existence of the "src" folder
    puts "➡️ Clone successful"
  else
    # Temporarily fetch the src from local dev branch until the PR is merged, as the src folder is required to build the docs
    # This is a fallback before the openhab/openhab-docs#2718 PR is merged
    puts "➡️ Copying temp source files during development"

    `git clone --depth 1 --branch refactor-prepare-docs "https://github.com/jimtng/openhab-docs.git" /tmp/openhab-docs-dev`
    FileUtils.cp_r("/tmp/openhab-docs-dev/src", DOCS_SRC / "src")
    FileUtils.rm_rf("/tmp/openhab-docs-dev") # Clean up the temporary clone

    # the openhabian docs were fetched by github action into the final branch
    # our temporary src is from the main branch, so we need to copy the openhabian docs into
    # the temporary src to be able to build the docs properly
    # this is a temporary solution until the PR is merged, as the installation docs are required to build the docs
    `rsync -a #{DOCS_SRC}/installation/ #{DOCS_SRC}/src/installation/`

    if DOCS_REPO_BRANCH == "final-stable"
      # We need to do this because the final-stable branch used in the CI lags behind the contents
      # of the dev branch containing the src folder that we copied above
      sidebar_js = DOCS_SRC.join(".vuepress/docs-sidebar.js")
      sidebar_js.write(URI.open("https://raw.githubusercontent.com/jimtng/openhab-docs/refactor-prepare-docs/.vuepress/docs-sidebar.js").read) # Remove /src/ from the sidebar links, as our temporary src is not in the root of the repository
    end
  end
end

raise "Failed to prepare openhab-docs source. Please check if the repository was cloned successfully." unless DOCS_SRC.join("src").exist?

# Fetch process_utils from the openhab-docs repository if we haven't already - we need it to process the documentation files
process_utils = DOCS_SRC / "scripts/lib/process_utils.rb"
unless process_utils.exist?
  process_utils.parent.mkpath
  begin
    process_utils.write(URI.open("https://raw.githubusercontent.com/openhab/openhab-docs/main/scripts/lib/process_utils.rb").read)
  rescue OpenURI::HTTPError => e
    raise unless e.io.status[0] == "404"

    # Temporarily fetch this from my local dev branch until the PR is merged, as process_utils is required to build the docs
    process_utils.write(URI.open("https://raw.githubusercontent.com/jimtng/openhab-docs/refactor-prepare-docs/scripts/lib/process_utils.rb").read)

    # dev_process_utils = DEV_SRC / "scripts/lib/process_utils.rb"
    # FileUtils.cp(dev_process_utils, process_utils)
  end
end

# After we've cloned the openhab-docs, we can require process_utils to use its helper functions
require DOCS_SRC.expand_path / "scripts/lib/process_utils"

clean_ignored_files(DOCS_DST)
clean_ignored_files(ADDONS_DST)

puts "➡️ Migrating logos"
LOGOS_DST.rmtree if LOGOS_DST.exist?
FileUtils.cp_r(DOCS_SRC / "images/addons", LOGOS_DST)

puts "➡️ Migrating the main documentation sections"
process_directory src: DOCS_SRC / "src",
                  dst: DOCS_DST,
                  source_root: "https://github.com/openhab/openhab-docs/blob/main/src"

puts "➡️ Migrating the UI section"
verbose "   ➡️ components"
process_directory src: DOCS_SRC.join("_addons_uis/org.openhab.ui/doc/components"), # use join to avoid syntax highlighting bug in vscode
                  dst: DOCS_DST / "ui/components",
                  source_root: "https://github.com/openhab/openhab-webui/blob/main/bundles/org.openhab.ui/doc/components"

verbose "   ➡️ habpanel"
# habpanel.md provides its own source: frontmatter
process_directory src: DOCS_SRC / "_addons_uis/habpanel/doc",
                  dst: DOCS_DST / "ui/habpanel"

verbose "   ➡️ habot"
# habot repo is archived, so we don't set a source root link
process_directory src: DOCS_SRC / "_addons_uis/habot",
                  dst: DOCS_DST / "ui/habot"

puts "➡️ Migrating the apps section"
# The external apps docs provide their own `source:` frontmatter
# No need to process individual app.
# This will process everything in the source folder
process_directory src: DOCS_SRC / "addons/uis/apps",
                  dst: DOCS_DST / "apps"

### ADDONS

# External content is not included for PRs - therefore the _addons_*** folders are not present for PR checks - this section will be skipped.
if options[:pull_request]
  puts ""
  puts "⚠️  Add-on documentation depends on Jenkins job - will be skipped ..."
  puts ""
else
  puts "➡️ Migrating add-ons: Automation"
  process_directory src: DOCS_SRC / "_addons_automation",
                    dst: ADDONS_DST / "automation"

  puts "➡️ Migrating add-ons: Persistence"
  process_directory src: DOCS_SRC / "_addons_persistences",
                    dst: ADDONS_DST / "persistence"

  puts "➡️ Migrating add-ons: Transformations"
  process_directory src: DOCS_SRC / "_addons_transformations",
                    dst: ADDONS_DST / "transformations"

  puts "➡️ Migrating add-ons: Voice"
  process_directory src: DOCS_SRC / "_addons_voices",
                    dst: ADDONS_DST / "voice"

  puts "➡️ Migrating add-ons: IO"
  process_directory src: DOCS_SRC / "_addons_ios",
                    dst: ADDONS_DST / "integrations"

  puts "➡️ Migrating add-ons: UI"
  process_directory src: DOCS_SRC / "_addons_uis",
                    dst: ADDONS_DST / "ui" do |current_path|
                      next if current_path.each_filename.include?("org.openhab.ui")

                      true
                    end

  # Handle those three separately - copy them in the "ecosystem" section
  puts "➡️ Migrating special ecosystem integrations"
  verbose "   ➡️ Process alexa-skill docs"
  process_directory src: DOCS_SRC / "_ecosystem/alexa-skill",
                    dst: DOCS_DST / "ecosystem/alexa"

  verbose "   ➡️ Process google-assistant docs"
  process_directory src: DOCS_SRC / "_ecosystem/google-assistant",
                    dst: DOCS_DST / "ecosystem/google-assistant"

  puts "➡️ Migrating add-ons: Bindings"
  bindings_src = DOCS_SRC / "_addons_bindings"
  zwave_src = bindings_src / "zwave"
  zwave_docs = [zwave_src / "readme.md", zwave_src / "doc/things.md"] # Only include the readme and the things doc for zwave, as the rest is quite outdated and not maintained anymore
  process_directory(src: bindings_src, dst: ADDONS_DST / "bindings") do |current_path|
    # Grab the first path that is a child of bindings_src
    addon = current_path.descend.find { |p| p.parent == bindings_src }&.basename.to_s
    next false if IGNORED_ADDONS.include?(addon)

    if addon == "zwave" && !zwave_docs.include?(current_path)
      next false # If it is zwave, only include readme.md and doc/things.md
    end

    true # For all other addons, include everything
  end

  zwave_things_src = zwave_src / "doc/things.md"
  if zwave_things_src.exist?
    puts "   ➡️ Creating Z-Wave thing viewer"

    zwave_thing_dst = ADDONS_DST / "bindings/zwave/thing.md"
    zwave_thing_dst.write <<~MARKDOWN
      ---
      title: ZWave Thing
      prev: ./
      ---

      <ThingDocRenderer />
    MARKDOWN
  end

  # Custom fixes
  broken_file = Pathname("addons/bindings/shelly/doc/UseCaseSmartRoller.md")
  if broken_file.exist?
    puts "   ➡️ Fixing broken Shelly doc"
    lines = broken_file.readlines.reject { |line| line.include?("uiroller_1.png") }
    broken_file.write(lines.join)
  end
end

# Write arrays of addons by type to include in VuePress config.js
puts "➡️ Writing add-ons arrays to files for sidebar navigation"
%w[bindings persistence automation integrations transformations voice ui].each do |type|
  type_dir = ADDONS_DST / type
  next unless type_dir.directory?

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

  formatted_exports = module_exports.map { |path, title| "  [ '#{path}', '#{title}' ]" }.join(",\n")

  File.write(".vuepress/addons-#{type}.js", <<~JS)
    module.exports = [
    #{formatted_exports}
    ]
  JS
end

# External content is not included for PRs - therefore the _addons_iconsets folder is not present for PR checks - this section will be skipped.
if options[:pull_request]
  puts ""
  puts "⚠️  Iconsets depend on Jenkins job - will be skipped ..."
  puts ""
else
  # Regenerate the classic iconset docs
  puts "➡️ Generating iconset"
  process_iconset(
    iconset: "classic",
    src: DOCS_SRC / "_addons_iconsets",
    dst: DOCS_DST / "configuration/iconsets",
    data: DOCS_SRC / "_data"
  )
end

# Clean-Ups required for repeated local build
verbose "🧹 Cleaning existing JavaDoc ..."
FileUtils.rm Dir.glob("javadoc-latest.*"), force: true
FileUtils.rm_rf(".vuepress/public/javadoc/latest")

# Publish latest Javadoc
puts "➡️ Downloading and extracting latest Javadoc from Jenkins"
`wget -nv https://ci.openhab.org/job/openHAB-JavaDoc/lastSuccessfulBuild/artifact/target/javadoc-latest.tgz`
`tar xzvf javadoc-latest.tgz --strip 2 && mv apidocs/ .vuepress/public/javadoc/latest`
FileUtils.rm "javadoc-latest.tgz"

# External content is not included for PRs - therefore thing-types.json is not present for PR checks - this section will be skipped.
if options[:pull_request]
  puts ""
  puts "⚠️  Thing types depend on Jenkins job - will be skipped ..."
  puts ""
else
  # Copy the thing-types.json file to the proper location
  puts "➡️ Copying Thing types"
  FileUtils.cp(DOCS_SRC / ".vuepress/thing-types.json", ".vuepress")
end
