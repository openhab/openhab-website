# frozen_string_literal: true

# This will clone https://github.com/openhab/openhab-docs
# and migrate content into the website with some changes

require "fileutils"
require "uri"
require "open-uri"
require "json"

$docs_repo = "https://github.com/openhab/openhab-docs"
$docs_repo_root = "#{$docs_repo}/blob/main"
$docs_repo_branch = "final"
$addons_repo_branch = "main"
$version = "final"
$verbose = false

$ignore_addons = ["transport.modbus", "transport.feed", "javasound", "webaudio", "oh2"]

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
    system("git clone --depth 1 #{repository_url} --branch #{branch} #{$verbose ? "" : "--quiet"}")
    system("git reset ##{sha} #{$verbose ? "" : "--quiet"}")
  end
end

verbose "🧹 Cleaning existing documentation downloads ..."
Dir.glob("javadoc-*.tgz*").select { |file| /pattern/.match file }.each { |file| File.delete(file) }

$parameter_no_clone = false
$pull_request = nil

previous_argument = ""
ARGV.each do |arg|
  case arg
  when "--no-clone"
    $parameter_no_clone = true
    verbose " --no-clone ➡️ existing clone will be used"
  when "--verbose"
    $verbose = true
  else
    case previous_argument
    when "--pull-request"
      $pull_request = arg
      $version = "final"
      verbose "➡️ PR #{$pull_request} will be used to build documentation"
    end
  end
  previous_argument = arg
end

if ENV["OH_DOCS_VERSION"]
  $version = ENV["OH_DOCS_VERSION"]
  $version += ".0" if $version.split(".").length == 2
end

puts "➡️ Generating docs for version #{$version}"

if $parameter_no_clone && Dir.exist?(".vuepress/openhab-docs")
  puts "➡️ Re-using existing clone"
else
  verbose "➡️ Deleting .vuepress/openhab-docs if existing..."
  FileUtils.rm_rf(".vuepress/openhab-docs")
end

if $pull_request
  # .vuepress/openhab-docs is git-ignored in the website repository, which is why we can clone it into website without any issue.
  checkout_pull_request($pull_request, ".vuepress")
elsif !$parameter_no_clone
  puts "➡️ Cloning repository #{$docs_repo} 📦 ..."
  `git clone --depth 1 --branch #{$version || $docs_repo_branch} #{$docs_repo} .vuepress/openhab-docs`
end

# Get a list of sub-addons to transform them into links
def get_subs_links(parent_addon_id, search_dir)
  sub_addons = []
  Dir.glob("#{search_dir}/#{parent_addon_id}.*/**/readme.md") do |sub_readme|
    sub_addon_id = File.dirname(sub_readme).split("/").last
    verbose "    ➡️ expanding list of sub-addons: #{sub_addon_id}"
    File.open(sub_readme).each do |line|
      if line =~ /^# /
        sub_addons.push([sub_addon_id, line.gsub("# ", "").strip])
        break
      end
    end
  end

  sub_addons
end

def process_file(indir, file, outdir, source)
  in_frontmatter = false
  frontmatter_processed = false
  has_source = false
  has_logo = false
  obsolete_binding = false
  og_title = "openHAB"
  og_description = "a vendor and technology agnostic open source automation software for your home"

  unless File.exist?("#{indir}/#{file}")
    verbose "process_file: IGNORING (NON-EXISTING): #{indir}/#{file}"
    return
  end

  FileUtils.mkdir_p(outdir)
  File.open("#{outdir}/#{file}", "w+") do |out|
    File.open("#{indir}/#{file}").each do |line|
      next if line =~ /^layout: documentation/
      next if line =~ /^layout: tutorial/
      next if line =~ /^layout: developers/
      next if line =~ /^layout: intro/
      next if line =~ /^{% include base.html %}/
      next if line =~ /\{: #/
      next if line =~ /\{::options/
      next if line =~ /TOC/
      next if line =~ /no_toc/

      has_source = true if in_frontmatter && line =~ /^source:/
      has_logo = true if in_frontmatter && line =~ /^logo:/

      og_title = line.gsub("title: ", "").gsub("\n", "") if in_frontmatter && line =~ /^title:/
      if in_frontmatter && line =~ /^description:/
        og_description = line.gsub("description: ", "").gsub("\n", "").gsub("[", "").gsub("]", "").gsub(
          %r{\(http[:/\-0-9A-Za-z\.]+\)}, ""
        )
      end

      if line =~ /^---$/
        if !in_frontmatter
          in_frontmatter = true
        elsif !frontmatter_processed
          if !has_source && source
            # Prefer already present source
            out.puts "source: #{source}"
          elsif !has_source
            # Try to determine the source
            outdir_parts = outdir.split("/")
            outdir_parts[1] = "binding" if outdir_parts[1] == "bindings"
            outdir_parts[1] = "transform" if outdir_parts[1] == "transformations"
            outdir_parts[1] = "io" if outdir_parts[1] == "integrations"
            if outdir_parts[0] == "addons"
              addon_type = outdir_parts[1]
              addon = file.split("/")[0]
              source = ""
              if addon_type == "ui"
                puts "    (add-on type is ui)"
                source = "https://github.com/openhab/openhab-webui/blob/#{$addons_repo_branch}/bundles/org.openhab.ui.#{addon}/README.md"
              elsif addon == "zigbee"
                puts "    (add-on is zigbee)"
                source = "https://github.com/openhab/org.openhab.binding.zigbee/blob/#{$addons_repo_branch}/org.openhab.binding.zigbee/README.md"
              elsif addon == "zwave" && file !~ /things/
                puts "    (add-on is zwave)"
                source = "https://github.com/openhab/org.openhab.binding.zwave/blob/#{$addons_repo_branch}/README.md"
              elsif file !~ /things/
                source = "https://github.com/openhab/openhab-addons/blob/#{$addons_repo_branch}/bundles/org.openhab.#{addon_type}.#{addon}/README.md"
              end

              out.puts "source: #{source}" if source != ""

              # For sub-bundles, set the "prev" link to the main add-on
              out.puts "prev: ../#{addon.split(".")[0]}/" if addon.include?(".")

              # Prev link to the main binding doc for zwave/doc/things.md
              out.puts "prev: ../" if file == "zwave/doc/things.md"
            end
          end

          # Add OpenGraph tags
          out.puts "meta:"
          out.puts "  - property: og:title"
          out.puts "    content: \"#{og_title.gsub('"', '\"')}\""
          out.puts "  - property: og:description"
          out.puts "    content: #{og_description}"

          in_frontmatter = false
          frontmatter_processed = true
        end
      end

      # Remove collapsibles in Linux install document and replace them by regular headings
      next if line =~ /include collapsible/ && file =~ /linux/

      line = "##### #{line}" if line =~ /^Apt Based Systems/ && file =~ /linux/
      line = "##### #{line}" if line =~ /^Yum or Dnf Based Systems/ && file =~ /linux/
      line = "##### #{line}" if line =~ /^Systems based on/ && file =~ /linux/

      # Expand <!--list-subs--> comments with a list of links
      # (https://github.com/eclipse/smarthome/issues/5571)
      if line =~ /<!--\s*list-subs\s*-->/
        sub_addons = get_subs_links(file.split("/")[0], indir)
        out.puts
        sub_addons.each do |sub|
          out.puts "- [#{sub[1]}](../#{sub[0]}/)"
        end
        out.puts
      end

      # Replace links to generated docs in ZWave's things.md by links to the internal viewer
      line = line.gsub(%r{]\((.*)/(.*)\)}, '](../thing.html?manufacturer=\1&file=\2)') if file == "zwave/doc/things.md"

      # Misc replaces (relative links, remove placeholder interpreted as custom tags)
      line = line.gsub("http://docs.openhab.org/addons/uis/habpanel/readme.html", "/docs/configuration/habpanel.html")
      line = line.gsub("http://docs.openhab.org/addons/uis/basic/readme.html", "/addons/ui/basic/")
      line = line.gsub(%r{http://docs\.openhab\.org/addons/(.*)/(.*)/readme\.html}, '/addons/\1/\2/')
      line = line.gsub("http://docs.openhab.org/", "/docs/")
      line = line.gsub("/addons/io/", "/addons/integrations/")
      line = line.gsub("{{base}}/", "./docs/")
      line = line.gsub("(images/", "(./images/")
      line = line.gsub("src=\"images/", "src=\"./images/")
      line = line.gsub("]:images/", "]:./images/")
      line = line.gsub("](doc/", "](./doc/")
      line = line.gsub("(diagrams/", "(./diagrams/")
      line = line.gsub("./docs/tutorials/beginner/", "/docs/tutorial/")
      line = line.gsub("./docs/", "/docs/")
      line = line.gsub("<activeState>", '\<activeState\>')
      line = line.gsub("<passiveState>", '\<passiveState\>')
      line = line.gsub("(?<!`)<dimension>(?!`)", '\<dimension\>')
      line = line.gsub("<TransformProgram>", '\<TransformProgram\>')
      line = line.gsub("<FlahshbriefingDeviceID>", "`<FlahshbriefingDeviceID>`") if file =~ /amazonechocontrol/
      line = line.gsub("<SerialNumber>", "&lt;SerialNumber&gt;") if file =~ /airvisualnode/
      line = line.gsub("<version>", "&lt;version&gt;") if file =~ /caldav/
      line = line.gsub("by <step>", "by `<step>`") if file =~ /ipx8001/
      line = line.gsub("<BR>", "<BR/>")
      line = line.gsub("'<package name>:<widget ID>'", "`<package name>:<widget ID>`") if file =~ /lametrictime/
      line = line.gsub("<mac address of bridge>", "`<mac address of bridge>`") if file =~ /milight/
      line = line.gsub("<mac>", "`<mac>`") if file =~ /milight/
      line = line.gsub("<type of bulb>", "`<type of bulb>`") if file =~ /milight/
      line = line.gsub("<IP-Address of bridge>", "`<IP-Address of bridge>`") if file =~ /milight/
      line = line.gsub("<bulb>", "`<bulb>`") if file =~ /milight/
      line = line.gsub("<zone>", "`<zone>`") if file =~ /milight/
      line = line.gsub("[](", "[here](") if file =~ /powermax1/
      line = line.gsub("<n>", "&lt;n&gt;") if file =~ /rfxcom/
      line = line.gsub(" <value> ", " &lt;value&gt; ") if file =~ /zibase/
      line = line.gsub("<username>", "&lt;username&gt;") if file =~ /zoneminder/
      line = line.gsub("<password>", "&lt;password&gt;") if file =~ /zoneminder/
      line = line.gsub("<yourzmip>", "&lt;yourzmip&gt;") if file =~ /zoneminder/
      line = line.gsub(" <chatId> ", " &lt;chatId&gt; ") if file =~ /telegram/
      line = line.gsub(" <token> ", " &lt;token&gt; ") if file =~ /telegram/
      line = line.gsub("<regular expression>", '\<regular expression\>')
      line = line.gsub('src="images/', 'src="./images/') if outdir =~ /apps/
      line = line.gsub("](/images/", "](./images/") if outdir =~ /google-assistant/

      line = line.gsub(/\{:(style|target).*\}/, "") # Jekyll inline attributes syntax not supported

      out.puts line
    end

    # Add the component for the edit link
    out.puts
    out.puts "<EditPageLink/>"
  end
end

puts "➡️ Migrating the introduction article"
process_file(".vuepress/openhab-docs", "introduction.md", "docs", "https://github.com/openhab/openhab-docs/blob/main/introduction.md")
FileUtils.mv("docs/introduction.md", "docs/readme.md")

# puts "➡️ Migrating common images"
# FileUtils.mkdir_p("docs/images")

puts "➡️ Migrating logos"
FileUtils.cp_r(".vuepress/openhab-docs/images/addons", ".vuepress/public/logos")

puts "➡️ Migrating the Concepts section"
Dir.glob(".vuepress/openhab-docs/concepts/*.md") do |path|
  file = File.basename(path)
  verbose "   ➡️ #{file}"
  process_file(".vuepress/openhab-docs/concepts", file, "docs/concepts", "#{$docs_repo_root}/concepts/#{file}")
end
verbose "   ➡️ images and diagrams"
FileUtils.cp_r(".vuepress/openhab-docs/concepts/images", "docs/concepts")
FileUtils.cp_r(".vuepress/openhab-docs/concepts/diagrams", "docs/concepts")

puts "➡️ Migrating the Installation section"
Dir.glob(".vuepress/openhab-docs/installation/*.md") do |path|
  file = File.basename(path)
  next if file == "designer.md"

  verbose "   ➡️ #{file}"
  process_file(".vuepress/openhab-docs/installation", file, "docs/installation",
               "#{$docs_repo_root}/installation/#{file}")
end
verbose "   ➡️ images"
FileUtils.cp_r(".vuepress/openhab-docs/installation/images", "docs/installation")

puts "➡️ Migrating the Tutorial section"
Dir.glob(".vuepress/openhab-docs/tutorials/getting_started/*.md") do |path|
  file = File.basename(path)
  verbose "   ➡️ #{file}"
  process_file(".vuepress/openhab-docs/tutorials/getting_started", file, "docs/tutorial",
               "#{$docs_repo_root}/tutorials/getting_started/#{file}")
end
verbose "   ➡️ images"
FileUtils.cp_r(".vuepress/openhab-docs/tutorials/getting_started/images", "docs/tutorial")

puts "➡️ Migrating the Configuration section"
Dir.glob(".vuepress/openhab-docs/configuration/*.md") do |path|
  file = File.basename(path)
  next if file == "transform.md" # Useless, copy the one from addons

  verbose "   ➡️ #{file}"
  process_file(".vuepress/openhab-docs/configuration", file, "docs/configuration",
               "#{$docs_repo_root}/configuration/#{file}")
end
verbose "   ➡️ images"
FileUtils.cp_r(".vuepress/openhab-docs/configuration/images", "docs/configuration")

puts "➡️ Migrating the Main UI section"
Dir.glob(".vuepress/openhab-docs/mainui/*.md") do |path|
  file = File.basename(path)
  verbose "   ➡️ #{file}"
  process_file(".vuepress/openhab-docs/mainui", file, "docs/mainui", "#{$docs_repo_root}/mainui/#{file}")
end
%w[developer settings].each do |subsection|
  Dir.glob(".vuepress/openhab-docs/mainui/#{subsection}/*.md") do |path|
    file = File.basename(path)
    verbose "   ➡️ #{subsection}/#{file}"
    process_file(".vuepress/openhab-docs/mainui/#{subsection}", file, "docs/mainui/#{subsection}",
                  "#{$docs_repo_root}/mainui/#{subsection}/#{file}")
  end
end
verbose "   ➡️ images"
FileUtils.cp_r(".vuepress/openhab-docs/mainui/images", "docs/mainui")

puts "➡️ Migrating the Migration Tutorial section"
Dir.glob(".vuepress/openhab-docs/configuration/migration/*.md") do |path|
  file = File.basename(path)
  verbose "   ➡️ #{file}"
  process_file(".vuepress/openhab-docs/configuration/migration", file, "docs/configuration/migration",
               "#{$docs_repo_root}/configuration/migration/#{file}")
end
verbose "   ➡️ images"
# FileUtils.cp_r(".vuepress/openhab-docs/configuration/migration/images", "docs/configuration/migration/") // no images placed yet

puts "➡️ Migrating the Blockly Tutorial section"
Dir.glob(".vuepress/openhab-docs/configuration/blockly/*.md") do |path|
  file = File.basename(path)
  verbose "   ➡️ #{file}"
  process_file(".vuepress/openhab-docs/configuration/blockly", file, "docs/configuration/blockly",
               "#{$docs_repo_root}/configuration/blockly/#{file}")
end
verbose "   ➡️ images"
# FileUtils.cp_r(".vuepress/openhab-docs/configuration/blockly/images", "docs/configuration/blockly/") // no images placed yet

puts "➡️ Migrating the UI section"
Dir.glob(".vuepress/openhab-docs/ui/*.md") do |path|
  file = File.basename(path)
  verbose "   ➡️ #{file}"
  process_file(".vuepress/openhab-docs/ui", file, "docs/ui", "#{$docs_repo_root}/ui/#{file}")
end
verbose "   ➡️ images"
FileUtils.cp_r(".vuepress/openhab-docs/ui/images", "docs/ui")

verbose "   ➡️ habpanel"
FileUtils.mkdir_p("docs/ui/habpanel")
process_file(".vuepress/openhab-docs/_addons_uis/habpanel/doc", "habpanel.md", "docs/ui/habpanel", "")
verbose "      ➡️ images"
if Dir.exist?(".vuepress/openhab-docs/_addons_uis/habpanel/doc/images")
  FileUtils.cp_r(".vuepress/openhab-docs/_addons_uis/habpanel/doc/images",
                 "docs/ui/habpanel")
end

verbose "   ➡️ habot"
FileUtils.mkdir_p("docs/ui/habot")
process_file(".vuepress/openhab-docs/_addons_uis/habot", "readme.md", "docs/ui/habot", "")
verbose "      ➡️ images"

verbose "   ➡️ components"
FileUtils.mkdir_p("docs/ui/components")
Dir.glob(".vuepress/openhab-docs/_addons_uis/org.openhab.ui/doc/components/*.md") do |path|
  file = File.basename(path)
  verbose "    ➡️ #{file}"
  process_file(".vuepress/openhab-docs/_addons_uis/org.openhab.ui/doc/components", file, "docs/ui/components", "https://github.com/openhab/openhab-webui/blob/main/bundles/org.openhab.ui/doc/components/#{file}")
end
verbose "      ➡️ images"
if Dir.exist?(".vuepress/openhab-docs/_addons_uis/org.openhab.ui/doc/components/images")
  FileUtils.cp_r(".vuepress/openhab-docs/_addons_uis/org.openhab.ui/doc/components/images",
                 "docs/ui/components")
end

puts "➡️ Migrating the Apps section"
Dir.glob(".vuepress/openhab-docs/addons/uis/apps/*.md") do |path|
  file = File.basename(path)
  verbose "   ➡️ #{file}"
  process_file(".vuepress/openhab-docs/addons/uis/apps", file, "docs/apps",
               "#{$docs_repo_root}/addons/uis/apps/#{file}")
end
verbose "   ➡️ images"
FileUtils.cp_r(".vuepress/openhab-docs/addons/uis/apps/images", "docs/apps")

puts "➡️ Migrating the Garmin app section"
Dir.glob(".vuepress/openhab-docs/addons/uis/apps/garmin/*.md") do |path|
  file = File.basename(path)
  verbose "   ➡️ #{file}"
  process_file(".vuepress/openhab-docs/addons/uis/apps/garmin", file, "docs/apps/garmin",
             "#{$docs_repo_root}/addons/uis/apps/garmin/#{file}")
end
verbose "   ➡️ images"
FileUtils.cp_r(".vuepress/openhab-docs/addons/uis/apps/garmin/images", "docs/apps/garmin")

puts "➡️ Migrating the Administration section"
Dir.glob(".vuepress/openhab-docs/administration/*.md") do |path|
  file = File.basename(path)
  verbose "   ➡️ #{file}"
  process_file(".vuepress/openhab-docs/administration", file, "docs/administration",
               "#{$docs_repo_root}/administration/#{file}")
end
verbose "   ➡️ images"
FileUtils.cp_r(".vuepress/openhab-docs/administration/images", "docs/administration")

puts "➡️ Migrating the Developer section"
Dir.glob(".vuepress/openhab-docs/developers/*.md") do |path|
  file = File.basename(path)
  verbose "   ➡️ #{file}"
  process_file(".vuepress/openhab-docs/developers", file, "docs/developer", "#{$docs_repo_root}/developer/#{file}")
end
%w[audio bindings ioservices legacy module-types osgi persistence transformations utils
   ide].each do |subsection|
  Dir.glob(".vuepress/openhab-docs/developers/#{subsection}/*.md") do |path|
    file = File.basename(path)
    verbose "   ➡️ #{subsection}/#{file}"
    process_file(".vuepress/openhab-docs/developers/#{subsection}", file, "docs/developer/#{subsection}",
                 "#{$docs_repo_root}/developer/#{subsection}/#{file}")
  end
end

verbose "   ➡️ images"
FileUtils.cp_r(".vuepress/openhab-docs/developers/bindings/images", "docs/developer/bindings")
FileUtils.cp_r(".vuepress/openhab-docs/developers/osgi/images", "docs/developer/osgi")
FileUtils.cp_r(".vuepress/openhab-docs/developers/ide/images", "docs/developer/ide")

["addons"].each do |subsection|
  Dir.glob(".vuepress/openhab-docs/developers/#{subsection}/*.md") do |path|
    file = File.basename(path)
    verbose "   ➡️ #{subsection}/#{file}"
    process_file(".vuepress/openhab-docs/developers/#{subsection}", file, "docs/developer/#{subsection}",
                 "#{$docs_repo_root}/developer/#{subsection}/#{file}")
  end
end

### ADDONS

# External content is not included for PRs - therefore the _addons_*** folders are not present for PR checks - this section will be skipped.
if $pull_request
  puts ""
  puts "⚠️  Add-on documentation depends on Jenkins job - will be skipped ..."
  puts ""
else
  puts "➡️ Migrating add-ons: Automation"
  Dir.glob(".vuepress/openhab-docs/_addons_automation/**") do |path|
    addon = File.basename(path)
    next if $ignore_addons.include?(addon)

    verbose "   ➡️ #{addon}"
    FileUtils.mkdir_p("addons/automation/#{addon}")
    process_file(".vuepress/openhab-docs/_addons_automation", "#{addon}/readme.md", "addons/automation", nil)

    if Dir.exist?(".vuepress/openhab-docs/_addons_automation/#{addon}/doc")
      verbose "    ➡️ images"
      FileUtils.cp_r(".vuepress/openhab-docs/_addons_automation/#{addon}/doc", "addons/automation/#{addon}")
    end
  end

  puts "➡️ Migrating add-ons: Persistence"
  Dir.glob(".vuepress/openhab-docs/_addons_persistences/**") do |path|
    addon = File.basename(path)
    next if $ignore_addons.include?(addon)

    verbose "   ➡️ #{addon}"
    FileUtils.mkdir_p("addons/persistence/#{addon}")
    process_file(".vuepress/openhab-docs/_addons_persistences", "#{addon}/readme.md", "addons/persistence", nil)

    if Dir.exist?(".vuepress/openhab-docs/_addons_persistences/#{addon}/doc")
      verbose "    ➡️ images"
      FileUtils.cp_r(".vuepress/openhab-docs/_addons_persistences/#{addon}/doc", "addons/persistence/#{addon}")
    end
  end

  puts "➡️ Migrating add-ons: Transformations"
  Dir.glob(".vuepress/openhab-docs/_addons_transformations/**") do |path|
    addon = File.basename(path)
    next if $ignore_addons.include?(addon)

    verbose "   ➡️ #{addon}"
    FileUtils.mkdir_p("addons/transformations/#{addon}")
    process_file(".vuepress/openhab-docs/_addons_transformations", "#{addon}/readme.md", "addons/transformations",
                 nil)
  end

  puts "➡️ Migrating add-ons: Voice"
  Dir.glob(".vuepress/openhab-docs/_addons_voices/**") do |path|
    addon = File.basename(path)
    next if $ignore_addons.include?(addon)

    verbose "   ➡️ #{addon}"
    FileUtils.mkdir_p("addons/voice/#{addon}")
    process_file(".vuepress/openhab-docs/_addons_voices", "#{addon}/readme.md", "addons/voice", nil)
  end

  puts "➡️ Migrating add-ons: IO"
  Dir.glob(".vuepress/openhab-docs/_addons_ios/**") do |path|
    addon = File.basename(path)
    next if $ignore_addons.include?(addon)

    verbose "   ➡️ #{addon}"

    FileUtils.mkdir_p("addons/integrations/#{addon}")
    process_file(".vuepress/openhab-docs/_addons_ios", "#{addon}/readme.md", "addons/integrations", nil)
    if Dir.exist?(".vuepress/openhab-docs/_addons_ios/#{addon}/doc")
      verbose "    ➡️ images"
      FileUtils.cp_r(".vuepress/openhab-docs/_addons_ios/#{addon}/doc", "addons/integrations/#{addon}")
    end
    if Dir.exist?(".vuepress/openhab-docs/_addons_ios/#{addon}/contrib")
      verbose "    ➡️ images"
      FileUtils.cp_r(".vuepress/openhab-docs/_addons_ios/#{addon}/contrib", "addons/integrations/#{addon}")
    end
  end

  puts "➡️ Migrating add-ons: UI"
  Dir.glob(".vuepress/openhab-docs/_addons_uis/**") do |path|
    next if path =~ /org.openhab.ui/

    addon = File.basename(path)
    next if $ignore_addons.include?(addon)

    verbose "   ➡️ #{addon}"
    FileUtils.mkdir_p("addons/ui/#{addon}")
    process_file(".vuepress/openhab-docs/_addons_uis", "#{addon}/readme.md", "addons/ui", nil)

    if Dir.exist?(".vuepress/openhab-docs/_addons_uis/#{addon}/doc")
      verbose "    ➡️ images"
      FileUtils.cp_r(".vuepress/openhab-docs/_addons_uis/#{addon}/doc", "addons/ui/#{addon}")
    end
  end

  # Handle those three separately - copy them in the "ecosystem" section
  puts "➡️ Migrating special ecosystem integrations"
  verbose "   ➡️ Create folders"
  FileUtils.mkdir_p("docs/ecosystem/alexa")
  FileUtils.mkdir_p("docs/ecosystem/google-assistant")

  ecosystem_path = "_ecosystem"

  verbose "   ➡️ Process alexa-skill docs"
  process_file(".vuepress/openhab-docs/#{ecosystem_path}/alexa-skill", "readme.md", "docs/ecosystem/alexa", "https://github.com/openhab/openhab-alexa/blob/master/USAGE.md")
  verbose "    ➡️ images"
  FileUtils.cp_r(".vuepress/openhab-docs/#{ecosystem_path}/alexa-skill/images", "docs/ecosystem/alexa")

  verbose "   ➡️ Process google-assistant docs"
  process_file(".vuepress/openhab-docs/#{ecosystem_path}/google-assistant", "readme.md", "docs/ecosystem/google-assistant",
               "https://github.com/openhab/openhab-google-assistant/blob/master/docs/USAGE.md")
  verbose "    ➡️ images"
  FileUtils.cp_r(".vuepress/openhab-docs/#{ecosystem_path}/google-assistant/images", "docs/ecosystem/google-assistant")

  puts "➡️ Migrating add-ons: Bindings"
  Dir.glob(".vuepress/openhab-docs/_addons_bindings/**") do |path|
    addon = File.basename(path)
    next if $ignore_addons.include?(addon)

    verbose "   ➡️ #{addon}"

    FileUtils.mkdir_p("addons/bindings/#{addon}")
    process_file(".vuepress/openhab-docs/_addons_bindings", "#{addon}/readme.md", "addons/bindings", nil)
    if Dir.exist?(".vuepress/openhab-docs/_addons_bindings/#{addon}/doc") && addon != "zwave"
      verbose "    ➡️ images"
      FileUtils.cp_r(".vuepress/openhab-docs/_addons_bindings/#{addon}/doc", "addons/bindings/#{addon}")
    elsif Dir.exist?(".vuepress/openhab-docs/_addons_bindings/#{addon}/contrib") && addon != "zwave"
      verbose "    ➡️ images"
      FileUtils.cp_r(".vuepress/openhab-docs/_addons_bindings/#{addon}/contrib", "addons/bindings/#{addon}")
    elsif addon == "zwave"
      verbose "    ➡️ things.md"
      FileUtils.mkdir_p("addons/bindings/zwave/doc")
      process_file(".vuepress/openhab-docs/_addons_bindings", "zwave/doc/things.md", "addons/bindings", nil)
    end
  end

  puts "➡️ Creating Z-Wave thing viewer"
  if File.exist?(".vuepress/openhab-docs/_addons_bindings/zwave/doc/things.md")
    File.open("addons/bindings/zwave/thing.md", "w+") do |out|
      out.puts "---"
      out.puts "title: ZWave Thing"
      out.puts "prev: ./"
      out.puts "---"
      out.puts
      out.puts "<ThingDocRenderer />"
    end
  end

  # puts "➡️ Migrating Z-Wave docs"
  # Dir.glob(".vuepress/openhab-docs/_addons_bindings/zwave/doc/*.md") { |path|
  #     next if path =~ /device\.md/
  #     file = File.basename(path)
  #     puts "   -> #{file}"
  #     FileUtils.mkdir_p("addons/bindings/zwave/doc")
  #     process_file(".vuepress/openhab-docs/_addons_bindings/zwave/doc", file, "addons/bindings/zwave/doc", nil)
  # }
end

# Write arrays of addons by type to include in VuePress config.js
puts "➡️ Writing add-ons arrays to files for sidebar navigation"
%w[bindings persistence automation integrations transformations voice ui].each do |type|
  File.open(".vuepress/addons-#{type}.js", "w+") do |file|
    file.puts "module.exports = ["

    if Dir.exist?("addons/#{type}")
      Dir.foreach("addons/#{type}") do |dir|
        unless dir.include?(".")
          # puts dir
          found = false
          File.readlines("addons/#{type}/#{dir}/readme.md").each do |line|
            if line =~ /^label:/ && !found
              title = line.gsub("label: ", "").gsub("\n", "")
              file.puts "\t['#{type}/#{dir}/', '#{title}']," unless title =~ /1\.x/
              found = true
            end
          end
        end
      end
    end

    file.puts "]"
  end
end

# External content is not included for PRs - therefore the _addons_iconsets folder is not present for PR checks - this section will be skipped.
if $pull_request
  puts ""
  puts "⚠️  Iconsets depend on Jenkins job - will be skipped ..."
  puts ""
else
  # Regenerate the classic iconset docs
  puts "➡️ Generating iconset"
  system("ruby generate_iconset_doc.rb .vuepress/openhab-docs/_addons_iconsets classic .vuepress/openhab-docs/_data docs/configuration/iconsets")
end

# Clean-Ups required for repeated local build
verbose "🧹 Cleaning existing JavaDoc ..."
FileUtils.rm Dir.glob("javadoc-latest.*"), force: true
FileUtils.rm_rf Dir.glob(".vuepress/public/javadoc/latest")

# Publish latest Javadoc
puts "➡️ Downloading and extracting latest Javadoc from Jenkins"
`wget -nv https://ci.openhab.org/job/openHAB-JavaDoc/lastSuccessfulBuild/artifact/target/javadoc-latest.tgz`
`tar xzvf javadoc-latest.tgz --strip 2 && mv apidocs/ .vuepress/public/javadoc/latest`

# External content is not included for PRs - therefore thing-types.json is not present for PR checks - this section will be skipped.
if $pull_request
  puts ""
  puts "⚠️  Thing types depend on Jenkins job - will be skipped ..."
  puts ""
else
  # Copy the thing-types.json file to the proper location
  puts "➡️ Copying Thing types"
  FileUtils.cp(".vuepress/openhab-docs/.vuepress/thing-types.json", ".vuepress")
end
