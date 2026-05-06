#!/usr/bin/env bash
# Finder

defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write com.apple.finder ShowPathbar -bool true
# View style: Nlsv=list, icnv=icon, clmv=column, Flwv=gallery
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"
# New window target: PfAF=All My Files, PfDe=Desktop, PfDo=Documents, PfHm=Home
defaults write com.apple.finder NewWindowTarget -string "PfAF"
