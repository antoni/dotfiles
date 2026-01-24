Install-PackageProvider NuGet -Force;
Set-PSRepository PSGallery -InstallationPolicy Trusted

Install-Module -Name PowerShellGet -Force

exit
