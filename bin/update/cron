#!/usr/bin/env bash

set -euo pipefail

main() {
    local -r ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd)/../.."
    pushd "$ROOT_DIR" > /dev/null
    echo "Generating crontab..."
    crontab -l > ./crontab
    popd > /dev/null
    git status
}

main
