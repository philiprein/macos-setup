#!/bin/zsh

# check compatibility
MACOS_VERSION_MAJOR=$(sw_vers -productVersion | cut -f1 -d'.')

if [[ "$MACOS_VERSION_MAJOR" != "13" ]] && [[ "$MACOS_VERSION_MAJOR" != "14" ]]; then
  echo "This script is only compatible with macOS 13 or higher, exiting..."
  exit
else
  :
fi

# close system settings to prevent it from overriding settings we’re about to change
osascript -e 'tell application "System Settings" to quit'

# prompt for sudo password at the beginning of the script
if sudo -v; then
  while true; do 
    # keep-alive for sudo
    sudo -n true
    sleep 60
    kill -0 "$$" || exit
  done 2>/dev/null &
fi

###
### wi-fi
###

echo "Wi-Fi settings..."


###
### bluetooth
###

echo "Bluetooth settings..."


###
### network
###

echo "Network settings..."

# firewall (default: off)
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on &>/dev/null


###
### notifications
###

echo "Notifications settings..."


###
### sound
###

echo "Sound settings..."

# alert sound (default: /System/Library/Sounds/Tink.aiff)
# select an alert sound and check name with 
# defaults read NSGlobalDomain com.apple.sound.beep.sound
defaults write NSGlobalDomain com.apple.sound.beep.sound -string "/System/Library/Sounds/Bottle.aiff"

# play sound on startup (default: on)
# on = %00
# off = %01
sudo nvram StartupMute=%01

# play feedback when volume is changed (default: off)
# on = 1
# off = 0
defaults write NSGlobalDomain com.apple.sound.beep.feedback -int 1


###
### focus
###

echo "Focus settings..."


###
### screen time
###

echo "Screen Time settings..."


###
### general
###

echo "General settings..."

### about


### software update

# install application updates from the App Store automatically (default: off)
sudo defaults write /Library/Preferences/com.apple.commerce AutoUpdate -bool true


### storage


### airdrop & handoff

# airdrop (default: "Off")
# no one = "Off"
# contacts only = "Contacts Only"
# everyone = "Everyone"
defaults write com.apple.sharingd DiscoverableMode -string "Contacts Only"


### login items


### coverage


### language & region

# preferred languages & region (default: set in setup assistant)
defaults write NSGlobalDomain AppleLanguages -array "en-DE" "de-DE"
defaults write NSGlobalDomain AppleLocale -string "en_DE@currency=EUR"


### date & time


### sharing


### time machine


### transfer or reset


### startup disk


###
### appearance
###

echo "Appearance settings..."

# appearance (default: set in setup assistant or light) (needs logout)
# check: defaults read NSGlobalDomain | grep AppleInterfaceStyle
# light
# defaults delete NSGlobalDomain AppleInterfaceStyle 2>/dev/null
# defaults write NSGlobalDomain AppleInterfaceStyleSwitchesAutomatically -bool false
# dark
# defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"
# defaults write NSGlobalDomain AppleInterfaceStyleSwitchesAutomatically -bool false
# automatic
defaults delete NSGlobalDomain AppleInterfaceStyle 2>/dev/null
defaults write NSGlobalDomain AppleInterfaceStyleSwitchesAutomatically -bool true

# accent color (default: multicolor)
# red = 0
# orange = 1
# yellow = 2
# green = 3
# blue = 4
# violet = 5
# pink = 6
# graphit = -1
# multicolor = defaults delete NSGlobalDomain AppleAccentColor
defaults write NSGlobalDomain AppleAccentColor -int 4

# click in the scroll bar to (default: false)
# jump to the next page = false
# jump to the spot that's clicked = true
defaults write NSGlobalDomain AppleScrollerPagingBehavior -bool true


###
### accessibility
###

echo "Accessibility settings..."

### voiceover


### zoom


### display


### spoken content


### descriptions


### audio


### rtt


### captions


### voice control


### keyboard


### pointer control

# spring-loading speed (default: 0.5)
defaults write NSGlobalDomain com.apple.springing.delay -float 0.3


### switch control


### siri


### shortcut


###
### control center
###

echo "Control Center settings..."

# wifi (default: show in menu bar)
# show in menu bar = 2, true
# don't show in menu bar = 8, false
defaults -currentHost write com.apple.controlcenter WiFi -int 8
defaults write com.apple.controlcenter "NSStatusItem Visible WiFi" -bool false

# display (default: show when active)
# always show in menu bar = 18, true
# show when active = 2
# don't show in menu bar = 8, false
defaults -currentHost write com.apple.controlcenter Display -int 8
defaults write com.apple.controlcenter "NSStatusItem Visible Display" -bool false

# sound (default: show when active)
# always show in menu bar = 18, true
# show when active = 2
# don't show in menu bar = 8, false
defaults -currentHost write com.apple.controlcenter Sound -int 8
defaults write com.apple.controlcenter "NSStatusItem Visible Sound" -bool false

# now playing (default: show when active)
# always show in menu bar = 18, true
# show when active = 2
# don't show in menu bar = 8, false
defaults -currentHost write com.apple.controlcenter NowPlaying -int 8
defaults write com.apple.controlcenter "NSStatusItem Visible NowPlaying" -bool false

# battery (default: show in menu bar & don't show in control center)
defaults -currentHost write com.apple.controlcenter Battery -int 12
defaults write com.apple.controlcenter "NSStatusItem Visible Battery" -bool false
# show percentage (default: off)
defaults -currentHost write com.apple.controlcenter BatteryShowPercentage -bool true

# spotlight (default: show in menu bar)
defaults -currentHost write com.apple.Spotlight MenuItemHidden -bool true

# time machine (default: don't show in menu bar) & vpn (default: don't show in menu bar)
# first delete all entries from the menuExtras array
defaults delete com.apple.systemuiserver.plist menuExtras 2>/dev/null
# delete visibility status
defaults delete com.apple.systemuiserver "NSStatusItem Visible com.apple.menuextra.TimeMachine" 2>/dev/null
defaults delete com.apple.systemuiserver "NSStatusItem Visible com.apple.menuextra.vpn" 2>/dev/null
# add the entries you wish to see
defaults write com.apple.systemuiserver.plist menuExtras -array-add "/System/Library/CoreServices/Menu Extras/TimeMachine.menu"
# defaults write com.apple.systemuiserver.plist menuExtras -array-add "/System/Library/CoreServices/Menu Extras/VPN.menu"


###
### siri & spotlight
###

echo "Siri & Spotlight settings..."

# siri suggestions & privacy (default: all enabled)
# to disable "show siri suggestions for x", add the app's bundle identifier to the AppCanShowSiriSuggestionsBlacklist array
defaults delete com.apple.suggestions AppCanShowSiriSuggestionsBlacklist 2>/dev/null
defaults write com.apple.suggestions AppCanShowSiriSuggestionsBlacklist -array-add \
  "com.apple.AddressBook" \
  "com.apple.FaceTime" \
  "com.apple.iBooksX" \
  "com.apple.iCal" \
  "com.apple.mail" \
  "com.apple.Maps" \
  "com.apple.MobileSMS" \
  "com.apple.news" \
  "com.apple.podcasts" \
  "com.apple.reminders" \
  "com.apple.Safari"

# to disable "learn from this application", add the app's bundle identifier to the SiriCanLearnFromAppBlacklist array
defaults delete com.apple.suggestions SiriCanLearnFromAppBlacklist
defaults write com.apple.suggestions SiriCanLearnFromAppBlacklist -array-add \
  "com.apple.AddressBook" \
  "com.apple.AppStore" \
  "com.apple.clock" \
  "com.apple.FaceTime" \
  "com.apple.freeform" \
  "com.apple.helpviewer" \
  "com.apple.iBooksX" \
  "com.apple.iCal" \
  "com.apple.mail" \
  "com.apple.Maps" \
  "com.apple.MobileSMS" \
  "com.apple.news" \
  "com.apple.Notes" \
  "com.apple.Photos" \
  "com.apple.podcasts" \
  "com.apple.reminders" \
  "com.apple.Safari" \
  "com.apple.shortcuts" \
  "com.apple.stocks" \
  "com.apple.systempreferences" \
  "com.apple.tips" \
  "net.shinyfrog.bear"

# make changes take effect
defaults read com.apple.suggestions.plist &>/dev/null

# search results (default: all enabled)
defaults delete com.apple.Spotlight orderedItems 2>/dev/null

/usr/libexec/PlistBuddy -c 'Add :orderedItems array' ~/Library/Preferences/com.apple.Spotlight.plist

enable_disable_search_result_category () {
  /usr/libexec/PlistBuddy -c 'Add :orderedItems:'$1':enabled bool '$3'' ~/Library/Preferences/com.apple.Spotlight.plist
  /usr/libexec/PlistBuddy -c 'Add :orderedItems:'$1':name string '$2'' ~/Library/Preferences/com.apple.Spotlight.plist
}

spotlightconfig=(
"0      APPLICATIONS                    true"
"1      MENU_EXPRESSION                 true"
"2      CONTACT                         true"
"3      MENU_CONVERSION                 true"
"4      MENU_DEFINITION                 true"
"5      DOCUMENTS                       true"
"6      EVENT_TODO                      true"
"7      DIRECTORIES                     true"
"8      FONTS                           true"
"9      IMAGES                          true"
"10     MESSAGES                        true"
"11     MOVIES                          true"
"12     MUSIC                           true"
"13     MENU_OTHER                      true"
"14     PDF                             true"
"15     PRESENTATIONS                   true"
"16     MENU_SPOTLIGHT_SUGGESTIONS      false"
"17     SPREADSHEETS                    true"
"18     SYSTEM_PREFS                    true"
"19     TIPS                            true"
"20     BOOKMARKS                       true"
)

for entry in "${spotlightconfig[@]}"; do
  ITEMNR=$(echo $entry | awk '{print $1}')
  SPOTLIGHTENTRY=$(echo $entry | awk '{print $2}')
  ENABLED=$(echo $entry | awk '{print $3}')
  enable_disable_search_result_category $ITEMNR $SPOTLIGHTENTRY $ENABLED
done

# makes changes take effect
defaults read com.apple.Spotlight orderedItems &>/dev/null


###
### privacy & security
###

echo "Privacy & Security settings..."

# share mac analytics (default: set in setup assistant)
defaults write "/Library/Application Support/CrashReporter/DiagnosticMessagesHistory.plist" AutoSubmit -bool false
defaults write "/Library/Application Support/CrashReporter/DiagnosticMessagesHistory.plist" SeedAutoSubmit -bool false
defaults write "/Library/Application Support/CrashReporter/DiagnosticMessagesHistory.plist" AutoSubmitVersion -integer 4

# improve siri & dictation (default: set in setup assistant)
defaults write com.apple.assistant.support "Siri Data Sharing Opt-In Status" -integer 2

# share with app developers (default: set in setup assistant)
defaults write "/Library/Application Support/CrashReporter/DiagnosticMessagesHistory.plist" ThirdPartyDataSubmit -bool false
defaults write "/Library/Application Support/CrashReporter/DiagnosticMessagesHistory.plist" ThirdPartyDataSubmitVersion -integer 4

# personalized ads
defaults write com.apple.AdLib allowApplePersonalizedAdvertising -bool false


###
### desktop & dock
###

echo "Desktop & Dock settings..."

# size (default: 64)
defaults write com.apple.dock tilesize -int 42

# magnification (default: off)
defaults write com.apple.dock magnification -bool true
defaults write com.apple.dock largesize -int 80

# minimize windows using (default: genie effect)
# genie effect = genie
# sacle effect = scale
defaults write com.apple.dock mineffect -string "scale"

# automatically hide and show the dock (default: off)
defaults write com.apple.dock autohide -bool true


### hidden dock tweaks

# highlight hover effect for the grid view of a stack (default: off)
defaults write com.apple.dock mouse-over-hilite-stack -bool true

# dock icons of hidden (⌘ + H) applications are translucent (default: off)
defaults write com.apple.dock showhidden -bool true

# auto-hiding dock delay
defaults write com.apple.dock autohide-delay -float 0

# animation when hiding/showing the dock
defaults write com.apple.dock autohide-time-modifier -float 0

# scroll up on dock icon to show all space's opened windows for an app, or open stack
defaults write com.apple.dock scroll-to-open -bool true


### desktop & stage manager

# click wallpaper to reveal desktop (default: always)
# always = true
# only in stage manager = false
defaults write com.apple.WindowManager EnableStandardClickToShowDesktop -bool false


### widgets

# use iphone widgets (default: on)
defaults write com.apple.chronod remoteWidgetsEnabled -bool false
defaults write com.apple.chronod effectiveRemoteWidgetsEnabled -bool false


### windows

# ask to keep changes when closing documents (default: off)
defaults write NSGlobalDomain NSCloseAlwaysConfirmsChanges -bool true

# close windows when quitting an application (default: on)
defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -bool false


### mission control

# automatically rearrange spaces based on most recent use (default: on)
defaults write com.apple.dock mru-spaces -bool false

# when switching to an application, switch to a space with open windows for the application (default: off)
defaults write NSGlobalDomain AppleSpacesSwitchOnActivate -bool true

# group windows by application (default: off)
defaults write com.apple.dock expose-group-apps -bool true


### shortcuts


### hot corners

# off = 1
# mission control = 2
# application windows = 3
# desktop = 4
# screen saver on = 5
# screen saver off = 6
# display sleep = 10
# launchpad = 11
# notification center = 12
# lock screen = 13
# quick note = 14

# no modifier = 0
# shift = 131072
# control = 262144
# option = 524288
# command = 1048576

# top left screen corner (default: off)
defaults write com.apple.dock wvous-tl-corner -int 10
defaults write com.apple.dock wvous-tl-modifier -int 1048576

# top right screen corner (default: off)
defaults write com.apple.dock wvous-tr-corner -int 1
defaults write com.apple.dock wvous-tr-modifier -int 0

# bottom left screen corner (default: off)
defaults write com.apple.dock wvous-bl-corner -int 1
defaults write com.apple.dock wvous-bl-modifier -int 0

# bottom right screen corner (default: quick note)
defaults write com.apple.dock wvous-br-corner -int 4
defaults write com.apple.dock wvous-br-modifier -int 1048576


###
### displays
###

echo "Displays settings..."


###
### wallpaper
###

echo "Wallpaper settings..."



###
### screen saver
###

echo "Screen Saver settings..."



###
### battery
###

echo "Battery settings..."

# optimized battery charging (default: on) (needs reboot)
sudo defaults write com.apple.smartcharging.topoffprotection enabled -bool false


###
### lock screen
###

echo "Lock Screen settings..."

# start screen saver when inactive (default: 20 minutes)
# time in seconds
# never = 0
defaults -currentHost write com.apple.screensaver idleTime -int 600

# turn display off on battery when inactive (default: 2 minutes)
# time in minutes
# never = 0
sudo pmset -b displaysleep 5

# turn display off on power adapter when inactive (default: 10 minutes)
# time in minutes
# never = 0
sudo pmset -c displaysleep 20


### hidden lock screen tweaks

# reopen all windows after next login (default: on)
# disable = false
# enable = true
defaults write com.apple.loginwindow TALLogoutSavesState -bool false


###
### touch id & password
###

echo "Touch ID & Password settings..."


###
### users & groups
###

echo "Users & Groups settings..."


###
### passwords
###


### password options

# use passwords and passkeys from
# keychain (default: on)
defaults write com.apple.Safari AutoFillFromiCloudKeychain -bool false

# clean up automatically (default: off)
defaults write com.apple.onetimepasscodes DeleteVerificationCodes -bool true


###
### internet accounts
###

echo "Internet Accounts settings..."


###
### game center
###

echo "Game Center settings..."


###
### wallet & apple pay
###

echo "Wallet & Apple Pay settings..."


###
### keyboard
###

echo "Keyboard settings..."

# key repeat rate (default: 5)
defaults write NSGlobalDomain KeyRepeat -int 6

# delay until repeat (default: 30)
defaults write NSGlobalDomain InitialKeyRepeat -int 25

# press fn key to (default: 1)
# change input source = 1
# show emoji & symbols = 2
# start dictation (press fn twice) = 3
# do nothing = 0
defaults write com.apple.HIToolbox AppleFnUsageType -int 2

# keyboard navigation (default: off)
# on = 2
# off = 0
defaults write NSGlobalDomain AppleKeyboardUIMode -int 2


### keyboard shortcuts...

# disable the spotlight shortcut in favor of alfred
defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 64 "<dict><key>enabled</key><false/></dict>"


### text input


### Edit...

# show input menu in menu bar (default: on)
defaults write com.apple.TextInputMenu visible -bool false

# correct spelling automatically (default: on)
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# capitalize words automatically (default: on)
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# show inline predictive text (default: on)
defaults write NSGlobalDomain NSAutomaticInlinePredictionEnabled -bool false

# add period with double-space (default: on)
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# use smart quotes and dashes (default: on)
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false


### dictation

# language (default: set in setup assistant)
defaults write com.apple.speech.recognition.AppleSpeechRecognition.prefs VisibleNetworkSRLocaleIdentifiers -dict-add "de_DE" 1 "en_GB" 1
defaults write com.apple.speech.recognition.AppleSpeechRecognition.prefs DictationIMNetworkBasedLocaleIdentifier -string "de_DE"


###
### mouse
###

echo "Mouse settings..."

# tracking speed (default: 0.6875)
defaults write NSGlobalDomain com.apple.mouse.scaling 0.875

# natural scrolling (default: off)
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# scrolling speed (default: 0.3125)
defaults write NSGlobalDomain com.apple.scrollwheel.scaling -float 0.75


###
### trackpad
###

echo "Trackpad settings..."

### point & click

# trackpad speed (default: 0.6875)
defaults write NSGlobalDomain com.apple.trackpad.scaling -float 0.875


### scroll & zoom

# natural scrolling (default: on)
# already done in mouse section
# defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false


### more gestures

# swipe between pages & swipe between full-screen applications (default: scroll left or right with two fingers & swipe left or right with three fingers)
# off & off = false, 0, 0, 0, 0, 0, 0
# off & swipe left or right with three fingers = false, 2, 2, 2, 2, 2, 2
# off & swipe left or right with four fingers = false, 0, 0, 0, 2, 2, 2
# scroll left or right with two fingers & off = true, 0, 0, 0, 0, 0, 0
# scroll left or right with two fingers & swipe left or right with three fingers = true, 2, 2, 2, 2, 2, 2
# scroll left or right with two fingers & swipe left or right with four fingers = true, 0, 0, 0, 2, 2, 2
# swipe with three fingers & off = false, 1, 1, 1, 0, 0, 0
# swipe with three fingers & swipe left or right with four fingers = false, 1, 1, 1, 2, 2, 2
# swipe with two or three fingers & off = true, 1, 1, 1, 0, 0, 0
# swipe with two or three fingers & swipe left or right with four fingers = true, 1, 1, 1, 2, 2, 2
defaults write NSGlobalDomain AppleEnableSwipeNavigateWithScrolls -bool false
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerHorizSwipeGesture -int 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerHorizSwipeGesture -int 1
defaults -currentHost write NSGlobalDomain com.apple.trackpad.threeFingerHorizSwipeGesture -int 1
defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerHorizSwipeGesture -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadFourFingerHorizSwipeGesture -int 2
defaults -currentHost write NSGlobalDomain com.apple.trackpad.fourFingerHorizSwipeGesture -int 2

# mission control & app expose (default: swipe up with three fingers & off)
# off & off = false, false, 1, 1, 1, 2, 2, 2
# swipe up with three fingers & off = true, false, 2, 2, 2, 2, 2, 2
# swipe up with four fingers & off = true, false, 1, 1, 1, 2, 2, 2
# swipe up with three fingers & swipe down with three fingers = true, true, 2, 2, 2, 2, 2, 2
# swipe up with four fingers & swipe down with four fingers = true, true, 1, 1, 1, 2, 2, 2
# off & swipe down with four fingers = false, true, 1, 1, 1, 2, 2, 2
# off & swipe down with three fingers = false, true, 2, 2, 2, 2, 2, 2
defaults write com.apple.dock showMissionControlGestureEnabled -bool true
defaults write com.apple.dock showAppExposeGestureEnabled -bool true
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerVertSwipeGesture -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerVertSwipeGesture -int 2
defaults -currentHost write NSGlobalDomain com.apple.trackpad.threeFingerVertSwipeGesture -int 2
defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerVertSwipeGesture -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadFourFingerVertSwipeGesture -int 2
defaults -currentHost write NSGlobalDomain com.apple.trackpad.fourFingerVertSwipeGesture -int 2


###
### printers & scanners
###

echo "Printers & Scanners settings..."


###
### game controllers
###

echo "Game Controllers settings..."


# function to prompt user and restart mac
restart_mac() {
  read "response?Finished customising System Settings. Would you like to restart your Mac? (y/n): "
  
  case "${response:l}" in  # convert response to lowercase
    y|yes)
      echo "Restarting Mac..."
      sudo shutdown -r now
      ;;
    n|no)
      echo "Restart cancelled. Please remember that some settings will not take effect until you restart your Mac."
      ;;
    *)
      echo "Invalid response. Please answer y/n or yes/no."
      restart_mac  # recursive call to prompt again
      ;;
  esac
}

restart_mac