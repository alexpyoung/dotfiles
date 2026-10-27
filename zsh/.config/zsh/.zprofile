# Login shells: PATH and environment. Runs after path_helper in /etc/zprofile, so PATH order sticks.

eval "$(/opt/homebrew/bin/brew shellenv)" # Homebrew ahead of system tools

typeset -U path # keep PATH unique

# mise shims for scripts, editors and Xcode build phases; .zshrc activates mise fully
(( $+commands[mise] )) && eval "$(mise activate zsh --shims)"

path=(~/.local/bin $path) # own scripts first

export EDITOR=vim
export LANG=en_US.UTF-8
export MANPAGER='less -X' # keep the page on screen after quitting

# Use ripgrep instead of find to respect gitignore
export FZF_DEFAULT_COMMAND='rg --hidden --files-with-matches --glob !.git ""'
