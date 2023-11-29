#!/bin/zsh

echo "Setting dock items..."

# variables
PATH_TO_SYSTEM_APPS="/System/Applications"
PATH_TO_APPS="/System/Volumes/Data/Applications"
PATH_TO_PREBOOT_APPS="/System/Volumes/Preboot/Cryptexes/App/System/Applications/"

APP_HEAD="<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>"
APP_TAIL="</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
FOLDER_HEAD="<dict><key>tile-data</key><dict><key>arrangement</key><integer>0</integer><key>displayas</key><integer>1</integer><key>file-data</key><dict><key>_CFURLString</key><string>"

# functions
add_spacer() {
  if [[ ! "$1" =~ ^(persistent-apps|persistent-others)$ ]]; then
    echo "Wrong entry group. Skipping..."
    return
  else
    :
  fi
  defaults write com.apple.dock "$1" -array-add '{ tile-data = {}; tile-type = "spacer-tile"; }'
}

add_small_spacer() {
  if [[ ! "$1" =~ ^(persistent-apps|persistent-others)$ ]]; then
    echo "Wrong entry group. Skipping..."
    return
  else
    :
  fi
  defaults write com.apple.dock "$1" -array-add '{ "tile-data" = {}; "tile-type"="small-spacer-tile"; }'
}

add_app() {
  if [[ ! "$1" =~ ^(persistent-apps|persistent-others)$ ]]; then
    echo "Wrong entry group. Skipping..."
    return
  else
    :
  fi
  defaults write com.apple.dock "$1" -array-add "$APP_HEAD$PATH_TO_APPS/$2/$APP_TAIL"
}

add_system_app() {
  if [[ ! "$1" =~ ^(persistent-apps|persistent-others)$ ]]; then
    echo "Wrong entry group. Skipping..."
    return
  else
    :
  fi
  defaults write com.apple.dock "$1" -array-add "$APP_HEAD$PATH_TO_SYSTEM_APPS/$2/$APP_TAIL"
}

add_preboot_app() {
  if [[ ! "$1" =~ ^(persistent-apps|persistent-others)$ ]]; then
    echo "Wrong entry group. Skipping..."
    return
  else
    :
  fi
  defaults write com.apple.dock "$1" -array-add "$APP_HEAD$PATH_TO_PREBOOT_APPS/$2/$APP_TAIL"
}

add_folder() {
  if [[ ! "$1" =~ ^(persistent-apps|persistent-others)$ ]]; then
    echo "Wrong entry group. Skipping..."
    return
  else
    :
  fi
  if [[ -d $2 ]]; then
    FOLDER_PATH=$2
  else
    echo "Folder path does not exist. Skipping..."
    return
  fi

  # view as
  # Automatic = 1
  # Grid = 2
  # List = 3
  # Fan = 4
  if [[ $# -ge 3 ]]; then
    VIEWAS=$3
  else
    VIEWAS=1
  fi

  # preferred item size (only takes effect if viewas is set to grid)
  if [[ $# -ge 4 ]]; then
    PREFERRED_ITEM_SIZE=$4
  else
    PREFERRED_ITEM_SIZE=-1
  fi

  FOLDER_TAIL="</string><key>_CFURLStringType</key><integer>0</integer></dict><key>preferreditemsize</key><integer>"$PREFERRED_ITEM_SIZE"</integer><key>showas</key><integer>"$VIEWAS"</integer></dict><key>tile-type</key><string>directory-tile</string></dict>"
  defaults write com.apple.dock "$1" -array-add "$FOLDER_HEAD/$FOLDER_PATH/$FOLDER_TAIL"
}

# clear dock items
# clear persistent dock items
defaults write com.apple.dock 'persistent-apps' -array '' # left side
defaults write com.apple.dock 'persistent-others' -array '' # right side
# clear recent dock items
# hiding the recents section is a system setting which is set in 6a_system_settings.sh
# defaults write com.apple.dock show-recents -bool false
# defaults write com.apple.dock 'recent-apps' -array ''

# left dock side
add_system_app persistent-apps Mail.app
add_system_app persistent-apps Calendar.app
add_app persistent-apps Things3.app
add_app persistent-apps Bear.app
add_app persistent-apps 1Password.app
add_preboot_app persistent-apps Safari.app
add_app persistent-apps Firefox.app
add_system_app persistent-apps Photos.app
add_app persistent-apps Spotify.app
add_system_app persistent-apps Preview.app
add_system_app persistent-apps Utilities/Terminal.app
add_app persistent-apps "Visual Studio Code.app"
add_system_app persistent-apps "System Settings.app"
add_system_app persistent-apps "App Store.app"
add_system_app persistent-apps Launchpad.app

# right dock side
add_folder persistent-others "$HOME"/Downloads 2 1

# apply changes
killall Dock