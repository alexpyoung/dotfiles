# CLAUDE.md

Guidance for Claude Code sessions in this repo. Why things are the way they are:
[docs/claude/silicon-refactor.md](docs/claude/silicon-refactor.md). Open work:
[GitHub issues](https://github.com/alexpyoung/dotfiles/issues) (`gh issue list`).

## Layout
- Each top-level folder (`git`, `zsh`, `vim`, `mise`, `moom`) is a stow package in XDG layout,
  linked with `stow --no-folding --target=$HOME <package>`. `--no-folding` keeps directories like
  `~/.config` real, so nothing an app writes there lands in the repo.
- `scripts/{bootstrap,setup,update,ci}`. The `Brewfile` at the root is hand-curated: edit it by
  hand, never `brew bundle dump`.
- State and data live outside the repo: `~/.local/state`, `~/.local/share`, `~/.cache`.
- `intel-archive` is the frozen Intel-era setup, kept for reference. Port from it deliberately
  (`git show intel-archive:<path>`); never merge it.

## Working with Alex
- One decision at a time, with the explanation and tradeoffs inside the question itself and a
  recommendation first.
- Don't install anything, run bootstrap or setup scripts, or change system settings without
  approval. Scripts that change system or security settings (`scripts/setup/macos`) are run by Alex.
- Run shell commands in a visible terminal tab.
- Show the diff and the commit message before committing. Commits are GPG-signed; style is
  `type(area): summary`.
- Ask before pushing. The repo is public, so check for secrets first.
- Plists stay binary: inspect with `plutil -p`, edit with `plutil` (not Python), never convert to XML.
- Don't run `op` (the 1Password CLI).

## Gotchas
- macOS 26: `sudo tee` into `/etc/pam.d/sudo_local` reports "Operation not permitted" even when
  the write succeeds. Check the file instead of the exit status.
- Testing vim headless: `vim -N -es -u <vimrc>`. `-es` skips the vimrc unless `-u` is given, and
  `-u` without `-N` starts in vi-compatible mode, which breaks line continuations.
- The Ubuntu runner's shellcheck treats any comment starting with "shellcheck" as a directive.
- Batch `brew install` asks for y/n confirmation, and some casks ask for a password; leave those
  to Alex in the terminal tab.
