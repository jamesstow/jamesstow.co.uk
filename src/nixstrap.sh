#!/bin/bash

USERNAME="jim"
PROJECTDIR="projects"

useradd -m -G wheel -s /bin/zsh $USERNAME

su $USERNAME 

git clone https://github.com/jamesstow/dotfiles.git ~/.dotfiles

cd ~/.dotfiles

./init.sh


