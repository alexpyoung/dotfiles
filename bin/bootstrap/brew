#!/usr/bin/env bash

set -euo pipefail

own() {
    sudo mkdir -p /usr/local/"$1"
    sudo chown -R "$(whoami)":admin /usr/local/"$1"
}

install_homebrew() {
    # https://github.com/Homebrew/brew/issues/3228
    own homebrew
    own var/homebrew
    if [[ ! -e /usr/local/homebrew ]]; then
        echo "Installing homebrew..."
        curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh
    fi
}

main() {
    install_homebrew
    pushd "$(cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd)/../.." > /dev/null
    echo "Installing packages..."
    brew bundle install
    popd > /dev/null
}

main
