#!/usr/bin/env bash
# Screensaver / aerial assets — disable to prevent idleassetsd
# from downloading 100s of GB of 4K video to /private/var/folders

defaults -currentHost write com.apple.screensaver idleTime -int 0
defaults write com.apple.wallpaper rotatingAssets -bool false
defaults write com.apple.idleassetsd Customer -dict-add downloadOnLaunch 0
