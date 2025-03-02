#!/usr/bin/env ruby --disable-gems

require_relative "./lib"

log1 "Copying repository info.plist to live workflow"
FileUtils.cp(HERE/".."/"info.plist", LIVE_WORKFLOW_DIR/"info.plist")

log1 "Copying repository icon.png to live workflow"
FileUtils.cp(HERE/".."/"icon.png", LIVE_WORKFLOW_DIR/"icon.png")

log1 "Done"
