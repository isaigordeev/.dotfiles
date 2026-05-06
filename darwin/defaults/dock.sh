#!/usr/bin/env bash
# Dock

defaults write com.apple.dock orientation -string "left"
defaults write com.apple.dock tilesize -int 60
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock showAppExposeGestureEnabled -bool true

# Hot corners
# corner values: 1=disabled, 2=Mission Control, 3=App windows, 4=Desktop,
# 5=Start screen saver, 6=Disable screen saver, 10=Display sleep,
# 11=Launchpad, 12=Notification Center, 13=Lock Screen, 14=Quick Note
# modifier: 0=none, 131072=Shift, 262144=Ctrl, 524288=Option, 1048576=Cmd
defaults write com.apple.dock wvous-bl-corner -int 13
defaults write com.apple.dock wvous-bl-modifier -int 1048576
defaults write com.apple.dock wvous-br-corner -int 4
defaults write com.apple.dock wvous-br-modifier -int 1048576
