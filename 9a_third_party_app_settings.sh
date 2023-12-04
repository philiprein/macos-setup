#!/bin/zsh

###
### mackup apps (appcleaner, coteditor, homebrew, iterm2, littlesnitch, logitech-options, mackup, magnet, marked2, spotify, vscode, whatsapp)
###

echo "Setting up mackup apps..."

install_mackup() {
  if [[ ! $(command -v mackup) ]]; then
    read "response?mackup is not yet installed. Do you want to install it using Homebrew? (y/n): "

    case "${response:l}" in # convert response to lowercase
    y | yes)
      echo "Installing mackup..."
      brew install mackup
      ;;
    n | no)
      echo "mackup not installed. Skipping..."
      return 1
      ;;
    *)
      echo "Invalid response. Please answer y/n or yes/no."
      install_mackup # recursive call to prompt again
      ;;
    esac
  else
    :
  fi
}

if install_mackup; then
  # run mackup restore
  mackup restore

  # run mackup uninstall to copy actual files
  mackup uninstall
else
  :
fi

###
### others
###
