# frozen_string_literal: true

require "English"
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
