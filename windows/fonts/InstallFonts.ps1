$fonts = (New-Object -ComObject Shell.Application).Namespace(0x14)

Get-ChildItem -Recurse -Include *.ttf | % { $fonts.CopyHere($_.fullname) }






