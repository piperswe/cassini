#!/bin/bash

export HOME="${DIR:=${HOME}}"
echo "Cloning Git repo..."
mkdir -p "${DIR}"
cd "${DIR}"
git init
git remote add origin https://github.com/piperswe/cassini.git
git pull --set-upstream origin master
echo "  Generating SSH key..."
mkdir .ssh
ssh-keygen -t ed25519 -N "" -f .ssh/id_ed25519 -C "cassini.piperswe.me"
echo "    Add the following SSH key to GitHub before proceeding:"
cat .ssh/id_ed25519.pub
read
echo "  Adding SSH remote..."
git remote remove origin
git remote add origin git@github.com:piperswe/cassini.git
git pull
echo "  Downloading submodules..."
git submodule init
git submodule update
echo "Configuring Homebrew..."
echo "  Tapping Homebrew/bundle..."
brew tap Homebrew/bundle
echo "  Installing mas..."
brew install mas
echo "  Restoring Brewfile..."
brew bundle
echo "Configuring zsh..."
echo "  Downloading Antigen dependencies..."
zsh .zshrc
echo "  Changing shell..."
echo "    Enter your password to change your shell:"
chsh -s /bin/zsh
