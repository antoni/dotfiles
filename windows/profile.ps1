# All Users, All Hosts profile
# On Windows, should be stored - $PSHOME\Profile.ps1
$env:Path+=';C:\Program Files\Vim\vim90'

New-Alias copy_to_clipboard Set-Clipboard

function Get-ProcessPathByNamePart {

    param (
        $ProcessNamePart
    )

	Get-Process *$ProcessNamePart* | Select-Object -ExpandProperty Path
}

