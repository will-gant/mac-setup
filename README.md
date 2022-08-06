# Mac setup

Run the following to download the latest release of this repo and then run the setup script:

```bash
setup_repo="$(mktemp -d)"
zipball_url="$(curl -s https://api.github.com/repos/will-gant/mac-setup/releases/latest | grep zipball_url | cut -d '"' -f 4)"
zip_file="${setup_repo}/repo.zip"
curl --location "$zipball_url" --output "${setup_repo}/repo.zip"
unzip "$zip_file" -d "$setup_repo"
bash "$setup_repo/*mac-setup*/setup.sh"
```

## Manual steps:

These should be run _after_ the setup script completes.

### SSH key

1. Retrieve SSH private key from password manager
1. Copy it into ~/.ssh/id_rsa
1. Run `eval "$(ssh-agent -s)"`
1. Run `ssh-add --apple-use-keychain ~/.ssh/id_rsa`

### iterm

Import `iterm2.json` as a profile via the iterm GUI

### VScode

Switch on 'sync' and login with GitHub

### System settings

NB. These take effect after a restart

```bash

# updates
sudo defaults write /Library/Preferences/com.apple.commerce AutoUpdate -bool true
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate ConfigDataInstall -bool true
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate CriticalUpdateInstall -bool true
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate AutomaticDownload -bool true
sudo defaults delete /Library/Preferences/com.apple.HIToolbox AppleEnabledInputSources
sudo defaults write /Library/Preferences/com.apple.commerce AutoUpdateRestartRequired -bool true

# enable firewall
sudo defaults write /Library/Preferences/com.apple.alf globalstate -int 2

# enable FileVault encryption (interactive)
sudo fdesetup enable
```
