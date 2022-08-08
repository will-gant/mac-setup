#!/usr/bin/env bash

set -eo pipefail

script_dir="$( cd -- "$( dirname -- "${BASH_SOURCE[0]:-$0}"; )" &> /dev/null && pwd 2> /dev/null; )";

brew bundle --file="${script_dir}/Brewfile"

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
    "$(dock_item /Applications/LibreOffice.app)" \
    "$(dock_item /Applications/Notion.app)"

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
