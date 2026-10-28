#!/usr/bin/env bash
# Symlinks the configs in this repo into place. Any existing file is moved
# aside to <name>.backup-<timestamp> first. Safe to re-run.
set -euo pipefail

REPO="$(cd "$(dirname "$0")" && pwd)"
STAMP="$(date +%Y%m%d-%H%M%S)"

link() {
  local src="$REPO/$1" dest="$2"
  mkdir -p "$(dirname "$dest")"
  if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
    echo "ok      $dest"
    return
  fi
  if [ -e "$dest" ] || [ -L "$dest" ]; then
    mv "$dest" "$dest.backup-$STAMP"
    echo "backup  $dest -> $dest.backup-$STAMP"
  fi
  ln -s "$src" "$dest"
  echo "linked  $dest -> $src"
}

link zsh/.zshrc               "$HOME/.zshrc"
link zsh/chatgpt_functions.sh "$HOME/.zsh/chatgpt_functions.sh"
link ghostty/config           "$HOME/.config/ghostty/config"
for s in "$REPO"/ghostty/scripts/*; do
  name="$(basename "$s")"
  link "ghostty/scripts/$name" "$HOME/.config/ghostty/scripts/$name"
done

if [ ! -f "$HOME/.zshrc.local" ]; then
  echo
  echo "Put API keys and machine-specific settings in ~/.zshrc.local (not tracked)."
fi
