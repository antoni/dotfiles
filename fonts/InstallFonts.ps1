$fonts = (New-Object -ComObject Shell.Application).Namespace(0x14)
Get-ChildItem -Recurse -include *.ttf | % { $fonts.CopyHere($_.fullname) }
