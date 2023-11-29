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


# https://mac.install.guide/commandlinetools/2.html
check_if_command_line_tools_are_installed() {
  if xcode-select --print-path &>/dev/null && ; then
    if [[ -d "$(xcode-select --print-path)" ]] && [[ "$(ls -Al "$(xcode-select --print-path)" | wc -l)" -ge 4 ]]; then
      # installed
      return 0
    else
      # command line tools directory doesn't exist or installation is not complete
      sudo rm -rf "$(xcode-select --print-path)"
      return 1
    fi
  else
    # not installed
    return 1
  fi
}

install_command_line_tools() {
  if ! check_if_command_line_tools_are_installed; then
    # not installed
    echo "Installing Xcode Command Line Tools. Expect a GUI popup..."

    # prompt user to install xcode command line tools
    xcode-select --install

    # wait for installation to complete
    while ps aux | grep 'Install Command Line Developer Tools.app' | grep -v grep > /dev/null; do sleep 1; done

    # choosing command line tools as default
    sudo xcode-select --switch /Library/Developer/CommandLineTools
  else
    # installed
    echo "Xcode Command Line Tools are already installed. Skipping install..."
  fi
}

install_command_line_tools