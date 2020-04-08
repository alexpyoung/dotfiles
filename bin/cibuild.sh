#!/usr/bin/env bash

set -euo pipefail

bash_check() {
    shellcheck --exclude=SC1071 --shell=bash $1
}

analyze_bash() {
    export -f bash_check
    bash_check "$(file bin/**/*.sh | grep executable | cut -d: -f1)"
    bash_check git/bin/*
    bash_check zsh/.aliases zsh/.exports zsh/.functions
    bash_check zsh/.oh-my-zsh/custom/plugins/**/*.zsh
    local -r GREEN='\033[0;32m'
    local -r RESET='\033[0m'
    printf "${GREEN}✔︎${RESET} shellcheck passed\n"
}

analyze_python() {
    pylint bin/**/*.py
    local -r GREEN='\033[0;32m'
    local -r RESET='\033[0m'
    printf "${GREEN}✔︎${RESET} pylint passed\n"
}

main() {
    local -r ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd)/.."
    pushd $ROOT_DIR > /dev/null
    analyze_bash
    analyze_python
    popd > /dev/null
}

main
