#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Ghostty HotKey
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖

osascript <<'EOF'
-- Activate Ghostty
tell application "Ghostty"
	activate
end tell

delay 0.3

tell application "System Events"
	tell process "Ghostty"

		-- If there are no windows, open a new one using menu
		if (count of windows) is 0 then
			tell menu bar 1
				tell menu bar item "File"
					tell menu "File"
						click menu item "New Window"
					end tell
				end tell
			end tell
			delay 0.3
		end if

		-- Double-check if we now have a window
		if (count of windows) is 0 then
			return
		end if

		-- Get screen size
		tell application "Finder"
			set screenBounds to bounds of window of desktop
		end tell

		set screenWidth to item 3 of screenBounds
		set screenHeight to item 4 of screenBounds

		set targetWidth to screenWidth * 2 / 3
		set targetX to screenWidth - targetWidth
		set targetY to 0

		-- Resize the front window
		tell front window
			set position to {targetX, targetY}
			set size to {targetWidth, screenHeight}
		end tell

        -- Type tmux and press enter
		keystroke "tmux"
		key code 36 -- enter key
	end tell
end tell
EOF

