-- Main display
-- set X to 0
-- set Y to 0

-- External display
set X to 1250
set Y to 41

-- Moves all windows of application "ApplicationName" to position (PositionX, PositionY)
on MoveAllWindows(ApplicationName, PositionX, PositionY)
	-- Check if given app is open
	tell application "System Events"
		if (exists of application process ApplicationName) is false then
			return
		end if
	end tell
	
	tell application ApplicationName to activate -- needs to be in front
	tell application "System Events" to tell application process ApplicationName
		try
			repeat with X from 1 to (count windows)
				get properties of window X
				set position of window X to {PositionX, PositionY}
				--set size of window x to {1250, 2560}
			end repeat
		end try
	end tell
end MoveAllWindows

tell application "System Events"
	set listOfProcesses to (name of every process where background only is false)
end tell

set filteredList to {}
set itemsToDelete to {"idea", "BlueJeans", "Electron", "soffice", "studio"}

repeat with i from 1 to count listOfProcesses
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
MoveAllWindows("Firefox", X, Y)
MoveAllWindows("Code", X, Y) -- Visual Studio Code
