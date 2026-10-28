#!/bin/bash
# Ghostty layout: 3 equal columns, right column split into 3 rows
# Sends keystrokes to the current Ghostty window using existing keybinds:
#   cmd+s \ = split right
#   cmd+s - = split down
#   cmd+s e = equalize splits

osascript <<'APPLESCRIPT'
tell application "System Events" to tell process "ghostty"
    -- Split right → [A | B], focus B
    keystroke "s" using command down
    delay 0.15
    keystroke "\\"
    delay 0.3

    -- Split right → [A | [B | C]], focus C
    keystroke "s" using command down
    delay 0.15
    keystroke "\\"
    delay 0.3

    -- Split down → right col: [C_top | C_bottom], focus C_bottom
    keystroke "s" using command down
    delay 0.15
    keystroke "-"
    delay 0.3

    -- Split down → right col: [C_top | C_mid | C_bottom], focus C_bottom
    keystroke "s" using command down
    delay 0.15
    keystroke "-"
    delay 0.3

    -- Equalize all splits
    keystroke "s" using command down
    delay 0.15
    keystroke "e"
end tell
APPLESCRIPT
