function dot() {
    local -r ROOT_DIR=~/dotfiles
    case $(printf "cd\nscripts\nvim\n" | fzf) in
        "cd" ) pushd $ROOT_DIR || return ;;
        "vim" ) pushd $ROOT_DIR && vim || return ;;
        "scripts" )
            local -r PARENT_DIR=$ROOT_DIR/scripts
            local -r BIN=$(find $PARENT_DIR -type f | sed "s|$PARENT_DIR/||" | fzf)
            bash "$PARENT_DIR/$BIN"
            ;;
    esac
}

# Open the Xcode workspace, else project, in the current directory
function xc() {
    local -a targets=( *.xcworkspace(N) *.xcodeproj(N) )
    if (( ! $#targets )); then
        echo "No Xcode workspace or project here" >&2
        return 1
    fi
    open "$targets[1]"
}

# Colored man pages, without affecting other uses of less
function man() {
    LESS_TERMCAP_mb=$'\e[1;31m' \
    LESS_TERMCAP_md=$'\e[1;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[1;44;33m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[1;32m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    command man "$@"
}
