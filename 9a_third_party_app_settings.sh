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

# variables for backup drive and user
BACKUP_DRIVE="THE_BACKUP"
BACKUP_USER="philipreinhart"

# check if the backup volume is mounted
if [[ -e "/Volumes/${BACKUP_DRIVE}" ]]; then
  # find the latest backup path
  BACKUP_PATH="$(cd /Volumes/${BACKUP_DRIVE}/*.previous && pwd)"

  # check for the user's home folder in the backup
  if [[ -e "${BACKUP_PATH}/Macintosh HD - Daten/Users/${BACKUP_USER}" ]]; then
    BACKUP_HOME_FOLDER="${BACKUP_PATH}/Macintosh HD - Daten/Users/${BACKUP_USER}"
  elif [[ -e "${BACKUP_PATH}/Macintosh HD - Data/Users/${BACKUP_USER}" ]]; then
    BACKUP_HOME_FOLDER="${BACKUP_PATH}/Macintosh HD - Data/Users/${BACKUP_USER}"
  else
    echo "Backup home directory not found. Exiting..."
    exit 1
  fi
else
  echo "Backup volume not found. Exiting..."
  exit 1
fi

### alfred 5

echo "Setting up Alfred 5..."

osascript <<EOF
  try
    tell application "Alfred 5"
      run
      delay 3
      quit
    end tell
  end try		
EOF

cp -Rf "${BACKUP_HOME_FOLDER}/Library/Application Support/Alfred/Alfred.alfredpreferences" "${HOME}/Library/Application Support/Alfred/Alfred.alfredpreferences"

### money money

echo "Setting up Money Money..."

osascript <<EOF
  try
    tell application "MoneyMoney"
      run
      delay 3
      quit
    end tell
  end try		
EOF

cp -f "${BACKUP_HOME_FOLDER}/Library/Containers/com.moneymoney-app.retail/Data/Library/Application Support/MoneyMoney/Database/MoneyMoney.sqlite" "${HOME}/Library/Containers/com.moneymoney-app.retail/Data/Library/Application Support/MoneyMoney/Database/MoneyMoney.sqlite"
cp -f "${BACKUP_HOME_FOLDER}/Library/Containers/com.moneymoney-app.retail/Data/Library/Application Support/MoneyMoney/Database/MoneyMoney-Backup.sqlite" "${HOME}/Library/Containers/com.moneymoney-app.retail/Data/Library/Application Support/MoneyMoney/Database/MoneyMoney-Backup.sqlite"
