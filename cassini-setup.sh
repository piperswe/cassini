#!/bin/bash

export HOME="${DIR:=${HOME}}"
mkdir -p "${DIR}"
cd "${DIR}"
git init
git remote add origin https://github.com/piperswe/cassini.git
git pull origin master
mkdir .ssh
ssh-keygen -t ed25519 -N "" -f .ssh/id_ed25519 -C "cassini.piperswe.me"
echo "Add the following SSH key to GitHub before proceeding:"
cat .ssh/id_ed25519.pub
read
git remote remove origin
git remote add origin git@github.com:piperswe/cassini.git
git submodule init
git submodule update
echo "Enter your password to change your shell:"
chsh -s /bin/zsh
