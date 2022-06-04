1. Run setup.sh
1. Retrieve SSH private key from password manager
1. Copy into ~/.ssh/id_rsa
1. Run `eval "$(ssh-agent -s)`
1. Run `ssh-add --apple-use-keychain ~/.ssh/id_rsa`