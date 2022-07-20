#!/usr/bin/env bash

WINGET_COMMAND="winget install --accept-source-agreements  --accept-package-agreements --exact --id "

MUST_HAVE=(
	chromium
	wox
	putty
	PuTTY.PuTTY
	GitHub.cli
	vscode
	Python
	vim.vim
	ImageMagick.ImageMagick
	Docker.DockerDesktop
	Notepad++.Notepad++
	Oracle.JavaRuntimeEnvironment
	IrfanSkiljan.IrfanView
	7zip.7zip
	mcmilk.7zip-zstd
	Telegram.TelegramDesktop
	OpenWhisperSystems.Signal
	OpenVPNTechnologies.OpenVPNConnect
	Yarn.Yarn
	Mozilla.Firefox
	WhatsApp.WhatsApp
	Microsoft.PowerToys
	NurgoSoftware.AquaSnap
	JetBrains.IntelliJIDEA.Ultimate
	Microsoft.VisualStudioCode
	vim.vim
	GitHub.GitLFS
	VideoLAN.VLC
	Google.CloudSDK
	Microsoft.WindowsTerminal.Preview
	winget install -e --id Piriform.Recuva
)

CONFERENCE_SOFTWARE=(
	SlackTechnologies.Slack
	Microsoft.TeamsExploration
	Zoom.Zoom
)

MAY_HAVE=(
	GNU.Emacs
	Valve.Steam
	Ghisler.TotalCommander
	Microsoft.WindowsTerminal
	OpenJS.NodeJS.LTS
	Amazon.AWSCLI
	Zeit.Hyper
	AnyDeskSoftwareGmbH.AnyDesk
	BraveSoftware.BraveBrowser
	Microsoft.dotNetFramework
	Microsoft.dotnet
	Oracle.VirtualBox
	TorProject.TorBrowser
	NordVPN.NordVPN
	Xming.Xming
	Greenshot.Greenshot
	Discord.Discord
	Mozilla.Firefox.DeveloperEdition
	ProtonTechnologies.ProtonVPN
	ExpressVPN.ExpressVPN
	Inkscape.Inkscape
	BinaryFortress.DisplayFusion
	TorProject.TorBrowser
	flux.flux
	Opera.Opera
	Opera.OperaGX
	AntibodySoftware.WizTree
	ArtifexSoftware.GhostScript
	wsltty
	msys2.msys2
	scottlerch.hosts-file-editor
	Streamlink.Streamlink
	Google.EarthPro
	TIDALMusicAS.TIDAL
	Amazon.Kindle
	Amazon.SendToKindle
	Autodesk.sketchbook
	IObit.DriverBooster9
	IObit.IObitSysInfo
	IObit.AdvancedSystemCare
	Files-Community.Files
	TranslucentTB.TranslucentTB
	Lexikos.AutoHotkey
	GIMP.GIMP
	SublimeHQ.SublimeText.3
	Alacritty.Alacritty
	FedericoTerzi.espanso
	Mirantis.Lens
	Telerik.Fiddler.Everywhere
	winget install -e --id Hashicorp.Vagrant
	winget install -e --id JetBrains.IntelliJIDEA.Ultimate
winget install -e --id Google.AndroidStudio
winget install -e --id RStudio.RStudio.OpenSource
winget install -e --id wez.wezterm
winget install --exact --id JetBrains.DataSpell.EarlyPreview
)
