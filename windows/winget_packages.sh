#!/usr/bin/env bash

WINGET_ALIAS="powershell.exe /c winget.exe"
WINGET_COMMAND_LIST="$WINGET_ALIAS list"
WINGET_COMMAND_INSTALL="$WINGET_ALIAS install --accept-source-agreements  --accept-package-agreements --exact --id "

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
	Piriform.Recuva
)

CONFERENCE_SOFTWARE=(
	SlackTechnologies.Slack
	Microsoft.TeamsExploration
	Zoom.Zoom
	Cisco.WebexTeams
)

MAY_HAVE=(
	GNU.Emacs
	Valve.Steam
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
	BraveSoftware.BraveBrowser
	Microsoft.dotNetFramework
	Microsoft.dotnet
	alcpu.CoreTemp
	Yubico.YubikeyManager
	Oracle.VirtualBox
	VMware.WorkstationPlayer
	TorProject.TorBrowser
	Surfshark.SurfsharkVPN
	NordVPN.NordVPN
	Xming.Xming
	Greenshot.Greenshot
	CrystalDewWorld.CrystalDiskMark # disk benchmark
	Discord.Discord
	Mozilla.Firefox.DeveloperEdition
	ProtonTechnologies.ProtonVPN
	ExpressVPN.ExpressVPN
	Microsoft.OfficeDeploymentTool
	Grammarly.ForOffice
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
	winget install -e --id Mojang.MinecraftLauncher
	winget install -e --id Microsoft.AzureFunctionsCoreTools
	winget install -e --id Microsoft.AzureDataStudio
	winget install -e --id Microsoft.AzureDataStudio.Insiders
	winget install -e --id Microsoft.AzureCosmosEmulator
	winget install -e --id Microsoft.azure-iot-explorer
	winget install -e --id Microsoft.AzureStorageExplorer
	winget install -e --id Microsoft.AzureCLI
	winget install -e --id Microsoft.AzureDataCLI
	winget install -e --id Microsoft.AzureStorageEmulator

)

#for package in ${MUST_HAVE[@]}; do
#    ${WINGET_COMMAND} $package;
#done;
#for package in ${MAY_HAVE[@]}; do
#    ${WINGET_COMMAND} $package;
#done;
#for package in ${MUST_HAVE[@]}; do
#    ${WINGET_COMMAND} $package;
#done;

package_not_installed=$(${WINGET_COMMAND_LIST} Some.NonExistent.PackageName)

function install_if_not_installed() {
	local package_name="$1"

	is_package_installed=$(${WINGET_COMMAND_LIST} "$package_name")

	if [[ "$is_package_installed" == "$package_not_installed" ]]; then
		echo "NOT Installed: ""$package_name"

		${WINGET_COMMAND_INSTALL} "$package_name"
	fi
}

for package in "${MUST_HAVE[@]}"; do
	install_if_not_installed "$package"
done
for package in "${MAY_HAVE[@]}"; do
	install_if_not_installed "$package"
done
for package in "${MUST_HAVE[@]}"; do
	install_if_not_installed "$package"
done
