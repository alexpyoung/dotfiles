#!/usr/bin/env zsh

sshotgun() {
    dusty scripts sshotgun sshotgun -r "$1" -e "$2"
}

# SSH Aliases
gcssh() {
    if [[ $# -eq 3 ]]; then
        ssh "$(awsprey list "$1":"$2" | grep -i "$3" | sort -R | head -n1)"
    else
        ssh "$(awsprey list "$1":"$2" | sort -R | head -n1)"
    fi
}

alias ssh-cron='ssh $(awsprey list cron:production)'

# Dusty Aliases
alias gruntweb='dusty scripts gcweb grunt'
alias dquerysh='dusty scripts querysh querysh'
alias dsshotgun=sshotgun

# Docker Aliases
alias evald='eval $(docker-machine env dusty)'

# Redshift Aliases
function redshift() {
    psql() {
        local -r IP_ADDRESS="$1"
        # shellcheck disable=SC1091
        docker-machine env dusty > /tmp/denv && source /tmp/denv \
            && docker run -ti --rm postgres psql -h "$IP_ADDRESS" -p 5439 -U alex_young -d insights
    }

    local -r ENV="$1"
    local -r STAGING_IP='10.0.96.9'
    local -r PRODUCTION_IP='10.0.0.81'
    if [[ "$ENV" =~ production ]]; then
        psql "$PRODUCTION_IP"
    elif [[ "$ENV" =~ staging ]]; then
        psql "$STAGING_IP"
    else
        echo 'Environment must be "production" or "staging"'
    fi

}

gc_dir_decorator() {
    cd ~/gc/"$1" || return 1
    echo 'Fetching origin...' && g fo
    g st
    g --no-pager diff --stat origin/master
}

# Directory Aliases
alias odyssey='gc_dir_decorator odyssey'
alias gclib='gc_dir_decorator gclib'
alias gcweb='gc_dir_decorator gcweb'
alias gcios='gc_dir_decorator gcios'
alias gcapi='gc_dir_decorator gcapi'
alias gcapi2='gc_dir_decorator gcapi2'
alias gcsystems='gc_dir_decorator gcsystems'
alias sabertooth='gc_dir_decorator sabertooth'
alias sabertoothios='gc_dir_decorator SabertoothIOS'
alias servertooth='gc_dir_decorator servertooth'
alias dusty-specs='gc_dir_decorator dusty-specs'
alias gcuikit='gc_dir_decorator GCUIKit'
alias androidbats='gc_dir_decorator AndroidBats'
alias chakra='gc_dir_decorator chakra'
alias boxes='gc_dir_decorator boxes'

