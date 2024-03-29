# dotfiles

[![CI](https://github.com/alexpyoung/dotfiles/actions/workflows/main.yml/badge.svg)](https://github.com/alexpyoung/dotfiles/actions/workflows/main.yml)

## New Machine
1. [Generate a new SSH key](https://help.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
2. `git clone git@github.com:alexpyoung/dotfiles.git`
3. `scripts/bootstrap/...`
   1. `brew`
   2. `vim`
   3. `zsh`
   4. `cron`
4. Configure 1Password and Dropbox for iTerm
5. `scripts/setup/...`
   1. `macos`
   2. `git`
   3. `vscode`

## Existing Machine
- [ ] `scripts/update/brew`
- [ ] `scripts/update/cron`

## Resources
- [Writing custom Git commands](https://blog.theodo.com/2017/06/git-game-advanced-git-aliases/)
- [GNU Stow manual](https://www.gnu.org/software/stow/manual/stow.html)
- [Colors codes for xterm 256 compatible emulators](https://upload.wikimedia.org/wikipedia/commons/1/15/Xterm_256color_chart.svg)

## Credits
- https://github.com/holman/dotfiles/
- https://github.com/mathiasbynens/dotfiles
- https://github.com/github/scripts-to-rule-them-all
