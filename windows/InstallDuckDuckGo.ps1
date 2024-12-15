# Define the URL for the DuckDuckGo appinstaller file
$appInstallerUrl = "https://staticcdn.duckduckgo.com/windows-desktop-browser/installer/funnel_browser/DuckDuckGo.appinstaller"

# Define the path to save the appinstaller file
$appInstallerPath = "$env:TEMP\DuckDuckGo.appinstaller"

# Cleanup: Optionally remove the appinstaller file
Write-Output "Cleaning up previous downloads/installations..."
Remove-Item -Path $appInstallerPath -Recurse -Force

Write-Output "Downloading DuckDuckGo browser appinstaller..."

# Download the appinstaller file
Invoke-WebRequest -Uri $appInstallerUrl -OutFile $appInstallerPath -UseBasicParsing

if (Test-Path $appInstallerPath) {
    Write-Output "Appinstaller downloaded successfully to $appInstallerPath"

    Write-Output "Launching App Installer to install DuckDuckGo browser..."

    # Use the App Installer to handle installation
    Start-Process -FilePath "explorer.exe" -ArgumentList $appInstallerPath -Wait

    Write-Output "DuckDuckGo browser installation process launched. Follow any prompts to complete installation."

} else {
    Write-Output "Failed to download the DuckDuckGo browser appinstaller. Please check your internet connection or URL."
}
