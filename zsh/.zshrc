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
  eden
  gamechanger
  git-auto-fetch
  mbq
  ripgrep
  vi-mode
  zsh-interactive-cd
  zsh_reload
  zsh-syntax-highlighting
)

# Added by TravisCI gem
[[ -f $HOME/.travis/travis.sh ]] && source $HOME/.travis/travis.sh

source $HOME/.oh-my-zsh/oh-my-zsh.sh

eval "$(nodenv init -)"
eval "$(pyenv init -)"
eval "$(rbenv init -)"

source ~/.aliases
source ~/.functions
