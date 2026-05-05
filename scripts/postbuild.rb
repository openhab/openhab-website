# frozen_string_literal: true

# Executed after `vuepress build`.
# Performs last minute fixups before publishing.

# Adds a class to the navbar for the homepage
filepath = "vuepress/index.html"
# IO.write(filepath, File.open(filepath) {|f| f.read.gsub(/<link rel="prefetch" href=".*">$/, "")})
File.write(filepath, File.open(filepath) { |f| f.read.gsub('class="navbar"', 'class="homepage navbar"') })
