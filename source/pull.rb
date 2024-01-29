#!/usr/bin/env ruby --disable-gems

require "pathname"
require "json"

class String
  def unescape
    gsub("&lt;", "<").gsub("&gt;", ">").gsub("&amp;", "&")
  end
end

here = Pathname.new(__dir__)

(here/"env").read.each_line do |line|
  key, value = line.split("=", 2).map(&:strip)
  next if value.nil?
  ENV[key] ||= value
end

live_contents_path = (Pathname.new(ENV.fetch("INSTALLED_WORKFLOW_PATH"))/"info.plist")
live_contents = live_contents_path.read

(here/"plist.template").write(live_contents)

puts "done (kinda)"
