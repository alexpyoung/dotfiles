# Suggestions

Ideas for improving these dotfiles, collected at the end of the
[Apple Silicon refactor](silicon-refactor.md). Not committed to; open a GitHub issue for any that
get picked up. Roughly in order of value; the top three are 1, 3 and 4.

## 1. Test the New Machine flow from scratch
Every script ran on a Mac that was already half set up, so the README's step order has never been
run end to end. A macOS VM (Tart or UTM, both work on Apple Silicon) or a throwaway user account
would show what breaks. Do it once now, then before relying on it for a real new Mac.

## 2. One entry point
The README credits github/scripts-to-rule-them-all, but setup is still seven manual steps. A
top-level `script/setup` could run brew → zsh → mise → vim → git, then say to run `macos` and
`moom` by hand. Each step should skip what's already done and ask before continuing.

## 3. Move `~/.ssh/config` into the repo
It's the one config file still typed by hand from the README. An `ssh` stow package works, with
`Include config.local` for hosts that shouldn't be public, the same pattern as git's `config.local`.

## 4. Local-override files for every package
git has `config.local`; zsh doesn't. An untracked `~/.config/zsh/local.zsh`, sourced if it exists,
is where work-only aliases and env vars go, keeping them out of the public repo. For git, an
`includeIf "gitdir:~/work/"` block would switch to a work email automatically.

## 5. Catch Homebrew renames in CI
The refactor hit a renamed cask (docker → docker-desktop) and a disabled one (qBittorrent). A small
macOS CI job running `brew info` on every Brewfile entry would flag these before a bootstrap does.

## 6. Keep CI dependencies current
A `.github/dependabot.yml` for the `github-actions` ecosystem would open PRs when actions like
`actions/checkout` get new versions. Pinning `ubuntu-24.04` instead of `ubuntu-latest` gives control
over the Ubuntu 26 switch.

## 7. Reproducible vim plugins
vim-plug installs whatever is newest each time. `:PlugSnapshot` writes a file that pins every
plugin to a commit, so a new Mac gets the same versions.

## 8. A gentle update reminder
The cron jobs were dropped because they upgraded things unattended. A weekly notification (launchd
plus `osascript`) saying "run `scripts/update/brew`" keeps upgrades on-demand without forgetting them.

## Smaller things
- An unstow path, or at least a README line on `stow -D <package>`, so a package can be cleanly
  removed.
- Delete the old `img` branch on GitHub once its k8s helpers definitely aren't needed.
