# Run:
# powershell.exe -NoLogo -ExecutionPolicy Bypass -File .\SetFileTypeAssociations.ps1
# Source SFTA
. .\SFTA.ps1

Write-Output "Setting default file associations"

Set-FTA ChromeHTML .html
# Set-FTA for PDF won't work, see: https://github.com/DanysysTeam/PS-SFTA/issues/36#issuecomment-2295308671
# Set-FTA ChromeHTML .pdf
Set-FTA  IrfanView.png .png
Set-FTA  IrfanView.jpg .jpg
Set-FTA  IrfanView.jpg .jpeg
Set-FTA  IrfanView.gif .gif
Set-FTA  VLC.mp3.Document .mp3
Set-FTA  VLC.mp4.Document .mp4
Set-FTA  VLC.avi.Document .avi
Set-FTA  VLC.avi.Document .mkv
Set-FTA  Applications\notepad++.exe .sh
Set-FTA  Applications\notepad++.exe .txt
Set-FTA  Applications\notepad++.exe .xml
Register-FTA "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" .ps1 -Icon "shell32.dll,100"
Set-FTA  ChromeHTML .svg
Set-FTA  VSCode.ts .ts


