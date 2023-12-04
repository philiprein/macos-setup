#!/bin/zsh

# prompt for sudo password at the beginning of the script
if sudo -v; then
  while true; do
    # keep-alive for sudo
    sudo -n true
    sleep 60
    kill -0 "$$" || exit
  done 2>/dev/null &
fi

# disable gatekeeper for casks installed by homebrew
export HOMEBREW_CASK_OPTS="--no-quarantine"

# check if homebrew is installed
if command -v brew &>/dev/null; then
  echo "Installing Homebrew Formulae, Casks and Mac App Store apps..."
  brew bundle --file="$(dirname "${0:A}")/etc/Brewfile" --verbose

  echo "Cleaning up Homebrew..."
  brew cleanup --prune=all &>/dev/null
else
  echo "Homebrew not installed. Install using 5a_homebrew.sh."
  exit 1
fi
