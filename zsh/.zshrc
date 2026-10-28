export PATH="/opt/homebrew/opt/jpeg/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/jpeg/lib:$LDFLAGS"
export CPPFLAGS="-I/opt/homebrew/opt/jpeg/include:$CPPFLAGS"
export PKG_CONFIG_PATH="/opt/homebrew/opt/jpeg/lib/pkgconfig:$PKG_CONFIG_PATH"

alias ta='tmux attach-session -d || tmux new-session'
alias td='tmux detach'
tat() {
    tmux attach -t "$1" || tmux new -s "$1"
}

eval "$(zoxide init zsh)"
source <(fzf --zsh)

source ~/.zsh/chatgpt_functions.sh

alias pn=pnpm
alias gacp='git add . && git commit -m "$1" && git push'

# Must be last
eval "$(direnv hook zsh)"
eval "$(starship init zsh)"

echo "✅ .zshrc Loaded"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export CLOUDSDK_PYTHON="/opt/homebrew/bin/python3"
export PATH="/opt/homebrew/share/google-cloud-sdk/bin:$PATH"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin

export JAVA_HOME="/Applications/Android Studio.app/Contents/jbr/Contents/Home"

export PATH="$PATH:$HOME/go/bin"

# --- Gas Town Integration (removed when migrating to gascity) ---
# [[ -f "/Users/erikkoning/.config/gastown/shell-hook.sh" ]] && source "/Users/erikkoning/.config/gastown/shell-hook.sh"
# --- End Gas Town ---

# >>> grok installer >>>
export PATH="$HOME/.grok/bin:$PATH"
fpath=(~/.grok/completions/zsh $fpath)
autoload -Uz compinit && compinit -C
# <<< grok installer <<<

# --- lidawake: lid-closed operation (menu bar app: LidAwake.app) ---
alias lid='lidawake'            # lid on | off | toggle | status
alias lidon='lidawake on'
alias lidoff='lidawake off'
alias lids='lidawake status'
(( $+functions[compdef] )) && compdef '_arguments "1:command:(on off toggle status)"' lidawake
# --- end lidawake ---

# Machine-specific settings and secrets (API keys etc.) — not tracked in git
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
