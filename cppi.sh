#!/bin/bash
# @Appname: cppi Copy Preferences and Plug In's
# @version: 0.1.0
# @Description: copies plugins and preferences to the relevant directories
# @Usage: Install the app {appname}, make changes to your requirements eg colors, fonts etc
# install plugins
# Copy files from $HOME/Library/Application Support/{appName} to appSupportDir
# Copy files from $HOME/Library/Preferences/{appName} to appPrefDir
#
# Add {appName}, {appSupportDir}, {appPreferences} to appsloc.csv making sure that each field
# is separated with a comma including spaces in the directory names and matches the directory
# names in the appSupportDir and appPrefDir directories.
# Where {appName} is the brew cask name
# {appSupportDir} is the directory located in the '$HOME/Library/Application Support' directory
# {appPreferences} is the directory located in the '$HOME/Library/Preferences/' directory
# for example
# sublime-text3,Sublime Text 3,Sublime Text 3
#
# run cppi.sh - this will then load the list from appsloc.csv and then copy the support files
# and preferences to the relevant directories based on {appname} if installed.

fancy_echo() {
  local fmt="$1"; shift

  # shellcheck disable=SC2059
  printf "\n$fmt\n" "$@"
}

# if no appSupportDir or appPrefDir then create them
if [ ! -d "appSupportDir" ]; then
  mkdir "$appSupportDir"
fi

if [ ! -d "appPrefDir" ]; then
  mkdir "$appPrefDir"
fi

from_appSupportDir="appSupportDir"
to_appSupportDir="$HOME/Library/Application Support"
from_appPrefDir="appPrefDir"
to_appPref="$HOME/Library/Preferences/"

inputfile="appsloc.csv"
SaveIFS=$IFS
IFS=","
while read appName appSupportDir appPreferences; do
#echo "the first value is", ${appName}
#echo "the second value is", ${appSupportDir}
#echo "the third value is", ${appPreferences}
# fancy_echo "Checking if Application  \"${appName}\" is installed..."
if brew cask list -1 | grep -Fqx ${appName}; then
    fancy_echo "${appName} is installed, adding files..."
    # copy Application support files
    if [ -d "$from_appSupportDir/${appSupportDir}" ]; then
        fancy_echo "Adding files to the Application support \"${appSupportDir}\" directory"
        # fancy_echo "copying files from appsupport: $from_appSupportDir/${appSupportDir}/"
        # fancy_echo "to $to_appSupportDir/${appSupportDir}/"
        rsync -rvuh  "$from_appSupportDir/${appSupportDir}" "$to_appSupportDir" --progress --exclude=.DS_Store  --safe-links
    else
        fancy_echo "Not adding Application support files none available."
    fi
    # copy Application Preferences
    if [ -d "$from_appPrefDir/${appPreferences}" ]; then
        fancy_echo "Adding files to the Preferences \"${appPreferences}\" directory..."
        rsync -rvuh  "$from_appPrefDir/${appPreferences}" "$to_appPref" --progress --exclude=.DS_Store  --safe-links

    else
        fancy_echo "Not adding Preference files, none available."
    fi

else
    fancy_echo "${appName} is NOT installed skipping"
fi

done < "$inputfile"
IFS=$SaveIFS

fancy_echo "Task completed"