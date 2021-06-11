#!/usr/bin/env zsh

alias gpg-new='gpg --full-generate-key'
alias gpg-secret='gpg --list-secret-keys --keyid-format LONG'
alias gpg-kill='gpgconf --kill gpg-agent'

# https://stackoverflow.com/a/42265848/96656
GPG_TTY=$(tty)
export GPG_TTY

function gpg-id() {
    gpg-secret | grep -B 2 "$1" | head -n1 | cut -d/ -f2 | cut -d' ' -f1
}

function gpg-export() { # gpg-export [-secret-key] ID
    if [[ -n $2 ]]; then
        gpg "--export$1" --armor "$2" | cat -e | sed 's/\$/\\n/g' | pbcopy
    else
        gpg --export --armor "$1" | cat -e | sed 's/\$/\\n/g' | pbcopy
    fi
}

function gpg-import() {
    echo -e "$(pbpaste)" | gpg --batch --passphrase "$1" --import
}

function gpg-rm() {
    gpg --delete-secret-key "$1"
    gpg --delete-key "$1"
}
