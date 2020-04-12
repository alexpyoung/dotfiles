#!/usr/bin/env bash

set -euo pipefail

main() {
    local -r DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd)"
    local -r LOG=/var/log/cron.log
    sudo touch $LOG
    sudo chmod a+rw $LOG
    crontab "$DIR"/../../crontab
    echo "New crontab installed:"
    crontab -l
}

main

