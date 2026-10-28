#!/usr/bin/env python3
"""
Watches a buffer file for typed input, then opens Ghostty,
runs `z <input>`, and applies the 3-col layout.
"""
import os, sys, time, subprocess

BUFFER = "/tmp/ghostty-capture-buffer"
PID_FILE = "/tmp/ghostty-capture-pid"
DONE_FILE = "/tmp/ghostty-capture-done"
KARABINER_CLI = "/Library/Application Support/org.pqrs/Karabiner-Elements/bin/karabiner_cli"
LAYOUT_SCRIPT = os.path.join(os.path.dirname(os.path.abspath(__file__)), "layout-3col.sh")

def cleanup():
    subprocess.run([KARABINER_CLI, '--set-variables', '{"capture_mode": 0}'])
    for f in [BUFFER, PID_FILE, DONE_FILE]:
        try: os.remove(f)
        except: pass

# Store PID so escape can kill us
with open(PID_FILE, 'w') as f:
    f.write(str(os.getpid()))

# Show notification
subprocess.run(['osascript', '-e',
    'display notification "Type directory name..." with title "Ghostty Layout"'])

# Wait for first input (timeout 10s)
start = time.time()
while True:
    if os.path.exists(DONE_FILE):
        break
    if not os.path.exists(BUFFER):
        sys.exit(0)
    if os.path.getsize(BUFFER) > 0:
        break
    if time.time() - start > 10:
        cleanup()
        sys.exit(0)
    time.sleep(0.05)

# Wait for 1.5s of no input, or Enter signal
while True:
    if os.path.exists(DONE_FILE):
        break
    if not os.path.exists(BUFFER):
        sys.exit(0)
    time.sleep(0.1)
    try:
        mtime = os.path.getmtime(BUFFER)
    except:
        sys.exit(0)
    if time.time() - mtime >= 1.5:
        break

# Read input
try:
    with open(BUFFER) as f:
        user_input = f.read().strip()
except:
    user_input = ""

cleanup()

if not user_input:
    sys.exit(0)

# Open new Ghostty window
subprocess.run(['open', '-na', 'Ghostty.app'])
time.sleep(2)

# Type z <input> and Enter
safe_input = user_input.replace('\\', '\\\\').replace('"', '\\"')
subprocess.run(['osascript', '-e', f'''
tell application "System Events" to tell process "ghostty"
    keystroke "z {safe_input}"
    delay 0.1
    keystroke return
end tell
'''])

# Wait for z to navigate
time.sleep(1.5)

# Run layout
subprocess.run([LAYOUT_SCRIPT])
