# Mac setup

1. Install commandline developer tools:
    ```
    touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress;
    xcode_version="$(softwareupdate --list | grep -E --only-matching "Command Line Tools for Xcode-[0-9]+\.[0-9]+" | tail -n 1)"
    softwareupdate --install "$xcode_version" --verbose
    rm /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
    ```
1. [Install brew](https://brew.sh/) (requires sudo)
1. Run the following to download the latest release of this repo and then run the setup script:
    ```bash
    setup_repo="$(mktemp -d)"
    zipball_url="$(curl -s https://api.github.com/repos/will-gant/mac-setup/releases/latest | grep zipball_url | cut -d '"' -f 4)"
    zip_file="${setup_repo}/repo.zip"
    curl --location "$zipball_url" --output "${setup_repo}/repo.zip"
    unzip "$zip_file" -d "$setup_repo"
    mkdir -p "${HOME}/Library/LaunchAgents"
    bash ${setup_repo}/*mac-setup*/setup.sh
    ```
1. Retrieve SSH private key from password manager and copy it into ~/.ssh/id_rsa
1. Run `eval "$(ssh-agent -s)"`
1. Run `ssh-add --apple-use-keychain ~/.ssh/id_rsa`
1. Sync settings for Brave
1. Start iterm2 and import `iterm2.json` as a profile via the iterm GUI (check `Working Directory` is correct)
1. Start Visual Studio Code and sync settings by logging in with GitHub Auth
1. Run the following to update system settings: 
    ```bash
    
    sudo defaults write /Library/Preferences/com.apple.commerce AutoUpdate -bool true
    sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate ConfigDataInstall -bool true
    sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate CriticalUpdateInstall -bool true
    sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true
    sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate AutomaticDownload -bool true
    sudo defaults write /Library/Preferences/com.apple.commerce AutoUpdateRestartRequired -bool true
    # enable firewall
    sudo defaults write /Library/Preferences/com.apple.alf globalstate -int 2
    # enable FileVault encryption (interactive)
    sudo fdesetup enable
    # show bluetooth in menu bar
    sudo defaults write ~/Library/Preferences/ByHost/com.apple.controlcenter.plist Bluetooth -int 18
    ```
