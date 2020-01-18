#!/usr/bin/env bash

USERNAME=`whoami`

declare -A ENTRY_TO_LOCATION=(
        [antek.ff_fra]=file:///Users/antek.ff_fra/
        [myDocuments.cannedSearch]=file:///System/Library/CoreServices/Finder.app/Contents/Resources/MyLibraries/myDocuments.cannedSearch/
        [Applications]=file:///Applications/
        [Desktop]=file:///Users/antek.ff_fra/Desktop/
        [Pictures]=file:///Pictures/
        [Music]=file:///Users/antek.ff_fra/Music/
        [Downloads]=file:///Users/antek.ff_fra/Downloads/
        [Test]=file:///Users/antek.ff_fra/Downloads/pendulum/
        [Documents]=file:///Users/antek.ff_fra/Documents/
        [Dropbox]=file:///Users/antek.ff_fra/Dropbox/
        [AirDrop]=nwnode://domain-AirDrop
        )

for K in "${!ENTRY_TO_LOCATION[@]}";
do echo mysides add $K ${ENTRY_TO_LOCATION[$K]};
done
