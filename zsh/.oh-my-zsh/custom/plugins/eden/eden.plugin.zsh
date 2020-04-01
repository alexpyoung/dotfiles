#!/usr/bin/env zsh

eden-clone() {
    cd ~/q || return 1
    if [[ -d "$1" ]]; then
        cd "$1" || return 1
        g rbm
    else
        git clone "git@github.com:edenwizards/$1.git"
        cd "$1" || return 1
    fi
}

