#!/usr/bin/env bash
# Installs OMERO requirements

# Install Homebrew in /usr/local
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Update Homebrew
brew update

# Run brew doctor
brew doctor
