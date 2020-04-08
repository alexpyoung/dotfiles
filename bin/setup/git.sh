#!/usr/bin/env bash

set -eo pipefail

configure_signing_key() {
    gpg --list-secret-keys --keyid-format LONG\
        | grep -B 2 "$1"\
        | head -n1\
        | cut -d/ -f2\
        | cut -d' ' -f1\
        | xargs git config --file ~/.gitconfig.local user.signingkey
}

configure_gpg_agent() {
    local -r DIR=~/.gnupg
    if [[ ! -e $DIR/gpg-agent.conf ]]; then
        mkdir -p $DIR
        {
            # 30 days
            echo "default-cache-ttl 2592000"
            echo "max-cache-ttl 2592000"
        } > $DIR/gpg-agent.conf
    fi
    gpgconf --kill gpg-agent
}

# batch mode:
# export GIT_EMAIL=...
# export OP_SECRET_KEY=...
main() {
    stow --verbose=2 git

    [[ -z $GIT_EMAIL ]] && read -r -p "Enter git email: " GIT_EMAIL
    git config --file ~/.gitconfig.local user.email "$GIT_EMAIL"

    [[ -z $OP_SECRET_KEY ]] && read -r -p "Enter 1Password secret key: " OP_SECRET_KEY
    eval "$(op signin my "$GIT_EMAIL" "$OP_SECRET_KEY")"

    local -r UUID=sxwjjzpdgndurmevma5ozxlxei
    echo -e "$(op get item "$UUID" | jq -r '.details.password')" | gpg --import
    configure_signing_key "$GIT_EMAIL"
    configure_gpg_agent
}

main
