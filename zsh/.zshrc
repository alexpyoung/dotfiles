#!/usr/bin/env zsh

source ~/.exports
source ~/.spaceship

# zhelp|zalias PLUGIN_NAME
plugins=(
  brew
  colored-man-pages
  command-not-found
  docker
  docker-compose
  git-auto-fetch
  gpg
  ripgrep
  vi-mode
  zsh-interactive-cd
  zsh_reload
  zsh-syntax-highlighting
)

setopt hist_reduce_blanks
setopt hist_ignore_all_dups

# Added by TravisCI gem
[[ -f $HOME/.travis/travis.sh ]] && source $HOME/.travis/travis.sh

source $HOME/.oh-my-zsh/oh-my-zsh.sh

eval "$(nodenv init -)"
eval "$(pyenv init -)"
eval "$(rbenv init -)"

source ~/.aliases
source ~/.functions

# Deduplicate PATH when re-sourcing .zshrc
export PATH=$(echo $PATH | tr ':' '\n' | sort | uniq | tr '\n' ':' | sed 's/:$//')
