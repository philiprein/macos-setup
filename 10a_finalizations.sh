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

# migrate internet accounts
echo "Migrating Internet Accounts..."
/System/Library/InternetAccounts/internetAccountsMigrator