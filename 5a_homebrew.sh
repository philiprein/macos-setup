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


install_homebrew() {
  # check if homebrew is already installed
  if ! command -v brew &> /dev/null; then
    # not installed
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    if [[ $(uname -m | grep arm) != "" ]]; then
      # make homebrew shell environment available on zsh and bash shells
      echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' | tee -a $HOME/.zprofile >> $HOME/.bash_profile
      eval "$(/opt/homebrew/bin/brew shellenv)"
    else
      :
    fi

    # turn off analytics
    brew analytics off
  else
    # installed
    echo "Homebrew is already installed. Skipping install..."
  fi

  # update homebrew
  echo "Updating Homebrew..."
  brew update && brew upgrade

  # cleanup
  echo "Cleaning up Homebrew..."
  brew cleanup --prune=all 1> /dev/null

  # check if everything works as expected
  brew doctor
}

install_homebrew