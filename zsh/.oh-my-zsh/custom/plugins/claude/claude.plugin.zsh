#!/usr/bin/env zsh

set +euo pipefail

claude_helper() {
    local profile="$1"
    shift

    case "$profile" in
        work)
            CLAUDE_CONFIG_DIR="$HOME/.claude-rollout" command claude "$@"
            ;;
        personal)
            CLAUDE_CONFIG_DIR="$HOME/.claude" command claude "$@"
            ;;
        *)
            echo "Usage: c {work|personal} [claude args...]" >&2
            return 1
            ;;
    esac
}

claude_config() {
    ln -sf ~/.claude/projects ~/.claude-rollout/projects
}

alias c='claude_helper'

