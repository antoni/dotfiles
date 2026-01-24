# https://docs.microsoft.com/en-us/windows-hardware/manufacture/desktop/dism-default-application-association-servicing-command-line-options?view=windows-11

# Export to file
#Dism.exe /Online /Export-DefaultAppAssociations:C:\ApplicationAssociations.xml
#Dism.exe /Online /Export-DefaultAppAssociations:ApplicationAssociations.xml

Dism.exe /Online /Import-DefaultAppAssociations:ApplicationAssociations.xml




