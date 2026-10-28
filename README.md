# dotfiles

[![CI](https://github.com/alexpyoung/dotfiles/actions/workflows/main.yml/badge.svg)](https://github.com/alexpyoung/dotfiles/actions/workflows/main.yml)

Configuration for bootstrapping and maintaining an Apple Silicon Mac. Each top-level folder is a [GNU Stow](https://www.gnu.org/software/stow/manual/stow.html)
package laid out XDG-style and linked with `stow --no-folding --target=$HOME <package>`.
A legacy Intel setup lives in posterity on the `intel-archive` branch.

## New Machine
1. `ssh-keygen -t ed25519 -C "github [at] alexyoung.io"`
2. `ssh-add --apple-use-keychain ~/.ssh/id_ed25519`
3. Add the public key to [GitHub](https://github.com/settings/keys) as an authentication key. 
4. Configure `~/.ssh/config`:
   ```
   Host github.com
     AddKeysToAgent yes
     UseKeychain yes
     IdentityFile ~/.ssh/id_ed25519
   ```
5. `git clone git@github.com:alexpyoung/dotfiles.git ~/dotfiles`
6. `scripts/bootstrap/...`
   1. `brew`: installs Homebrew if missing, then everything in the `Brewfile`
   2. `zsh`
   3. `mise`
   4. `vim`
7. `scripts/setup/...`
   1. `git`: needs 1Password → Settings → Developer → Integrate with 1Password CLI,
      to import the GPG signing key
   2. `macos`: run it yourself; asks for your password, then log out and back in
   3. `moom`: quit Moom first

### Manually
- [qBittorrent](https://www.qbittorrent.org/download): the Homebrew cask is disabled
- Xcode: `xcodes install --latest` (sign in with your Apple ID), then
  `xcodes select <version>` and `sudo xcodebuild -runFirstLaunch`
- GitHub Desktop: GitHub Desktop → Install Command Line Tool, for `git gui`
- Software Update: System Settings → General → Software Update →
  Automatic Updates ⓘ: check, download and security responses on;
  App Store app updates off
- FileVault: confirm `fdesetup status` says it's on

## Existing Machine
- [ ] `scripts/update/brew`: upgrade, then report drift between the Brewfile and the machine
- [ ] `scripts/update/moom`: export Moom's settings and show the diff
- Checks, same as CI: `scripts/ci/shellcheck`, `scripts/ci/zsh`, `scripts/ci/vim`

## Resources
- [Writing custom Git commands](https://blog.theodo.com/2017/06/git-game-advanced-git-aliases/)
- [GNU Stow manual](https://www.gnu.org/software/stow/manual/stow.html)

## Credits
- https://github.com/holman/dotfiles/
- https://github.com/mathiasbynens/dotfiles
- https://github.com/github/scripts-to-rule-them-all
