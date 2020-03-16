#!/usr/bin/env zsh

pushd ~ > /dev/null
source .exports
source .spaceship
popd > /dev/null

plugins=(
  colored-man-pages
  git
  zsh_reload
  gamechanger
  mbq
  zsh-syntax-highlighting
)

# Added by TravisCI gem
[[ -f $HOME/.travis/travis.sh ]] && source $HOME/.travis/travis.sh

source $ZSH/oh-my-zsh.sh

eval "$(nodenv init -)"
eval "$(pyenv init -)"
eval "$(rbenv init -)"

pushd ~ > /dev/null
source .aliases
source .functions
popd > /dev/null
