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

alias ecr-login='aws ecr get-login-password | docker login --username AWS --password-stdin 779906012886.dkr.ecr.us-west-2.amazonaws.com'
alias ecr-id='echo "779906012886.dkr.ecr.us-west-2.amazonaws.com" | pbcopy'
