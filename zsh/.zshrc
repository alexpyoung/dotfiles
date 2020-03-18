#!/usr/bin/env zsh

source ~/.exports
source ~/.spaceship

plugins=(
  brew
  bundler
  colored-man-pages
  command-not-found
  common-aliases
  docker
  docker-compose
  gamechanger
  git
  git-extras
  git-auto-fetch
  heroku
  mbq
  ripgrep
  tmux
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
