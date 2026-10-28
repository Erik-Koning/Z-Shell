#!/bin/bash
# Hyper+5 dispatcher:
#   - Ghostty focused + single pane → apply layout splits
#   - Ghostty focused + multiple panes → capture mode (new window)
#   - Other app focused → capture mode (new window)

KARABINER_CLI="/Library/Application Support/org.pqrs/Karabiner-Elements/bin/karabiner_cli"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
LAYOUT_SCRIPT="$SCRIPT_DIR/layout-3col.sh"
CAPTURE_SCRIPT="$SCRIPT_DIR/capture-and-launch.py"
BUFFER="/tmp/ghostty-capture-buffer"

start_capture() {
    printf '' > "$BUFFER"
    "$KARABINER_CLI" --set-variables '{"capture_mode": 1}'
    /usr/bin/python3 "$CAPTURE_SCRIPT" &
}

FRONTMOST=$(osascript -e 'tell application "System Events" to get bundle identifier of first process whose frontmost is true' 2>/dev/null)

if [ "$FRONTMOST" = "com.mitchellh.ghostty" ]; then
    # Count panes by counting text areas in front window
    PANE_COUNT=$(osascript -e '
        tell application "System Events" to tell process "ghostty"
            tell front window
                set paneCount to 0
                set allElems to entire contents
                repeat with elem in allElems
                    if class of elem is text area then
                        set paneCount to paneCount + 1
                    end if
                end repeat
                return paneCount
            end tell
        end tell
    ' 2>/dev/null)

    if [ "$PANE_COUNT" -le 1 ]; then
        "$LAYOUT_SCRIPT"
    else
        start_capture
    fi
else
    start_capture
fi
