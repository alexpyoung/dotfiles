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
  gamechanger
  git
  git-auto-fetch
  mbq
  ripgrep
  zsh-interactive-cd
  zsh_reload
  zsh-syntax-highlighting
)

# Added by TravisCI gem
[[ -f $HOME/.travis/travis.sh ]] && source $HOME/.travis/travis.sh

source $ZSH/oh-my-zsh.sh

eval "$(nodenv init -)"
eval "$(pyenv init -)"
eval "$(rbenv init -)"

source ~/.aliases
source ~/.functions
