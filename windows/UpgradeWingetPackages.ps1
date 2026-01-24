# Note: we skip these because of the error described here:
# https://github.com/microsoft/winget-cli/issues/2686
# add id to skip the update
$skipUpdate = @(
    # Requires elevation, should be updated via wsl.exe --update
    'Microsoft.WSL',
    # Requires elevation, doesn't really need to be upgraded
    'Notepad++.Notepad++.'
)


# object to be used basically for view only
class Software {
    [string]$Name
    [string]$Id
    [string]$Version
    [string]$AvailableVersion
}

# get the available upgrades
$upgradeResult = winget upgrade --include-unknown

# run through the list and get the app data
$upgrades = @()
$idStart = -1
$isStartList = 0
$upgradeResult | ForEach-Object -Process {

    if ($isStartList -lt 1 -and -not $_.StartsWith("Name") -or $_.StartsWith("---") -or $_.StartsWith("The following packages")) {
        return
    }

    if ($_.StartsWith("Name")) {
        $idStart = $_.toLower().IndexOf("id")
        $isStartList = 1
        return
    }

    if ($_.Length -lt $idStart) {
        return
    }

    $Software = [Software]::new()
    $Software.Name = $_.Substring(0, $idStart - 1)
    $info = $_.Substring($idStart) -split '\s+'
    $Software.Id = $info[0]
    $Software.Version = $info[1]
    $Software.AvailableVersion = $info[2]

    $upgrades += $Software
}

# view the list
$upgrades | Format-Table

# run through the list, compare with the skip list and execute the upgrade
# (could be done in the upper foreach as well)
$upgrades | ForEach-Object -Process {

    if ($skipUpdate -contains $_.Id) {
        Write-Host "Skipped upgrade to package $($_.id)"
        return
    }

    Write-Host "Going to upgrade $($_.Id)"
    winget upgrade --include-unknown --accept-package-agreements --accept-source-agreements $_.Id

    # Run this because of this issue: https://github.com/microsoft/winget-cli/issues/2686
    # winget.exe upgrade --all `
    #   --include-unknown `
    #   --accept-package-agreements `
    #   --accept-source-agreements
}





