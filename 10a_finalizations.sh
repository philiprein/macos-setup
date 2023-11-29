#!/bin/zsh

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

# copy documents folder
# check if the source folder exists
if [[ -e "${BACKUP_HOME_FOLDER}/Documents" ]]; then
  echo "Copying Documents from backup..."
  # copy the documents folder from the backup to the home folder
  #cp -R "${BACKUP_HOME_FOLDER}/Documents" "${HOME}/Documents"
  echo "Copying Projects from backup..."
  cp -R "${BACKUP_HOME_FOLDER}/Documents/Projects" "${HOME}/Documents/Projects"
  echo "Copying Areas from backup..."
  cp -R "${BACKUP_HOME_FOLDER}/Documents/Areas" "${HOME}/Documents/Areas"
  echo "Copying Resources from backup..."
  cp -R "${BACKUP_HOME_FOLDER}/Documents/Resources" "${HOME}/Documents/Resources"
  echo "Copying Archive from backup..."
  cp -R "${BACKUP_HOME_FOLDER}/Documents/Archive" "${HOME}/Documents/Archive"
else
  echo "Backup Documents folder not found."
fi

# migrate mail rules
echo "Migrating Mail rules..."
osascript -e 'tell application "Mail" to quit'

# determine mail data version
MAIL_DATA_PATH="$BACKUP_HOME_FOLDER"/Library/Mail

if [[ -d $MAIL_DATA_PATH ]]; then
  highest_version=0
  highest_version_folder=""

  for folder in "$MAIL_DATA_PATH"/V*; do
    if [[ -d $folder ]]; then
      # extract the numeric part of the folder name
      version_number=$(echo $folder | grep -o 'V[0-9]*$' | tr -d 'V')

      # check if this version number is greater than the highest found so far
      if (( version_number > highest_version )); then
        highest_version=$version_number
        highest_version_folder=$folder
      fi
    fi
  done
  # check if the rule files exist
  MAIL_DATA_FOLDER=$(cd "$BACKUP_HOME_FOLDER"/Library/Mail/V$highest_version/MailData && pwd)

  if [[ -e $MAIL_DATA_FOLDER ]] && [[ -e ""$HOME"/Library/Mail/V$highest_version/MailData" ]]; then
    cp "$MAIL_DATA_FOLDER"/RulesActiveState.plist "$HOME"/Library/Mail/V$highest_version/MailData/RulesActiveState.plist
    cp "$MAIL_DATA_FOLDER"/SyncedRules.plist "$HOME"/Library/Mail/V$highest_version/MailData/SyncedRules.plist
    cp "$MAIL_DATA_FOLDER"/UnsyncedRules.plist "$HOME"/Library/Mail/V$highest_version/MailData/UnsyncedRules.plist
  else
    echo "Mail data folder could not be found on target. Skipping..."
  fi
else
  echo "Mail data path could not be found in backup. Skipping..."
fi
