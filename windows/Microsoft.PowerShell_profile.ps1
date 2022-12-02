# Current user – Current host profile
# On Windows, should be stored in location defined
# in $profile global PowerShell variable (for Current user – Current host)
$env:Path+=';C:\Program Files\Vim\vim90'

New-Alias copy_to_clipboard Set-Clipboard

function Get-ProcessPathByNamePart {

    param (
        $ProcessNamePart
    )

	Get-Process *$ProcessNamePart* | Select-Object -ExpandProperty Path
}

