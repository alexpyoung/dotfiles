# Interactive shells. PATH and environment live in .zprofile.

# History
HISTFILE=~/.local/state/zsh/history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_reduce_blanks # collapse extra spaces
setopt hist_ignore_all_dups # keep only the newest copy of a command
setopt hist_ignore_space # leading space = not saved
setopt share_history # see other tabs' commands
setopt extended_history # save timestamps and durations
setopt hist_verify # expand !! onto the line before running

# Navigation
setopt auto_cd # type a directory to cd into it
setopt auto_pushd # every cd joins the directory stack
setopt pushd_ignore_dups

# Completion
fpath=($HOMEBREW_PREFIX/share/zsh/site-functions $fpath)
autoload -Uz compinit
() {
    local dump=~/.cache/zsh/zcompdump
    local -a stale=($dump(N.mh+24))
    # Rebuild the completion cache at most once a day
    if [[ ! -e $dump || -n $stale ]]; then
        compinit -d $dump
    else
        compinit -C -d $dump
    fi
}
zstyle ':completion:*' menu select # arrow-key menu
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # case insensitive

# Vi mode; fzf binds after it so Ctrl-R, Ctrl-T and Alt-C survive
ZVM_VI_INSERT_ESCAPE_BINDKEY=jk # same as .vimrc
zvm_after_init_commands+=('source <(fzf --zsh)')
source $HOMEBREW_PREFIX/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

source $ZDOTDIR/aliases.zsh
source $ZDOTDIR/functions.zsh
for plugin in $ZDOTDIR/plugins/*.zsh(N); do
    source $plugin
done
unset plugin

# Suggest a brew package for unknown commands
HOMEBREW_COMMAND_NOT_FOUND_HANDLER=$HOMEBREW_REPOSITORY/Library/Homebrew/command-not-found/handler.sh
[[ -f $HOMEBREW_COMMAND_NOT_FOUND_HANDLER ]] && source $HOMEBREW_COMMAND_NOT_FOUND_HANDLER

eval "$(starship init zsh)"

source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh # must be last
