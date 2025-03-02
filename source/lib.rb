require "fileutils"
require "pathname"

def log1(message)
  puts "======> #{message}"
end

def escape_for_xml(string)
  string.gsub("&", "&amp;").gsub("<", "&lt;").gsub(">", "&gt;")
end

HERE = Pathname.new(__dir__)

log1 "Loading ./env"
HERE.join("env").read.each_line do |line|
  key, value = line.split("=", 2).map(&:strip)
  next if value.nil?
  ENV[key] ||= value
end

LIVE_WORKFLOW_DIR = Pathname.new(ENV.fetch("INSTALLED_WORKFLOW_PATH"))
