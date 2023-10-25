# TODO: Add some functions from here:
# https://github.com/OzakIOne/win10setup/blob/8e8d9974f202d0c84d3d53e9224ab88baac03f3b/config/Microsoft.PowerShell_profile.ps1
# Current user – Current host profile
# On Windows, should be stored in location defined
# in $profile global PowerShell variable (for Current user – Current host)
$env:Path += ';C:\Program Files\Vim\vim90'

New-Alias copy_to_clipboard Set-Clipboard

function Get-ProcessPathByNamePart {

    param (
        $ProcessNamePart
    )

    Get-Process *$ProcessNamePart* | Select-Object -ExpandProperty Path
}

set-alias cat        get-content
set-alias cd         set-location
set-alias clear      clear-host
set-alias cp         copy-item
set-alias h          get-history
set-alias history    get-history
set-alias kill       stop-process
set-alias lp         out-printer
set-alias ls         get-childitem
set-alias mount      new-mshdrive
set-alias mv         move-item
set-alias popd       pop-location
set-alias ps         get-process
set-alias pushd      push-location
set-alias pwd        get-location
set-alias r          invoke-history
set-alias rm         remove-item
set-alias rmdir      remove-item
set-alias echo       write-output

set-alias cls        clear-host
set-alias chdir      set-location
set-alias copy       copy-item
set-alias del        remove-item
set-alias dir        get-childitem
set-alias erase      remove-item
set-alias move       move-item
set-alias rd         remove-item
set-alias ren        rename-item
set-alias set        set-variable
set-alias type       get-content

function help {
    get-help $args[0] | out-host -paging
}

function man {
    get-help $args[0] | out-host -paging
}

function mkdir {
    new-item -type directory -path $args
}

function md {
    new-item -type directory -path $args
}

function prompt {
    "PS " + $(get-location) + "> "
}

& {
    for ($i = 0; $i -lt 26; $i++) {
        $funcname = ([System.Char]($i + 65)) + ':'
        $str = "function global:$funcname { set-location $funcname } "
        invoke-expression $str
    }
}

function ListUsbDevices {
    Get-PnpDevice -PresentOnly | Where-Object { $_.InstanceId -match '^USB' }
}

if (($host.Name -eq 'ConsoleHost')) {
    Import-Module PSReadLine
    Set-PSReadLineOption -PredictionSource History
    Set-PSReadlineKeyHandler -Key UpArrow   -Function HistorySearchBackward
    Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward
    # Set-PSReadLineKeyHandler -Key Tab -Function Complete
    Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
    Set-PSReadLineOption -HistorySearchCursorMovesToEnd
    Set-PSReadLineOption -Colors @{ InlinePrediction = '#F6546A' }
    if (($host.Version.Major -eq 7)) {
        Set-PSReadLineOption -PredictionViewStyle ListView
        Set-PSReadLineOption -EditMode Windows
    }
}
