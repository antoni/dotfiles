#!/usr/bin/env bash

USERNAME=$(whoami)

declare -A ENTRY_TO_LOCATION=(
	[myDocuments.cannedSearch]=file:///System/Library/CoreServices/Finder.app/Contents/Resources/MyLibraries/myDocuments.cannedSearch/
	[Applications]=file:///Applications/
	[Pictures]=file:///Pictures/
	[AirDrop]=nwnode://domain-AirDrop
)

for K in "${!ENTRY_TO_LOCATION[@]}"; do
	echo mysides add "$K" "${ENTRY_TO_LOCATION[$K]}"
done
