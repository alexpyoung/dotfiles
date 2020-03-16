#!/usr/bin/env bash

set -euo pipefail

main() {
    local -r ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd)/../.."
    code --install-extension shan.code-settings-sync
    pbcopy < "$ROOT_DIR/vscode/.gist"
    echo "Gist copied to clipboard."
    open https://github.com/shanalikhan/code-settings-sync#download-your-settings
    open https://github.com/shanalikhan/code-settings-sync#toggle-auto-upload-on-change
    open https://github.com/shanalikhan/code-settings-sync#toggle-auto-download
}

main