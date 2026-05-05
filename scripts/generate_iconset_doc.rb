# frozen_string_literal: true

require_relative "lib/website_utils"

# This script re-generate a VuePress-compatible version of an
# iconset's documentation

# Load the list of icons from the original iconset
# Load the categories from the CSV files
# Generate a markdown file with the list of icons and their categories
# Copy the icons to the public folder
$original_iconsets_location = ARGV[0]
$iconset_name = ARGV[1]
$data_dir = ARGV[2]
$out_dir = ARGV[3]

if !$original_iconsets_location || !$iconset_name || !$data_dir || !$out_dir
  puts "Usage: generate_iconset_doc.rb <original_markdown_page> <data_dir> <out_dir>"
  exit(1)
end

process_iconset(
  iconset: $iconset_name,
  src: $original_iconsets_location,
  dst: $out_dir,
  data: $data_dir
)
