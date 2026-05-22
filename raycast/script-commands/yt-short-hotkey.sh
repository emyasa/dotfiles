#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title YT Shorts HotKey
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖

osascript <<'EOF'
tell application "System Events"
    set ghosttyRunning to (name of processes) contains "Ghostty"
    if ghosttyRunning then
        tell process "Ghostty"
            set windowCount to count of windows
        end tell
    end if
end tell

if ghosttyRunning and windowCount > 0 then
    tell application "Ghostty"
        activate
        return
    end tell
end if

do shell script "open -a Ghostty"
tell application "System Events"
    tell process "Ghostty"

        repeat until (count of windows) > 0
            delay 0.01
        end repeat

        tell application "Finder"
            set screenBounds to bounds of window of desktop
        end tell

        set screenWidth to item 3 of screenBounds
        set screenHeight to item 4 of screenBounds

        -- =========================
        -- SAFE AREA PADDING (ALL SIDES)
        -- =========================
        set paddingFactor to 0.06 -- 6% padding on EACH side
        set safeWidth to screenWidth * (1 - (paddingFactor * 2))
        set safeHeight to screenHeight * (1 - (paddingFactor * 2))

        -- =========================
        -- FIT 9:16 INSIDE SAFE AREA
        -- =========================
        set targetHeight to safeHeight
        set targetWidth to targetHeight * 9 / 16

        -- if width is too large for safe area, scale down
        if targetWidth > safeWidth then
            set targetWidth to safeWidth
            set targetHeight to targetWidth * 16 / 9
        end if

        -- center inside screen
        set targetX to (screenWidth - targetWidth) / 2
        set targetY to (screenHeight - targetHeight) / 2

        tell front window
            set position to {targetX, targetY}
            set size to {targetWidth, targetHeight}
        end tell

        keystroke "tmux new -A -s session"
        key code 36 -- Enter
    end tell
end tell
EOF

