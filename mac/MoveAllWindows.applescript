use AppleScript version "2.4" -- Yosemite (10.10) or later
use framework "Foundation"
use framework "AppKit"

-- Main (internal) display
set X to 0
set Y to 0

-- External display
-- set X to 1300
-- set Y to 41

-- Moves all windows of application "ApplicationName" to position (PositionX, PositionY)
on MoveAllWindows(ApplicationName, PositionX, PositionY)
	-- Check if given app is open
	tell application "System Events"
		if (exists of application process ApplicationName) is false then
			return
		end if
	end tell
	
	tell application ApplicationName to activate -- needs to be in front
	log ApplicationName
	tell application "System Events" to tell application process ApplicationName
		try
			repeat with X from 1 to (count windows)
				get properties of window X
				set position of window X to {PositionX, PositionY}
			end repeat
		end try
	end tell
end MoveAllWindows

-- Returns a tuple {width, height} with size of the external display
on getExternalDisplayZeroSize()
	set allScreens to current application's NSScreen's screens() as list
	repeat with aScreen in allScreens
		set aFrame to aScreen's frame()
		set pixelFrame to (aScreen's convertRectToBacking:aFrame)
		set contents of aScreen to {current application's NSWidth(pixelFrame), current application's NSHeight(pixelFrame)}
	end repeat
	return contents of aScreen
end getExternalDisplayZeroSize

tell application "System Events"
	set listOfProcesses to (name of every process where background only is false)
end tell

-- log "Warning! This script needs to be executed using 'Terminal' app (not any any terminal emulator to work"

log "Moving all windows to external display"

-- Window bound is a tuple {posX, posY, 
-- Example for an external display located on the right:
--     {0, 0, 3120, 1050}
-- external display located on the left:
--     {-1440, 0, 1680, 1050}
tell application "Finder"
	set windowBounds to bounds of window of desktop
end tell

-- Find out where is external display located (left/right)
if item 1 of windowBounds is less than 0 then
	set X to item 1 of windowBounds
	set Y to 0
else
	set X to ((item 3 of windowBounds) - (item 1 of getExternalDisplayZeroSize()))
	set Y to 0
end if

set filteredList to {}
set itemsToDelete to {"idea", "BlueJeans", "Electron", "soffice", "studio", "firefox"}

repeat with i from 1 to count listOfProcesses
	-- uncomment one of these for debug
	-- log {listOfProcesses's item i}
	--display dialog {listOfProcesses's item i} 
	if {listOfProcesses's item i} is not in itemsToDelete then set filteredList's end to listOfProcesses's item i
end repeat

repeat with processName in filteredList
	MoveAllWindows(processName, X, Y)
end repeat

-- Some applications need to be moved "manually"
MoveAllWindows("Blue Jeans", X, Y)
MoveAllWindows("IntelliJ IDEA", X, Y)
MoveAllWindows("Android Studio", X, Y)

MoveAllWindows("LibreOffice", X, Y)
MoveAllWindows("Firefox Developer Edition", X, Y)
MoveAllWindows("Code", X, Y) -- Visual Studio Code

