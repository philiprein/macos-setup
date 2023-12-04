#!/bin/zsh

# install rosetta on arm macs
if [[ $(uname -m | grep arm) != "" ]]; then
  # arm mac
  if ! pgrep oahd &>/dev/null; then
    # not installed
    echo "Rosetta is not yet installed. Installing..."
    softwareupdate --install-rosetta --agree-to-license
  else
    # installed
    echo "Rosetta is already installed. Skipping install..."
  fi
else
  # intel mac
  echo "Intel Mac doesn't require Rosetta. Skipping install..."
fi
