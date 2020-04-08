#!/usr/bin/env bash

set -euo pipefail

main() {
    stow --verbose=2 vim
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}

main
