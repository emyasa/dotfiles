#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Ghostty HotKey
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖

osascript <<'EOF'
tell application "System Events"
    set ghosttyRunning to (name of processes) contains "Ghostty"
end tell

-- If Ghostty is running and has a window, bring to front and return early
if ghosttyRunning then
    tell application "System Events"
        tell process "Ghostty"
            if (count of windows) > 0 then
                tell front window
                    tell application "Ghostty" to activate
                end tell
                return
            end if
        end tell
    end tell
end if

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

        -- Only run tmux if not already in tmux
        keystroke "tmux new -A -s session"
        key code 36 -- Enter
    end tell
end tell
EOF

