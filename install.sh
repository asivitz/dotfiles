#!/bin/bash

# Specify the preferences directory
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/dotfiles/iterm2_profile"
# Tell iTerm2 to use the custom preferences in the directory
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

cd
ln -s ./dotfiles/.zshrc ./
ln -s ./dotfiles/.config ./
ln -s ./dotfiles/.tmux.conf ./
ln -s ./dotfiles/.haskeline ./
ln -s ./dotfiles/.agignore ./

brew install terminal-notifier
