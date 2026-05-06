#!/usr/bin/env bash
# macOS defaults — applied via bootstrap

# Dock
defaults write com.apple.dock orientation -string "left"
defaults write com.apple.dock tilesize -int 60
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock show-recents -bool false

killall Dock 2>/dev/null || true
