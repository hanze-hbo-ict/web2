#!/usr/bin/env ruby

trap("SIGINT") { exit }

if ARGV.length < 2
  puts "Usage: #{$0} watch_folder keyword"
  puts "Example: #{$0} . mywebproject"
  exit
end

dev_extension = 'dev'
filetypes = ['md']
watch_folder = ARGV[0]
keyword = ARGV[1]
puts "Watching #{watch_folder} and subfolders for changes in project files..."

while true do
  files = []
  filetypes.each {|type|
    files += Dir.glob( File.join( watch_folder, "**", "*.#{type}" ) )
  }
  new_hash = files.collect {|f| [ f, File.stat(f).mtime.to_i ] }
  hash ||= new_hash
  diff_hash = new_hash - hash

  unless diff_hash.empty?
    hash = new_hash

    puts "Detected change, refreshing"
    %x{jupyter-book build .}
    %x{osascript<<ENDGAME
		tell application "Google Chrome"
			set windowList to every window
			repeat with aWindow in windowList
				set tabList to every tab of aWindow
				repeat with atab in tabList
					if (URL of atab contains "#{keyword}") then
						tell atab to reload
					end if
				end repeat
			end repeat
		end tell
ENDGAME
}
end

  sleep 1
end

