# cask-cppi Copy Preferences and Plug In's
# version: 0.1.0
# Description: 
This is based on using homebrew-cask aka hbc that copies plugins and preferences to the relevant directories.

# Running the app:
* First edit the appsloc.csv for your required files.
* Where {appName} is the brew cask name
* {appSupportDir} is the directory located in the '$HOME/Library/Application Support' directory
* {appPreferences} is the directory located in the '$HOME/Library/Preferences/' directory
* for example  
sublime-text3,Sublime Text 3,Sublime Text 3
* From the terminal run: 

	./cppi.sh

this will first check to see if appSupportDir and appPreferences directories exist and create if necessary, then loads the list from appsloc.csv and then copies the support files and preferences to the relevant directories based on {appname} if installed.


## Procedure:

First download and install homebrew visit http://brew.sh/ this will also install a tap named homebrew-cask

* Install the app {appname} using homebrew-cask

	brew cask install {appname}
	
	for example
	
	brew cask install sublime-text3
	
* make changes to your requirements eg colors, fonts etc.
* install plugins.
* Copy files from $HOME/Library/Application Support/{appName} to appSupportDir
* Copy files from $HOME/Library/Preferences/{appName} to appPrefDir
* Add {appName}, {appSupportDir}, {appPreferences} to appsloc.csv making sure that each field is separated with a comma including spaces in the directory names and it matches the directory names in the appSupportDir and appPrefDir directories.

## Recommend installing


go2shell 
visit http://zipzapmac.com/Go2Shell
or use 

	brew cask install go2shell





