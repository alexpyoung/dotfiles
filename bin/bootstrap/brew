#!/usr/bin/env bash

set -euo pipefail

install_homebrew() {
    pushd /usr/local > /dev/null
    # https://github.com/Homebrew/brew/issues/3228
    sudo mkdir -p homebrew
    sudo chown -R "$(whoami)":admin homebrew
    sudo mkdir -p var/homebrew
    sudo chown -R "$(whoami)":admin var/homebrew
    if [[ -e homebrew ]]; then
        echo "Updating homebrew..."
        brew update
    else
        echo "Installing homebrew..."
        curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh
    fi
    popd > /dev/null
}

main() {
    install_homebrew
    pushd "$(cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd)/../.." > /dev/null
    echo "Installing packages..."
    brew bundle install
    popd > /dev/null
}

main
