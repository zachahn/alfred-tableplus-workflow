#!/usr/bin/env ruby --disable-gems

require_relative "./lib"

script_rb = HERE.join("script.rb").read
readme_md = HERE.join("README.template").read
info_plist = HERE.join("plist.template").read

variables = {}
variables[:license] = HERE.join("../LICENSE").read.strip
variables[:version] = HERE.join("VERSION").read.strip
variables[:script] = escape_for_xml(script_rb)
variables[:loc] = script_rb.lines.count
variables[:readme_raw] = readme_md % variables
variables[:readme] = escape_for_xml(variables[:readme_raw].strip)
final = info_plist % variables

log1 "Writing README.md"
HERE.join("../README.md").write(variables[:readme_raw])
log1 "Writing info.plist"
HERE.join("../info.plist").write(final)

log1 "Done"
