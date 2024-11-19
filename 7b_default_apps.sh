#!/bin/zsh

# function to prompt user to install duti
install_duti() {
  if [[ ! $(command -v duti) ]]; then
    read "response?duti is not yet installed. Do you want to install it using Homebrew? (y/n): "
    
    case "${response:l}" in  # convert response to lowercase
      y|yes)
        echo "Installing duti..."
        brew install duti
        ;;
      n|no)
        echo "duti not installed. Exiting..."
        return 1
        ;;
      *)
        echo "Invalid response. Please answer y/n or yes/no."
        install_duti  # recursive call to prompt again
        ;;
    esac
  else
    :
  fi
}

if install_duti; then
  echo "Setting default applications..."

  duti -s com.apple.Preview .pdf all
  duti -s com.coteditor.CotEditor .alias all
  duti -s com.coteditor.CotEditor .bash all
  duti -s com.coteditor.CotEditor .bash_profile all
  duti -s com.coteditor.CotEditor .bashrc all
  duti -s com.coteditor.CotEditor .cfg
  duti -s com.coteditor.CotEditor .conf
  duti -s com.coteditor.CotEditor .config
  duti -s com.coteditor.CotEditor .gitignore all
  duti -s com.coteditor.CotEditor .md all
  duti -s com.coteditor.CotEditor .py all
  duti -s com.coteditor.CotEditor .sh all
  duti -s com.coteditor.CotEditor .xml all
  duti -s com.coteditor.CotEditor .zshenv
  duti -s com.coteditor.CotEditor .zprofile all
  duti -s com.coteditor.CotEditor .zsh all
  duti -s com.coteditor.CotEditor .zshrc all
  duti -s com.microsoft.VSCode .css all
  duti -s com.microsoft.VSCode .js all
  duti -s com.microsoft.VSCode .json all
  duti -s com.microsoft.VSCode Brewfile all
  duti -s net.cecinestpasparis.yomu .epub all

  echo "Done."
else
  exit
fi