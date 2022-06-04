# Mac setup

Run `./setup.sh`

## Manual steps:

These should be run _after_ running the setup script.

### Git

1. Retrieve SSH private key from password manager
1. Copy into ~/.ssh/id_rsa
1. Run `eval "$(ssh-agent -s)`
1. Run `ssh-add --apple-use-keychain ~/.ssh/id_rsa`