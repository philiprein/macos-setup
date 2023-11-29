#!/bin/zsh

# see https://github.com/arkenfox/user.js/wiki/2.1-User.js for details

# quit firefox
osascript -e 'tell application "Firefox" to quit'

# profile path
FIREFOX_PROFILE_PATH=$(find "${HOME}/Library/Application Support/Firefox" -name "*.default-release*")

if [[ ! -e $FIREFOX_PROFILE_PATH ]]; then
  echo "Firefox profile wasn't found. Exiting..."
  exit
else
  :
fi

# download user.js
if [[ ! -e "${FIREFOX_PROFILE_PATH}/user.js" ]]; then
  echo "Downloading user.js..."
  curl --silent https://raw.githubusercontent.com/arkenfox/user.js/master/user.js >"$FIREFOX_PROFILE_PATH"/user.js
  chown "$USER":staff "$FIREFOX_PROFILE_PATH"/user.js
  chmod 644 "$FIREFOX_PROFILE_PATH"/user.js
else
  :
fi

# download prefsCleaner.sh
if [[ ! -e "${FIREFOX_PROFILE_PATH}/prefsCleaner.sh" ]]; then
  echo "Downloading prefsCleaner.sh..."
  curl --silent https://raw.githubusercontent.com/arkenfox/user.js/master/prefsCleaner.sh >"$FIREFOX_PROFILE_PATH"/prefsCleaner.sh
  chown "$USER":staff "$FIREFOX_PROFILE_PATH"/prefsCleaner.sh
  chmod 644 "$FIREFOX_PROFILE_PATH"/prefsCleaner.sh
else
  :
fi

# download updater.sh
if [[ ! -e "${FIREFOX_PROFILE_PATH}/updater.sh" ]]; then
  echo "Downloading updater.sh..."
  curl --silent https://github.com/arkenfox/user.js/blob/master/updater.sh >"$FIREFOX_PROFILE_PATH"/updater.sh
  chown "$USER":staff "$FIREFOX_PROFILE_PATH"/updater.sh
  chmod 644 "$FIREFOX_PROFILE_PATH"/updater.sh
else
  :
fi

# copy user-overrides.js
if [[ ! -e "${FIREFOX_PROFILE_PATH}/user-overrides.js" ]]; then
  echo "Copying user-overrides.sh..."
  cp "$(dirname "${0:A}")/etc/user-overrides.js" "$FIREFOX_PROFILE_PATH"/user-overrides.js
else
  :
fi

"$FIREFOX_PROFILE_PATH"/updater.sh
"$FIREFOX_PROFILE_PATH"/prefsCleaner.sh