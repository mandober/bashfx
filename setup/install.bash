#!/bin/bash

# DESC: Dotfiles for POSIX environments
# REPO: https://github.com/mandober/dotfiles
# EDIT: 2017-09-23

## part 1: clone git repo

# check git
if ! which git && { echo "git is not installed"; exit 2 }

# dotfiles repo folder (to be read-only and git fetch updating)
export dotRepo="$HOME/dotfiles"

# clone
git clone https://github.com/mandober/dotfiles "$dotRepo"


## part 2: setup dotfiles work folder

# dotfiles work folder (for linking and changing)
export dotWork="$HOME/dots"

# copy to work folder
cp -ur "$dotRepo" "$dotWork"

# delete .git from work folder
rm -rf "$dotWork/.git"

# add work folder to path
export PATH+=":$dotWork"
