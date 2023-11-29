# MacOS Setup
This repository contains opinionated scripts and configurations to set up a fresh installation of macOS.

Requirements:
- A Mac running macOS 13 (Ventura) or later

## Usage
The following will walk you through the steps of installing/re-installing your machine.

### Step 0: Backup Your Data

If you are migrating from an old Mac or performing a clean macOS installation, make sure you have at least one recent backup of your machine and that it is working properly.

The easiest way to do this is to use the built-in macOS backup feature [Time Machine](https://support.apple.com/en-us/HT201250) and back up to an external storage device or partition connected to your Mac. If you need to restore your system, you can do so from the [Time Machine backup](https://support.apple.com/en-us/HT203981), either completely or selectively.

For added security and convenience, you can back up to multiple disks, perhaps different types of [storage devices](https://support.apple.com/en-us/102423).

It is also a good idea to do the following before the next step:
- Check which applications sync their data via iCloud (e.g. Calendar, Contacts,...); their data will be downloaded automatically and won't need to be restored manually.
- Deauthorize any licensed programs to be able to register your licence again later. For me, these currently are:
  - AlDente
  - Alfred 5
  - Little Snitch

### Step 1: Erase and Format Your Hard Drive

The next step in a clean macOS installation is to wipe and format your Mac's hard drive. If you are migrating from an older Mac, you should complete these steps before selling, giving away, trading in or recycling your old Mac.

The best way to do this depends on your hardware model. [Mac computers with Apple Silicon](https://support.apple.com/en-us/HT211814) or [Mac computers with the Apple T2 Security Chip](https://support.apple.com/en-us/HT208862) with macOS 12 (Monterey) or later installed can use the [Erase All Content and Settings](https://support.apple.com/en-us/HT212749) option that allows you to reset your Mac to factory settings without having to work through the many steps to wipe and format your drive.

For older models, follow the steps outlined in [What to do before you sell, give away, trade in, or recycle your Mac](https://support.apple.com/en-us/HT201065).

### Step 2: Update MacOS

After completing the clean macOS installation, your Mac starts up to the Setup Assistant again. To leave the Mac in an out-of-box state, press Command-Q to shut down instead of continuing the setup.

To start reconfiguring macOS, complete the Setup Assistant. For a true clean install, don't restore your Mac from a Time Machine backup or perform a system migration, as this will also bring back all the clutter from your old machine.

Once the Setup Assistant has finished, open Terminal to update macOS to the latest version:

```zsh
softwareupdate --list
softwareupdate -i -a --verbose
```

Now begins the more advanced, opinionated setup. If you just want a fresh installation of macOS that you can customize manually, you can skip the following steps.

### Step 3: Install Command Line Tools & Rosetta

#### Command Line Tools

Out of the box, macOS doesn't include all of the tools needed for programming. Instead, Apple provides a complete development environment named Xcode, which is available separately for download and installation. The full Xcode package is huge, requiring over 40GB of disk space, and supports development for all Apple operating systems.

Many software developers use Macs but don't develop software for Apple devices. However, they still need the tools and utilities installed with the Xcode package (e.g. `git`). Fortunately, Apple provides a separate and much smaller download, Xcode Command Line Tools, which installs the most essential utilities for software development.

You can install this smaller package in [several ways](https://mac.install.guide/commandlinetools/index.html):
- The easiest way is to [install Homebrew](https://mac.install.guide/commandlinetools/3.html) (see step 5). When you install Homebrew, you'll be given the option to install Xcode Command Line Tools.
- You can also [install the Xcode Command Line Tools directly](https://mac.install.guide/commandlinetools/4.html) using [3a_dev_tools.sh](./3a_dev_tools.sh). This script checks if the Xcode Command Line Tools were previously installed. If not, it installs them.
- If you are planning to develop software for Apple devices, you may as well install the full [Xcode application from the App Store](https://mac.install.guide/commandlinetools/5.html). This will also install the Xcode Command Line Tools.

#### Rosetta

Rosetta 2 makes it possible to run Intel-based applications on Apple Silicon Macs. Many Mac users rely on Intel-based applications that are not readily compatible with the new architecture. You can install it using [3b_rosetta.sh](./3b_rosetta.sh).

If you are not sure whether you need Rosetta, you can skip the installation. If you try to run an Intel-based application on an Apple Silicon Mac, and there's no Apple Silicon counterpart available, macOS will promptly offer to install Rosetta.

### Step 4: Dotfiles

TODO

### Step 5: Homebrew Formulae, Casks, Mac App Store Apps & VSCode Extensions

[Homebrew](https://brew.sh) is a package manager for macOS that allows you to install and update command line tools and applications. To install Homebrew, use [5a_homebrew.sh](./5a_homebrew.sh). This script checks if Homebrew was already installed. If not, it installs it. On Apple Silicon Macs, it appends the default Homebrew shell environment to `.zprofile` and `.bash_profile` to make sure that the default installation prefix `/opt/homebrew` is in your `$PATH`.

[`mas`](https://github.com/mas-cli/mas) is a command line interface for the Mac App Store that allows you to install and update applications from the Mac App Store using the command line.

[5b_apps.sh](./5b_apps.sh) will install the Homebrew formulae, casks, Mac App Store apps, and VSCode extensions specified in the [Brewfile](./etc/Brewfile) using `brew bundle install`. Be sure to customize the brewfile to your liking.

### Step 6: MacOS System Settings

In this step, we will adapt the macOS system settings to our liking. We will do this using the script [6a_system_settings.sh](./6a_system_settings.sh) which changes some of the system settings using the `defaults` command.

The script is structured according to the macOS system settings. As it reflects my personal preferences, I recommend that you adapt it to your own before running it. For reasons of maintainability, this script only changes the settings where my personal preference differs from the default state. If you are missing settings you would like to change, have a look at my [macos-settings](https://github.com/philiprein/macos-settings) repository.

Before running the script, make sure you give the Terminal application full disk access (System Settings -> Privacy & Security -> Full Disk Access) and allow it to control your computer (System Settings -> Privacy & Security -> Accessability), otherwise some of the customisations will not work.

After running the script, restart your Mac for the settings to take effect. Some settings are not easily scriptable without disabling System Integrity Protection (SIP), so I made a list of settings to be adjusted manually in [6b_system_settings_manual.md](./6b_system_settings_manual.md).

### Step 7: Dock & Default Applications

Now we will customise the Dock and the default applications to open certain file types. A great tool for customising the Dock is [dockutil](https://github.com/kcrawford/dockutil), but as of November 2023, the [Homebrew formula is not up to date](https://github.com/kcrawford/dockutil/issues/146), so there is no easy way to install it. I therefore wrote a custom script ([7a_dock.sh](./7a_dock.sh)) based on [tiiiecherle's script](https://github.com/tiiiecherle/osx_install_config/blob/master/10_dock/10_dock.sh). You can the dock items it inserts by editing the lines at the bottom of the script.

To customise the default applications to open certain file types, we use a tool called [duti](https://github.com/moretension/duti). The script [7b_default_apps.sh](./7b_default_apps.sh) shows duti in action.

### Step 8: MacOS App Settings

In this step, we will adjust the settings of some of the standard macOS applications such as Finder and Safari using the script [7a_app_settings.sh](./8a_app_settings.sh). Again, this is my personal preference, so I suggest you adjust it to your liking before running it. For reasons of maintainability, this script only changes the settings where my personal preference differs from the default state. If you are missing settings you would like to change, have a look at my [macos-settings](https://github.com/philiprein/macos-settings) repository.

Some settings are not easily scriptable, so I made a list of settings to be adjusted manually in [7b_app_settings_manual.md](./8b_app_settings_manual.md).

### Step 9: Third Party App Settings

[mackup](https://github.com/lra/mackup) is a great tool for backing up the settings of third-party applications that do not have their own sync option. In this step we will leverage mackup in [9a_third_party_app_settings.sh](./9a_third_party_app_settings.sh) to restore third-party application settings. This script will also manually copy some application settings that mackup doesn't support from a Time Machine backup volume. This backup volume needs to be mounted before running the script.

[9b_firefox_hardening.sh](./9b_firefox_hardening.sh) hardens the Firefox browser using the user.js by [arkenfox](https://github.com/arkenfox/user.js) and also applies my custom [user-overrides.js](./etc/user-overrides.js). Before running the script, open Firefox and log into your Mozilla account.

### Step 10: Finalizations

The script [10a_finalizations.sh](./10a_finalizations.sh) copies the contents of the Documents folder from a Time Machine backup volume to the Documents folder in your home directory. It also migrates Internet Accounts.

[10b_finalizations_manual.md](./10b_finalizations_manual.md) lists a few manual steps that are left over such as reactivating software licenses.

## Credits

This project was inspired by [tiiiecherle's osx_install_config](https://github.com/tiiiecherle/osx_install_config). This project contains powerful, backwards-compatible scripts that handle a wide range of tasks related to setting up a Mac. I found them too complex for my purposes, so I decided to make this simplified version.