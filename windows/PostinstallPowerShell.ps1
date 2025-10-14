# Post-install script
Install-Module PSReadLine -AllowPrerelease -Force

winget.exe upgrade --all

./RemoveShortcutsFromDesktop.ps1
