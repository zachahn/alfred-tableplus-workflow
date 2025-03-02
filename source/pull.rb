#!/usr/bin/env ruby --disable-gems

require_relative "./lib"

log1 "Copying live workflow info.plist to repository"
FileUtils.cp(LIVE_WORKFLOW_DIR/"info.plist", HERE/".."/"info.plist")

log1 "Copying live workflow icon.png to repository"
FileUtils.cp(LIVE_WORKFLOW_DIR/"icon.png", HERE/".."/"icon.png")

log1 "Done"
