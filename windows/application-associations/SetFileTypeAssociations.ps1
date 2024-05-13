. .\SFTA.ps1

Write-Output "Setting default file associations"

Set-FTA ChromeHTML .html
Set-FTA ChromeHTML .pdf
Set-FTA  IrfanView.png .png
Set-FTA  IrfanView.jpg .jpg
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