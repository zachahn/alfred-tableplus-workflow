#!/usr/bin/env ruby --disable-gems

require "pathname"

class String
  def escape_some
    gsub("&", "&amp;").gsub("<", "&lt;").gsub(">", "&gt;")
  end
end

here = Pathname.new(__dir__)

(here/"env").read.each_line do |line|
  key, value = line.split("=", 2).map(&:strip)
  next if value.nil?
  ENV[key] ||= value
end

script_rb = (here/"script.rb").read
readme_md = (here/"README.template").read
info_plist = (here/"plist.template").read

variables = {}
variables[:license] = (here/"../LICENSE").read
variables[:version] = (here/"VERSION").read.strip
variables[:script] = script_rb.escape_some
variables[:loc] = script_rb.lines.count
variables[:readme_raw] = readme_md % variables
variables[:readme] = variables[:readme_raw].escape_some
final = info_plist % variables

(here/"../README.md").write(variables[:readme_raw])
(here/"../info.plist").write(final)
File.write(File.join(ENV.fetch("INSTALLED_WORKFLOW_PATH"), "info.plist"), final)

puts "done"
