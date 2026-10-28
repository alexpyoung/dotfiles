# dotfiles

## Manual installs
Not in the Brewfile, so install these by hand:
- [qBittorrent](https://www.qbittorrent.org/download): the Homebrew cask is disabled

## Manual steps
- Xcode: `xcodes install --latest` (sign in with your Apple ID), then
  `xcodes select <version>` and `sudo xcodebuild -runFirstLaunch`
- GitHub Desktop: GitHub Desktop → Install Command Line Tool, for `git gui`
- Software Update: System Settings → General → Software Update →
  Automatic Updates ⓘ: check, download and security responses on;
  App Store app updates off
- FileVault: confirm `fdesetup status` says it's on
