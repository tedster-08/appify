#! /usr/bin/env ruby

unless ARGV.length == 2 or ARGV.length == 4; puts "app <scriptname> <appname> [-i iconfile]"; exit 0; end

require "fileutils"

scriptname = ARGV[0]
appname = ARGV[1]
if ARGV[2] == "-i"; iconfile = ARGV[3]; end

plist = %(
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>CFBundleIconFile</key>
	<string>appicon.icns</string>
	<key>CFBundleName</key>
	<string>#{appname}</string>
</dict>
</plist>
)

Dir.mkdir("#{appname}.app")
Dir.mkdir("#{appname}.app/Contents")
Dir.mkdir("#{appname}.app/Contents/Resources")
Dir.mkdir("#{appname}.app/Contents/MacOS")

plistfile = File.open("#{appname}.app/Contents/Info.plist", "w") { |f| f.write(plist) }
FileUtils.cp(scriptname, "#{appname}.app/Contents/MacOS/#{appname}")
FileUtils.cp(iconfile, "#{appname}.app/Contents/Resources/appicon.icns")
