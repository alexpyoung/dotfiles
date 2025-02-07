#!/usr/bin/env zsh
#
#
#

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
  img
  ripgrep
  vi-mode
  zsh-interactive-cd
  # zsh_reload
  zsh-syntax-highlighting
)

setopt hist_reduce_blanks
setopt hist_ignore_all_dups

# Added by TravisCI gem
[[ -f $HOME/.travis/travis.sh ]] && source $HOME/.travis/travis.sh

source $HOME/.oh-my-zsh/oh-my-zsh.sh

# eval "$(nodenv init -)"

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

eval "$(pyenv init -)"
eval "$(rbenv init -)"

source ~/.aliases
source ~/.functions

export PATH=$PATH:~/go/bin
# Deduplicate PATH when re-sourcing .zshrc
export PATH=$(echo $PATH | tr ':' '\n' | sort | uniq | tr '\n' ':' | sed 's/:$//')

eval "$(/opt/homebrew/bin/brew shellenv)"
# echo -e "\n. $(brew --prefix asdf)/libexec/asdf.sh"
