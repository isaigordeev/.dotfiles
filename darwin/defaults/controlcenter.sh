#!/usr/bin/env bash
# Control Center menu-bar visibility

defaults write com.apple.controlcenter "NSStatusItem Visible AudioVideoModule" -bool false
defaults write com.apple.controlcenter "NSStatusItem Visible ScreenMirroring" -bool false
