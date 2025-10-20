# TODO: Copy/symlink to C:\Users\<you>\Documents\WindowsPowerShell\Profile.ps1
$env:Path += ';C:\Program Files\Vim\vim91'
[System.Environment]::SetEnvironmentVariable('Path', $env:Path)
[System.Environment]::SetEnvironmentVariable('WINDOWS_USERNAME', 'vivob', 'User')

function Get-ProcessPathByNamePart {

    param (
        $ProcessNamePart
    )

    Get-Process *$ProcessNamePart* | Select-Object -ExpandProperty Path
}

Set-Alias vim vim.exe
Set-Alias vi vim.exe
Set-Alias python python.exe
Set-Alias python3 python.exe

Set-Alias copy_to_clipboard Set-Clipboard

Set-Alias cat        get-content
Set-Alias cd         set-location    -Option AllScope
Set-Alias clear      clear-host
Set-Alias cp         copy-item       -Option AllScope
Set-Alias h          get-history
Set-Alias history    get-history
Set-Alias kill       stop-process
Set-Alias lp         out-printer
Set-Alias ls         get-childitem
Set-Alias mount      new-mshdrive
Set-Alias mv         move-item
Set-Alias popd       pop-location    -Option AllScope
Set-Alias ps         get-process
Set-Alias pushd      push-location   -Option AllScope
Set-Alias pwd        get-location
Set-Alias r          invoke-history
Set-Alias rm         remove-item
Set-Alias rmdir      remove-item
Set-Alias echo       write-output    -Option AllScope

Set-Alias cls        clear-host
Set-Alias chdir      set-location
Set-Alias copy       copy-item       -Option AllScope
Set-Alias del        remove-item     -Option AllScope
Set-Alias dir        get-childitem   -Option AllScope
Set-Alias erase      remove-item
Set-Alias move       move-item       -Option AllScope
Set-Alias rd         remove-item
Set-Alias ren        rename-item
Set-Alias set        set-variable
Set-Alias type       get-content
Set-Alias grep       findstr
Set-Alias mc 'C:\Program Files (x86)\Midnight Commander\mc.exe'
Set-Alias which       get-command

function RefreshPath {
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") +
    ";" +
    [System.Environment]::GetEnvironmentVariable("Path", "User")
}

### phelp // outputs your profiles aliases and functions
function phelp() {
    Get-Content $PROFILE | Select-String -Pattern "New-Alias|###" | Select-String -Pattern "Get-Content" -NotMatch
}
### open // open explorer.exe in current directory
function open {
    param(
        [string]$dir = (Get-Location).Path
    )
    if (!$dir) {
        explorer.exe $dir
    }
    else {
        explorer.exe $dir
    }
}

### serve // create a python web file server in the directory you want
function serve {
    param(
        [string]$dir,
        [int]$port = 8000
    )
    if (!$dir) {
        Write-Host "Usage: fileserv [dir]"
        return
    }
    if ($port -lt 1 -or $port -gt 65535) {
        Write-Host 'Port must be between 1 and 65535'
        return
    }
    else {
        $localip = myip
        $publicip = pubip
        Write-Host "${localip}:${port}" ; Write-Host "${publicip}:${port}" ; python -m http.server --directory "${dir}" "${port}"
    }
}

function show_local_ip {
    param([string]$copy)
    if ($copy.ToLower() -eq 'copy') {
        (Get-NetIPConfiguration | Where-Object {
            $null -ne $_.IPv4DefaultGateway -and
            $_.NetAdapter.Status -ne "Disconnected"
        }).IPv4Address.IPAddress | clip
    }
    (Get-NetIPConfiguration |
        Where-Object {
            $null -ne $_.IPv4DefaultGateway -and
            $_.NetAdapter.Status -ne "Disconnected"
        }).IPv4Address.IPAddress
}
function show_public_ip {
    param([string]$copy)
    if ($copy.ToLower() -eq 'copy') {
        curl.exe -s icanhazip.com | clip
    }
    curl.exe -s icanhazip.com
}
### upfile // upload a file to 0x0.st
function upfile {
    param([string]$file)
    if (!$file) {
        Write-Host "Usage: upfile <file>"
    }
    else {
        curl.exe -F "file=@$file" https://0x0.st
    }
}
### ffaudio // record audio from choosen mic
function ffaudio {
    $c = -1
    [System.Collections.ArrayList]$micList = @()
    Get-PnpDevice | ForEach-Object {
        if ($_.Class -eq "AudioEndpoint" -and $_.Status -eq "OK") {
            ++$c
            Write-Host $c $_.FriendlyName
            $micList.Add($_.FriendlyName) > $null
        }
    }
    do {
        [int]$choice = Read-Host "Choose a mic (0 - $c)"
    } while ($choice -gt $c -or $choice -lt 0)
    $mic = $micList[$choice]
    $time = (Get-Date).ToString("yyyy_MM_dd_HH_mm_ss")
    $fileName = "\audio_$time.m4a"
    $filePath = $env:TEMP + $fileName
    Write-Output $filePath
    ffmpeg  -hide_banner -loglevel warning -y -f dshow -i audio=$mic $filePath
    Start-Process -FilePath C:\Windows\explorer.exe -ArgumentList "/select, ""$filePath"""
}

### sxsa // analyze your WinSXS directory
function sxsa() {
    # Note: as of Feb 2024, sudo only works on Windows Insider Preview
    sudo Dism.exe /Online /Cleanup-Image /AnalyzeComponentStore
}
### sxsc // clean your WinSXS directory
function sxsc() {
    # Note: as of Feb 2024, sudo only works on Windows Insider Preview
    sudo Dism.exe /online /Cleanup-Image /StartComponentCleanup /ResetBase
}

function help {
    Get-Help $args[0] | Out-Host -Paging
}

function man {
    Get-Help $args[0] | Out-Host -Paging
}

function mkdir {
    New-Item -type directory -Path $args
}

function md {
    New-Item -type directory -Path $args
}

function prompt {
    "PS " + $(Get-Location) + "> "
}

& {
    for ($i = 0; $i -lt 26; $i++) {
        $funcname = ([System.Char]($i + 65)) + ':'
        $str = "function global:$funcname { set-location $funcname } "
        Invoke-Expression $str
    }
}

function Copy-CurrentDirectory () {
    Get-Location | select -ExpandProperty Path | copy_to_clipboard
}

Set-Alias copy_current_path Copy-CurrentDirectory

function Copy-BranchName() {
    git branch --show-current | copy_to_clipboard
}


Set-Alias copy_branch_name       Copy-BranchName

<#
.SYNOPSIS
Converts windows path into a linux path and vice versa.
.DESCRIPTION
Converts windows path into a linux path and vice versa. Use WSL under the hood, so needs to be installed.
See docs wslpath docs for more information.
.PARAMETER path
The path to convert
.PARAMETER conversion
The direction of conversion windows->linux by default ('-u'). See docs wslpath docs for other options
.EXAMPLE
wslpath $(pwd | Select -ExpandProperty Path)
wslpath $Profile
wslpath $Profile '-w'
#>
function wslpath(
    [Parameter(Mandatory)]
    [string]
    $path,

    [ValidateSet('-u', '-w', '-m')]
    $conversion = '-u'
) {
    wsl 'wslpath' $conversion $path.Replace('\', '\\');
}

function Copy-LastCommand {
    if (Get-History) {
        if ($PSVersionTable.PSVersion.ToString() -match '5.1') {
            Set-Clipboard -Value (Get-History (Get-History | Select-Object -Last 1).Id -ErrorAction SilentlyContinue).CommandLine
        }
        else {
            (Get-History (Get-History | Select-Object -Last 1).Id).CommandLine | clip
        }
    }
    else {
        Write-Warning -Message 'No command history to copy.'
    }
}

Set-Alias copy_last_command Copy-LastCommand

function ListUsbDevices {
    Get-PnpDevice -PresentOnly | Where-Object { $_.InstanceId -match '^USB' }
}

if (($host.Name -eq 'ConsoleHost')) {
    Import-Module PSReadLine
    Set-PSReadLineOption -PredictionSource History
    Set-PSReadLineKeyHandler -Key UpArrow   -Function HistorySearchBackward
    Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
    # Set-PSReadLineKeyHandler -Key Tab -Function Complete
    Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
    Set-PSReadLineOption -HistorySearchCursorMovesToEnd
    Set-PSReadLineOption -Colors @{ InlinePrediction = '#F6546A' }
    if (($host.Version.Major -eq 7)) {
        Set-PSReadLineOption -PredictionViewStyle ListView
        Set-PSReadLineOption -EditMode Windows
    }
}

function prompt {
    "$([char]27)[37m[PowerShell " + $( $PSVersionTable.PSVersion.ToString()) + '] ' + $(Get-Location) +
    $(if ($NestedPromptLevel -ge 1) { '>>' }) + '> '
}

function vihosts {
    vim %SystemRoot%\system32\drivers\etc\hosts
}


