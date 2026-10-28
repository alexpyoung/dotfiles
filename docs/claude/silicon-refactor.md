# Apple Silicon refactor (October 2026)

Context for Claude Code sessions: how `main` was rebuilt and why. Conventions are in
[CLAUDE.md](../../CLAUDE.md); open work is in
[GitHub issues](https://github.com/alexpyoung/dotfiles/issues): iTerm2, Alfred and Claude Code
settings, VS Code, Dropbox, Android tooling, and pet/snip.

## Strategy
The old `master` had years of thought in it but targeted Intel Macs (`/usr/local` paths, removed
brew flags, old work plugins) and hadn't been evaluated in years. On a new Apple Silicon Mac:

- `master` was renamed to `intel-archive` (GitHub's rename, so old links redirect) and frozen.
- `main` started as an **orphan branch**: no shared history, so nothing comes over by accident.
  Histories can still be joined later with `--allow-unrelated-histories` if ever wanted.
- Each area was ported one at a time. Every item was reviewed individually (keep, change, drop),
  only the chosen commands were run, and each area landed as one GPG-signed commit after review.
- Conventions settled along the way: XDG layout, stow with `--no-folding`, state outside the repo,
  binary plists, hand-curated Brewfile.

## Areas

### git (`d445a40`)
- SSH key in the Keychain for GitHub; commits and tags GPG-signed with the key imported from
  1Password by `scripts/setup/git` (finds the key ID with `--with-colons`, configures pinentry-mac).
- Config moved to `~/.config/git/{config,ignore}`; the signing key is in an untracked `config.local`.
- delta replaces diff-so-fancy (`features = diff-so-fancy`). New defaults: `init.defaultBranch`,
  `push.autoSetupRemote`, `branch.sort`, `merge.conflictStyle = zdiff3`, `diff.algorithm =
  histogram`, `help.autocorrect = prompt`.
- Aliases reviewed one by one: `master` is replaced by a `default` alias, `force` uses
  `--force-with-lease`, `shake` is safe from deleting main, `dr` bug fixed, `gone` replaces the
  `git-x` script, `publish` dropped.

### zsh (`15ac410`)
- oh-my-zsh dropped for plain zsh plus brew plugins (autosuggestions, syntax-highlighting,
  zsh-vi-mode) and fzf's own shell integration. Starship replaces spaceship (faithful port, 24h
  time, red `$` and exit code on failure).
- `~/.zshenv` only sets `ZDOTDIR=~/.config/zsh`. `.zprofile` holds PATH and exports (after
  macOS's path_helper, so Homebrew comes first); `.zshrc` holds interactive setup.
- History in `~/.local/state/zsh/history` (10k, shared across tabs, timestamps).
- Old employer plugins, OMZ-only helpers and Intel-era fixes dropped.

### mise (`b481070`)
- mise replaces nodenv/pyenv/rbenv: Node LTS and latest pnpm globally, per-project pins in
  `mise.toml` (globally git-ignored). Ruby and Python only per project.
- Shims in `.zprofile` so editors, scripts and Xcode build phases resolve versions too.

### moom (`45d71eb`)
- Moom 4 via brew. Settings kept as a cleaned **binary** `moom/config.plist`; diffs via a
  `plutil -p` textconv. `scripts/update/moom` exports and strips state keys.

### brew (`02a971c`)
- Hand-curated `Brewfile`, grouped by area, no taps (core and cask are built in), no `mas`.
- Notable swaps: btop for htop, tlrc for tldr, docker-desktop (renamed cask), Logi Options+,
  ProtonVPN. Dropped: build libraries, *env runtimes, yarn, xctool, postgresql, and others.
- `scripts/update/brew` upgrades, then reports drift both ways without removing anything.

### apps (`4600ba0`)
- Only `dk`/`dkc` aliases and README manual steps. Xcode 27.1 is managed by `xcodes`.
- Account-synced apps (1Password, Slack, browsers, …) need nothing here.

### macOS defaults (`26c7646`, `cdec094`)
- One idempotent `scripts/setup/macos`, run by Alex. Touch ID for sudo via `sudo_local`; keyboard
  repeat; Finder, Dock and power settings; icon views via `defaults export` → plutil → import.
- Many old keys dropped as obsolete on macOS 26 (font smoothing, HiDPI, Bluetooth bitpool,
  screensaver password, debug menus) along with one-time steps.
- Screenshots go to `~/Pictures/Screenshots`.

### cron (nothing ported)
- Every hourly job was dropped: unattended brew upgrades, `tldr --update`, and deleting
  screenshots and Downloads (destructive, with stale patterns).

### bin (nothing ported)
- `ducky` (old System Preferences UI), `reading_list_to_pocket` (Pocket shut down) and
  `bluetooth` / `stan` were all dropped.

### vim (`75cd9b9`)
- Brew vim 9.2 reading `~/.config/vim/vimrc` natively; vim-plug with plugins in
  `~/.local/share/vim`; undo, swap and viminfo in `~/.local/state/vim`.
- Kept: fzf.vim, vinegar, eunuch, sleuth, surround, repeat, gruvbox. Built in instead of
  plugins: comment, matchit, ripgrep as `grepprg`. Dropped: fugitive, gitgutter, airline,
  polyglot, tsuquyomi and others. No LSP client, by choice.
- `,fmt` rewritten to format the current buffer (jq, yq v4, xmllint).

### CI (`0c2a3ea`, `8134eb0`)
- shellcheck for bash scripts, `zsh -n` for zsh files (shellcheck doesn't support zsh), and a
  headless vimrc load test on macOS. Every check is a script in `scripts/ci`.

### Publishing
- `main` pushed and made the default branch; `master` renamed to `intel-archive`; the old `img`
  branch left untouched on GitHub. README rewritten and the Unlicense restored.
