#!/usr/bin/env bash

set -eo pipefail

script_dir="$( cd -- "$( dirname -- "${BASH_SOURCE[0]:-$0}"; )" &> /dev/null && pwd 2> /dev/null; )";

brew bundle --file="${script_dir}/Brewfile"

# git
cp "${script_dir}/gitconfig" "${HOME}/.gitconfig"

# dock
dock_item() {
    printf '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/%s</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>', "$1"
}

defaults write com.apple.dock persistent-apps -array \
    "$(dock_item iTerm.app)" \
    "$(dock_item Visual\ Studio\ Code.app)" \
    "$(dock_item Slack.app)" \
    "$(dock_item Brave\ Browser.app)" \
    "$(dock_item Warp.app)" \
    "$(dock_item Spotify.app)" \
    "$(dock_item Microsoft\ Teams.app)"

defaults delete com.apple.dock recent-apps
defaults delete com.apple.dock persistent-others
killall Dock

# Make it so you can quit Finder just like any other app
defaults write com.apple.finder QuitMenuItem -bool YES && killall Finder


# disable animations/effects
defaults write -g NSScrollViewRubberbanding -int 0
defaults write -g NSAutomaticWindowAnimationsEnabled -bool false
defaults write -g NSScrollAnimationEnabled -bool false
defaults write -g NSWindowResizeTime -float 0.001
defaults write -g QLPanelAnimationDuration -float 0
defaults write -g NSScrollViewRubberbanding -bool false
defaults write -g NSDocumentRevisionsWindowTransformAnimation -bool false
defaults write -g NSToolbarFullScreenAnimationDuration -float 0
defaults write -g NSBrowserColumnAnimationSpeedMultiplier -float 0
defaults write com.apple.dock autohide-time-modifier -float 0
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock expose-animation-duration -float 0
defaults write com.apple.dock springboard-show-duration -float 0
defaults write com.apple.dock springboard-hide-duration -float 0
defaults write com.apple.dock springboard-page-duration -float 0
defaults write com.apple.finder DisableAllAnimations -bool true
defaults write com.apple.Mail DisableSendAnimations -bool true
defaults write com.apple.Mail DisableReplyAnimations -bool true
defaults write NSGlobalDomain NSWindowResizeTime .001
defaults write com.apple.dock expose-animation-duration -int 0; killall Dock
defaults write com.apple.dock expose-animation-duration -float 0.1; killall Dock

# Screenshots
screenshots_dir="${HOME}/Screenshots"
mkdir -p "$screenshots_dir"
defaults write com.apple.screencapture location "$screenshots_dir"

# SSH key
ssh_dir="${HOME}/.ssh"
mkdir -p "${ssh_dir}"
touch "${ssh_dir}/id_rsa"
chmod 400 "${ssh_dir}/id_rsa"

cat <<EOF > "${HOME}/.ssh/config"
Host *
  AddKeysToAgent yes
  IdentityFile ~/.ssh/id_rsa
EOF

mkdir -p "${HOME}/Workspace"
