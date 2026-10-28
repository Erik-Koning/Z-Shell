# Z-Shell

My zsh and Ghostty config.

## New machine

1. Install [Homebrew](https://brew.sh) and follow its "Next steps", which add `brew shellenv` to `~/.zprofile`.
2. Clone, install packages, and link the configs:
   ```sh
   git clone https://github.com/Erik-Koning/Z-Shell.git ~/Z-Shell
   cd ~/Z-Shell
   brew bundle
   ./install.sh
   ```
3. Install what the Brewfile doesn't cover (`.zshrc` works without them):
   - [nvm](https://github.com/nvm-sh/nvm#installing-and-updating)
   - [bun](https://bun.sh): `curl -fsSL https://bun.sh/install | bash`
   - the `chatgpt` CLI (used by `cg` / `cgc`), `grok`, `lidawake`
   - Android Studio (for `JAVA_HOME` and the Android SDK paths)
4. Put API keys and anything machine-specific in `~/.zshrc.local`. It's sourced at the end of `.zshrc` and never committed.

`install.sh` symlinks each file into place and moves any existing file aside to `<name>.backup-<timestamp>`. Re-running it is safe. Edits to the linked files land in this repo, so commit and push them from here.

## What goes where

| Repo | Linked to |
|---|---|
| `zsh/.zshrc` | `~/.zshrc` |
| `zsh/chatgpt_functions.sh` | `~/.zsh/chatgpt_functions.sh` |
| `ghostty/config` | `~/.config/ghostty/config` |
| `ghostty/scripts/*` | `~/.config/ghostty/scripts/*` |

The Ghostty layout scripts are triggered by a Karabiner-Elements Hyper+5 rule, which isn't in this repo yet.
