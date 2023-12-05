#!/bin/zsh

# check compatibility
MACOS_VERSION_MAJOR=$(sw_vers -productVersion | cut -f1 -d'.')

if [[ "$MACOS_VERSION_MAJOR" != "13" ]] && [[ "$MACOS_VERSION_MAJOR" != "14" ]]; then
  echo "This script is only compatible with macOS 13 or higher, exiting..."
  exit
else
  :
fi

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
### activity monitor
###

echo "Activity Monitor settings..."

### view settings

# view (default: my processes)
# all processes = 100
# all processes, hierarchically = 101
# my processes = 102
# system processes = 103
# other user processes = 104
# active processes = 105
# inactive processes = 106
# gpu processes = 110
# windowed processes = 107
# selected processes = ?
# applications in last 12 hours = ?
# processes, by gpu = ?
defaults write com.apple.ActivityMonitor ShowCategory -int 100


###
### app store
###

echo "App Store settings..."

# video autoplay (default: on)
# on = on
# off = off
defaults write com.apple.AppStore AutoPlayVideoSetting -string "off"
defaults write com.apple.AppStore UserSetAutoPlayVideoSetting -bool true

# in app reviews (default: on) (needs reboot)
defaults write com.apple.AppStore InAppReviewEnabled -bool false


###
### calendar
###

echo "Calendar settings..."

### general

# day starts at (default: 8:00)
# 06:00 = 360
# 08:00 = 480
# ...
defaults write com.apple.iCal "first minute of work hours" -integer 360

# day ends at (default: 18:00)
# midnight = 1440
defaults write com.apple.iCal "last minute of work hours" -integer 1440

# show x hours at a time (default: 12)
defaults write com.apple.iCal "number of hours displayed" -integer 16


### advanced

# show events in year view (default: off)
defaults write com.apple.iCal "Show heat map in Year View" -bool true

# show week numbers (default: off)
defaults write com.apple.iCal "Show Week Numbers" -bool true


###
### contacts
###

echo "Contacts settings..."

### general

# short name format (default: first name only)
# full name = 0
# first name & last initial = 1
# first initial & last name = 2
# first name only = 3
# last name only = 4
defaults write NSGlobalDomain NSPersonNameDefaultShortNameFormat -integer 2


###
### disk utility
###

echo "Disk Utility settings..."

### view settings

# show all devices (default: off)
defaults write com.apple.DiskUtility SidebarShowAllDevices -bool true


###
### finder
###

echo "Finder settings..."

### general

# show these items on the desktop
# external disks (default: on)
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
# cds, dvds, and ipods (default: on)
defaults write com.apple.finder ShowMountedServersOnDesktop -bool false

# new finder windows show (default: recents)
# computer = PfCm
# volume = PfVo, "file:///"
# home folder = PfHm, "file://${HOME}/"
# desktop = PfDe, "file://${HOME}/Desktop/"
# documents = PfDo, "file://${HOME}/Documents/"
# icloud drive = PfID, "file://${HOME}/Library/Mobile%20Documents/com~apple~CloudDocs/"
# recents = PfAF, "file:///System/Library/CoreServices/Finder.app/Contents/Resources/MyLibraries/myDocuments.cannedSearch/"
# Other… = PfLo, "file:///full/path/here/"
defaults write com.apple.finder NewWindowTarget -string "PfHm"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}"

# open folders in tabs instead of new windows (default: on)
defaults write com.apple.finder FinderSpawnTab -bool false


### tags


### sidebar
defaults write com.apple.finder ShowRecentTags -bool false


### advanced

# show all filename extensions (default: off)
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# show warning before changing an extension (default: on)
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# show warning before removing from icloud drive (default: on)
defaults write com.apple.finder FXEnableRemoveFromICloudDriveWarning -bool false

# keep folders on top in windows when sorting by name (default: off)
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# keep folders on top on desktop (default: off)
defaults write com.apple.finder _FXSortFoldersFirstOnDesktop -bool true

# when performing a search (default: search this mac)
# search this mac = SCev
# search the current folder = SCcf
# use the previous search scope = SCsp
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"


### view settings (cmd + j)

# default finder view style (default: as icons)
# as icons = icnv
# as list = Nlsv
# as columns = clmv
# as gallery = Flwv
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# icon view

# sort by (default: none)
# desktop
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
# finder icon view
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

# icon size (default: 64)
# desktop
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist
# finder icon view
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist

# grid spacing (default: 54)
# desktop
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:gridSpacing 62" ~/Library/Preferences/com.apple.finder.plist
# finder icon view
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:gridSpacing 62" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:gridSpacing 62" ~/Library/Preferences/com.apple.finder.plist

# list view

# column view

# gallery view


### view settings

# show/hide path bar (default: off)
defaults write com.apple.finder ShowPathbar -bool true


### hidden finder tweaks

# disable window animations and get info animations
defaults write com.apple.finder DisableAllAnimations -bool true

# allow text selection in quick look
defaults write com.apple.finder QLEnableTextSelection -bool true

# avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# avoid creating .DS_Store files on removable drives
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# show ~/Libary folder
# delete specific extended attribute
if [[ $(xattr -p com.apple.FinderInfo ~/Library) ]]; then
  xattr -d com.apple.FinderInfo ~/Library
else
  :
fi
# set folder flag to not hidden
chflags nohidden ~/Library


###
### mail
###

echo "Mail settings..."

# mail needs to be openend once, otherwise settings won't apply
echo "Opening and closing Mail..."
osascript <<EOF
  try
    tell application "Mail"
      run
      delay 4
      quit
    end tell
  end try		
EOF

### general

# new messages sound (default: new messages sound)
# none = ""
# new messages sound = "New Mail"
defaults write com.apple.mail MailSound -string ""

# remove unedited downloads (default: after message is deleted)
# each attachment that is opened gets "downloaded" (pop3 and imap)
# files are stored in "~/Library/Containers/com.apple.mail/Data/Library/Mail Downloads/"
# never = 0, false
# when mail quits = 0, true
# after message is deleted = 2147483647, true
defaults write com.apple.mail DeleteAttachmentsAfterHours -int 0
defaults write com.apple.mail DeleteAttachmentsEnabled -bool true

# follow up suggestions  
defaults write ""$HOME"/Library/Group Containers/group.com.apple.mail/Library/Preferences/group.com.apple.mail.plist" DisableFollowUp -bool true

# when searching all mailboxes, include results from:
# trash (default: on)
defaults write com.apple.mail IndexTrash -bool true
# junk (default: off)
defaults write com.apple.mail IndexJunk -bool true
# encrypted messages (default: off)
defaults write com.apple.mail IndexDecryptedMessages -bool true


### accounts


### junk mail


### fonts & colors


### viewing

# list preview (default: 2 lines)
# none = 0
# x lines = x
defaults write com.apple.mail NumberOfSnippetLines -int 0

# display unread messages with bold font (default: off)
defaults write com.apple.mail ShouldShowUnreadMessagesInBold -bool true

# mark all messages as read when opening a conversation (default: off)
defaults write com.apple.mail ConversationViewMarkAllAsRead -bool true

# show most recent message at the top (default: off)
defaults write com.apple.mail ConversationViewSortDescending -bool true


### composing

# when quoting text in replies or forwards (default: include selected text, if any; otherwise include all text)
# include all of the original message text = true
# include selected text, if any; otherwise include all text = false
defaults write com.apple.mail AlwaysIncludeOriginalMessage -bool true


### signatures

# place signature above quoted text (default: false)
defaults write com.apple.mail SignaturePlacedAboveQuotedText -bool true


### rules


### extensions


### privacy


### view settings

# show date and time (default: off)
defaults write com.apple.mail MessageListShowDateTime -bool true

# cc address field (default: off)
defaults write com.apple.mail ShowCcHeader -bool true

# bcc address field (default: off)
defaults write com.apple.mail ShowBccHeader -bool true


# hidden mail tweaks

# copy email addresses as "foo@example.com" instead of "Foo Bar <foo@example.com>"
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

# disable inline attachments (just show the icons, e.g. for single-page pdfs)
defaults write com.apple.mail DisableInlineAttachmentViewing -bool true

# always add attachments at the end of messages
defaults write com.apple.mail AttachAtEnd -bool true

# always send attachments windows friendly
defaults write com.apple.mail SendWindowsFriendlyAttachments -bool true

# grammar checking
defaults write com.apple.mail WebGrammarCheckingEnabled -bool false

# spelling checking
defaults write com.apple.mail WebContinuousSpellCheckingEnabled -bool true

# automatic spelling correction
defaults write com.apple.mail WebAutomaticSpellingCorrectionEnabled -bool false


###
### safari
###

echo "Safari settings..."

### general

# homepage (default: https://www.apple.com/startpage)
defaults write com.apple.Safari HomePage -string "about:blank"
defaults write com.apple.Safari DidMigrateDownloadFolderToSandbox -bool false
defaults write com.apple.Safari DidMigrateResourcesToSandbox -bool false
defaults read com.apple.Safari >/dev/null 2>&1
defaults write com.apple.Safari.SandboxBroker Homepage -string "about:blank"
defaults write com.apple.Safari.SandboxBroker DidMigrateDownloadFolderToSandbox -bool false
defaults write com.apple.Safari.SandboxBroker DidMigrateResourcesToSandbox -bool false
defaults read com.apple.Safari.SandboxBroker >/dev/null 2>&1

# remove history items (default: after one year)
# after one day = 1
# after one week = 7
# after two weeks = 14
# after one month = 30
# after one year = 365
# manually = 365000
defaults write com.apple.Safari HistoryAgeInDaysLimit -int 30

# remove download list items (default: after one day)
# after one day = 3
# when safari quits = 1
# upon successful download = 2
# manually = 0
defaults write com.apple.Safari DownloadsClearingPolicy -int 1

# open safe files after downloading (default: on)
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false


### tabs

# when a new tab or window opens, make it active (default: off)
defaults write com.apple.Safari OpenNewTabsInFront -bool true


### autofill

# using information from my contacts (default: on)
defaults write com.apple.Safari AutoFillFromAddressBook -bool false

# user names and passwords (default: on)
defaults write com.apple.Safari AutoFillPasswords -bool false

# credit cards (default: on)
defaults write com.apple.Safari AutoFillCreditCardData -bool false

# other forms (default: on)
defaults write com.apple.Safari AutoFillMiscellaneousForms -bool false


### passwords

# same as in system settings -> passwords

### search

# private browsing search engine (default: default)
# default
# defaults delete com.apple.Safari PrivateSearchProviderShortName
# google
# defaults write com.apple.Safari PrivateSearchProviderShortName -string "Google"
# yahoo
# defaults write com.apple.Safari PrivateSearchProviderShortName -string "Yahoo!"
# bing
# defaults write com.apple.Safari PrivateSearchProviderShortName -string "Bing"
# duckduckgo
defaults write com.apple.Safari PrivateSearchProviderShortName -string "DuckDuckGo"
# ecosia
# defaults write com.apple.Safari PrivateSearchProviderShortName -string "Ecosia"

# include search engine suggestions (default: on)
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

# include safari suggestions (default: on)
defaults write com.apple.Safari UniversalSearchEnabled -bool false

# preload top hit in the background (default: on)
defaults write com.apple.Safari PreloadTopHit -bool false

# show favorites (default: on)
defaults write com.apple.Safari ShowFavoritesUnderSmartSearchField -bool false


### security


### privacy


### websites

# notifications
# allow websites to ask for permission to send notifications (default: on)
defaults write com.apple.Safari CanPromptForPushNotifications -bool false


### profiles


### extensions


### advanced

# smart search field: show full website address (default: off)
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# accessibility: press tab to highlight each item on a webpage (default: off)
defaults write com.apple.Safari WebKitTabToLinksPreferenceKey -bool true
defaults write com.apple.Safari WebKitPreferences.tabFocusesLinks -bool true

# privacy: use advanced tracking and fingerprinting protection (default: in private browsing)
# off = false, false
# in private browsing = true, false
# in all browsing = true, true
defaults write com.apple.Safari EnableEnhancedPrivacyInPrivateBrowsing -bool true
defaults write com.apple.Safari EnableEnhancedPrivacyInRegularBrowsing -bool true

# privacy: allow privacy-preserving measurement of ad effectiveness (default: on)
defaults write com.apple.Safari WebKitPreferences.privateClickMeasurementEnabled -bool false

# show features for web developers (default: off)
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari DeveloperMenuVisibility -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari WebKitPreferences.developerExtrasEnabled -bool true
defaults write com.apple.Safari.SandboxBroker ShowDevelopMenu -bool true


### developer


### view settings

# always show tab bar (default: off)
defaults write com.apple.Safari AlwaysShowTabBar -bool true

# show/hide favorites bar (default: off)
defaults write com.apple.Safari ShowFavoritesBar -bool true
defaults write com.apple.Safari ShowFavoritesBar-v2 -bool true


### hidden safari tweaks

# allow hitting the backspace key to go to the previous page in history
defaults write com.apple.Safari WebKitPreferences.backspaceKeyNavigationEnabled -bool true

# send do not track header
defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true


###
### screenshot
###

echo "Screenshot settings..."

### hidden screenshot tweaks

# disable shadow in screenshots (default: off)
# true = shadow disabled
# false = shadow enabled
defaults write com.apple.screencapture disable-shadow -bool true


###
### terminal
###

echo "Terminal settings..."

# install theme for terminal
PATH_TO_THEME="$(dirname "${0:A}")/etc/Solarized Dark.terminal"

if [[ -f $PATH_TO_THEME ]]; then
  # install theme and set as default
  osascript <<EOD
    tell application "Terminal"
      set themeName to "Solarized Dark"

      -- Check if the theme is already imported
      if not (exists (settings set themeName)) then
        local initialOpenWindows
        local allOpenWindows

        -- Store the IDs of all open terminal windows
        set initialOpenWindows to id of every window

        -- Open the custom theme to add it to available themes
        do shell script "open '$PATH_TO_THEME'"

        -- Wait a bit to ensure the theme is added
        delay 1

        -- Get the IDs of all currently open windows
        set allOpenedWindows to id of every window

        -- Close additional windows opened for theme import
        repeat with windowID in allOpenedWindows
          if initialOpenWindows does not contain windowID then
            close (every window whose id is windowID)
          end if
        end repeat
      end if

      -- Set the custom theme as the default
      set default settings to settings set themeName

      -- Apply the theme to already opened windows
      repeat with aWindow in every window
        set current settings of tabs of aWindow to settings set themeName
      end repeat
    end tell
EOD
else
  # set pre-installed pro theme as default
  osascript -e 'tell application "Terminal" to set default settings to settings set "Pro"'
fi


### general


### window groups


### encodings

# defaults can be restored in settings
# only use utf-16
defaults write com.apple.terminal StringEncodings -array 10


### hidden terminal tweaks

# disable line marks
defaults write com.apple.Terminal ShowLineMarks -int 0


###
### textedit
###

echo "TextEdit settings..."

# textedit needs to be openend once, otherwise settings won't apply
echo "Opening and closing TextEdit..."
osascript <<EOF
  try
    tell application "TextEdit"
      run
      delay 3
      quit
    end tell
  end try		
EOF

### new document

# format (default: rich text)
# rich text
# defaults delete com.apple.TextEdit RichText
# plain text
defaults write com.apple.TextEdit RichText -int 0

# window size (default: 96, 30)
defaults write com.apple.TextEdit WidthInChars -int 96
defaults write com.apple.TextEdit HeightInChars -int 40

# check spelling as you type (default: on)
defaults write com.apple.TextEdit CheckSpellingWhileTyping -bool false 

# correct spelling automatically (default: on)
defaults write com.apple.TextEdit CorrectSpellingAutomatically -bool false

# show ruler (default: on)
defaults write com.apple.TextEdit ShowRuler -bool false

# smart quotes (default: on)
defaults write com.apple.TextEdit SmartQuotes -bool false

# smart dashes (default: on)
defaults write com.apple.TextEdit SmartDashes -bool false


### open and save

# when opening a file
# display html files as html code instead of formatted text (default: off)
defaults write com.apple.TextEdit IgnoreHTML -bool true



# restart affected applications
echo "Finished customising app settings. Restarting affected applications..."

for app in "Activity Monitor" "App Store" "Calendar" "Contacts" "Disk Utility" "Finder" "Mail" "Safari" "TextEdit"; 
do
  echo -e " \t $app"
  killall -q "${app}"
done