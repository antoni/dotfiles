#!/usr/bin env

# Turn Screen Saver on after x minutes (1800 s/30 m)

# Computer MCX
sleep .5
sudo dscl . -mcxset /Computers/localhost com.apple.screensaver idleTime always -int 1800
sudo dscl . -mcxset /Computers/localhost com.apple.screensaver askForPassword always -int 1
sudo dscl . -mcxset /Computers/localhost com.apple.screensaver askForPasswordDelay always -int 0
# Computer Defaults Writes
sleep .5
sudo su -l "a" -c "defaults -currentHost write com.apple.screensaver askForPassword -int 1"
sudo su -l "a" -c "defaults -currentHost write com.apple.screensaver askForPasswordDelay -int 0"
sudo su -l "a" -c "defaults -currentHost write com.apple.screensaver idleTime 1800"

# Energy Saver “Turn display off after” preferences (minutes)
sudo pmset -b displaysleep 25
sudo pmset -c displaysleep 25
