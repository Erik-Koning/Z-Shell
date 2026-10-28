# Shared helper to build the command text.
# If the first argument starts with a double-quote, it is left as-is.
# Otherwise, all tokens are joined (as if enclosed in double quotes).
__cg_build_command_text() {
    if [ $# -eq 0 ]; then
        echo "Usage: command text is required" >&2
        return 1
    fi

    if [[ "$1" == \"* ]]; then
        # The first argument already starts with a double quote.
        # Leave it as given.
        command_text="$1"
    else
        # No double-quote at the beginning, so use it as-is.
        command_text="$1"
    fi
    shift

    # Append any additional arguments.
    if [ $# -gt 0 ]; then
        command_text="$command_text $(printf '%s ' "$@")"
    fi

    # Trim any trailing whitespace.
    command_text="$(echo -e "$command_text" | sed 's/[[:space:]]*$//')"
    echo "$command_text"
}

# cgc: Uses the shared logic,
# then calls chatgpt with a "command:" prefix.
cgc() {
    local cmd
    cmd="$(__cg_build_command_text "$@")" || return 1
    chatgpt -p "command:${cmd}"
}

# cg: Uses the shared logic,
# then calls chatgpt passing the command text as is.
cg() {
    local cmd
    cmd="$(__cg_build_command_text "$@")" || return 1
    chatgpt -p "${cmd}"
}
