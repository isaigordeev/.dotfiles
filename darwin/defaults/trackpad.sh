#!/usr/bin/env bash
# Trackpad (built-in + bluetooth)

defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true

defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool false
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool false

defaults write com.apple.AppleMultitouchTrackpad UserPreferences -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad UserPreferences -bool true
