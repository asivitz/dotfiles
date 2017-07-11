#!/bin/bash

# Specify the preferences directory
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/dotfiles/iterm2_profile"
# Tell iTerm2 to use the custom preferences in the directory
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

cd

install_link () {
    if [ -f "./$1" ]
    then
        echo "error: dot file already exists: $1"
        exit 1
    else
        ln -s "./dotfiles/$1" ./
    fi
}

install_link .zshrc
install_link .config
install_link .tmux.conf
install_link .haskeline
install_link .agignore

brew install terminal-notifier
