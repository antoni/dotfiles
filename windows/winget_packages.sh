#!/usr/bin/env bash

# TODO: Add SIGINT handler

# winget.exe install --no-upgrade --accept-source-agreements --accept-package-agreements --exact --id chromium

# WINGET_ALIAS="powershell.exe /c winget.exe"
WINGET_ALIAS="winget.exe"
WINGET_COMMAND_LIST="$WINGET_ALIAS list"
# don't install an already installed package
# TODO: Add --no-upgrade once it's released
WINGET_COMMAND_INSTALL="$WINGET_ALIAS install --accept-source-agreements --accept-package-agreements --exact --id "

MUST_HAVE=(
	Google.Chrome
	chromium
	Wox.Wox
	putty
	PuTTY.PuTTY
	GitHub.cli
	vscode
	Python
	vim.vim
	Neovim.Neovim
	Greenshot.Greenshot
	GitHub.GitLFS
	ImageMagick.ImageMagick
	Microsoft.dotNetFramework
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
	JetBrains.IntelliJIDEA.Ultimate
	Microsoft.VisualStudioCode
	vim.vim
	GitHub.GitLFS
	VideoLAN.VLC
	Google.CloudSDK
	Microsoft.WindowsTerminal.Preview
	Piriform.Recuva
)

CONFERENCE_SOFTWARE=(
	SlackTechnologies.Slack
	Microsoft.TeamsExploration
	Zoom.Zoom
	Cisco.WebexTeams
)

GAMES=(
	RiotGames.LeagueOfLegends.EUNE
	Valve.Steam
	ElectronicArts.EADesktop
	EpicGames.EpicGamesLauncher
	RiotGames.Valorant.EU
)

MAY_HAVE=(
	GNU.Emacs
	WireGuard.WireGuard
	CPUID.HWMonitor
	Ghisler.TotalCommander
	Microsoft.WindowsTerminal
	OpenJS.NodeJS.LTS
	Amazon.AWSCLI
	Zeit.Hyper
	AnyDeskSoftwareGmbH.AnyDesk
	opticos.gwsl
	marha.VcXsrv
	RaspberryPiFoundation.RaspberryPiImager
	BraveSoftware.BraveBrowser
	Rustlang.Rustup
	Microsoft.dotNetFramework
	Microsoft.dotnet
	alcpu.CoreTemp
	Yubico.YubikeyManager
	IDRIX.VeraCrypt
	Oracle.VirtualBox
	VMware.WorkstationPlayer
	TorProject.TorBrowser
	Loom.Loom
	Surfshark.SurfsharkVPN
	NordVPN.NordVPN
	tailscale.tailscale
	mRemoteNG.mRemoteNG
	Xming.Xming
	CrystalDewWorld.CrystalDiskMark # disk benchmark
	Discord.Discord
	Mozilla.Firefox.DeveloperEdition
	Balena.Etcher
	ProtonTechnologies.ProtonVPN
	ExpressVPN.ExpressVPN
	Microsoft.OfficeDeploymentTool
	Grammarly.ForOffice
	Inkscape.Inkscape
	BinaryFortress.DisplayFusion
	TorProject.TorBrowser
	flux.flux
	Postman.Postman
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
	Files-Community.Files
	TranslucentTB.TranslucentTB
	Lexikos.AutoHotkey
	GIMP.GIMP
	SublimeHQ.SublimeText.3
	Alacritty.Alacritty
	FedericoTerzi.espanso
	Mirantis.Lens
	Telerik.Fiddler.Everywhere
	Hashicorp.Vagrant
	JetBrains.IntelliJIDEA.Ultimate
	Google.AndroidStudio
	RStudio.RStudio.OpenSource
	wez.wezterm
	JetBrains.DataSpell.EarlyPreview
	Microsoft.WindowsInstallationAssistant
	Mojang.MinecraftLauncher
	Microsoft.AzureFunctionsCoreTools
	Microsoft.AzureDataStudio
	Microsoft.AzureDataStudio.Insiders
	Microsoft.AzureCosmosEmulator
	Microsoft.azure-iot-explorer
	Microsoft.AzureStorageExplorer
	Microsoft.AzureCLI
	Microsoft.AzureDataCLI
	Microsoft.AzureStorageEmulator
)

# In case there is a need to accept some new Terms of Transaction
${WINGET_ALIAS} list

# Needs to be executed before every install/update
${WINGET_ALIAS} source update
# if this doesn't help, try:
# winget source reset --force

package_not_installed=$(${WINGET_COMMAND_LIST} Some.NonExistent.PackageName)

function install_if_not_installed() {
  # TODO: FIXME (currently just tries to install every package without checking)
	${WINGET_COMMAND_INSTALL} "$package_name"

  return
	local package_name="$1"

	is_package_installed=$(${WINGET_COMMAND_LIST} "$package_name")

	if [[ "$is_package_installed" == "$package_not_installed" ]]; then
		echo "NOT Installed: ""$package_name"

		${WINGET_COMMAND_INSTALL} "$package_name"
	fi
}

# for package in "${MUST_HAVE[@]}"; do
# 	install_if_not_installed "$package"
# done
for package in "${MAY_HAVE[@]}"; do
	install_if_not_installed "$package"
done
# for package in "${CONFERENCE_SOFTWARE[@]}"; do
# 	install_if_not_installed "$package"
# done
# for package in "${GAMES[@]}"; do
# 	install_if_not_installed "$package"
# done
