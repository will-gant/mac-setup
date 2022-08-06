#!/usr/bin/env bash

set -eo pipefail

script_dir="$( cd -- "$( dirname -- "${BASH_SOURCE[0]:-$0}"; )" &> /dev/null && pwd 2> /dev/null; )";

# commandline developer tools
touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress;
xcode_version="$(softwareupdate --list | grep -E --only-matching "Command Line Tools for Xcode-[0-9]+\.[0-9]+" | tail -n 1)"
softwareupdate --install "$xcode_version" --verbose
rm /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress

# brew
mkdir "${script_dir}/homebrew" && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C "${script_dir}/homebrew"
eval "$(homebrew/bin/brew shellenv | tee "${HOME}/.zshrc")"
brew update --force --quiet
chmod -R go-w "$(brew --prefix)/share/zsh"

brew bundle --file="${script_dir}/Brewfile"
mkdir -p "${HOME}/Library/LaunchAgents"
brew autoupdate start 43200

# git
cp "${script_dir}/gitconfig" "${HOME}/.gitconfig"

# dock
dock_item() {
    printf '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>%s</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>', "$1"
}

defaults write com.apple.dock persistent-apps -array \
    "$(dock_item /Applications/iTerm.app)" \
    "$(dock_item /Applications/Visual\ Studio\ Code.app)" \
    "$(dock_item /Applications/zoom.us.app)" \
    "$(dock_item /Applications/Slack.app)" \
    "$(dock_item /Applications/Brave\ Browser.app)" \
    "$(dock_item /Applications/Authy\ Desktop.app)" \
    "$(dock_item /Applications/1Password\ 7.app)" \
    "$(dock_item /Applications/LibreOffice.app)"

defaults delete com.apple.dock recent-apps
defaults delete com.apple.dock persistent-others
killall Dock

# SSH key
ssh_dir="${HOME}/.ssh"
mkdir -p "${ssh_dir}"
touch "${ssh_dir}/id_rsa"
chmod 400 "${ssh_dir}/id_rsa"

cat <<EOF > "${HOME}/.ssh/config"
Host *
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_rsa
EOF

mkdir -p "${HOME}/Workspace"