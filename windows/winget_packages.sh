#!/usr/bin/env bash
source "$HOME"/dotfiles/windows/winget_utils.sh

function int_signal_handler() {
	printf "\nQuitting winget packages install... You will have to do cleanup manually\n"
	exit
}

function setup_int_handler() {
	stty -echoctl # hide ^C

	trap int_signal_handler INT
}

setup_int_handler

# MUST_HAVE=(
# 	tailscale.tailscale
#   WhatsApp.WhatsApp
# 	)

MUST_HAVE=(
	Microsoft.VisualStudioCode
	Mozilla.Firefox
	Mozilla.Firefox.DeveloperEdition
	Google.Chrome
	PuTTY.PuTTY
	vim.vim
	Neovim.Neovim
	Greenshot.Greenshot
	Git.Git
	GitHub.cli
	GitHub.GitLFS
	Python.Python.3.12
	# reinstalling this doesn't work unattended (brings focus always).
	# also, I'm only using it inside WSL
	# ImageMagick.ImageMagick
	Docker.DockerDesktop
	Notepad++.Notepad++
	Oracle.JavaRuntimeEnvironment
	IrfanSkiljan.IrfanView
	Espanso.Espanso
	7zip.7zip
	Telegram.TelegramDesktop
	OpenWhisperSystems.Signal
	Yarn.Yarn
	WhatsApp.WhatsApp
	Microsoft.PowerToys
	Microsoft.VisualStudioCode
	vim.vim
	VideoLAN.VLC
	Gyan.FFmpeg
	Google.CloudSDK
	Microsoft.WindowsTerminal.Preview
	Microsoft.DotNet.SDK.10
	Microsoft.DotNet.DesktopRuntime.10
	Microsoft.DotNet.Runtime.10
	Discord.Discord
	RProject.R
	IDRIX.VeraCrypt
	Rclone.Rclone
	WinFsp.WinFsp
	qBittorrent.qBittorrent
	Microsoft.PowerShell
	Spotify.Spotify
	tailscale.tailscale
)

CONFERENCE_SOFTWARE=(
	SlackTechnologies.Slack
	Microsoft.Teams
	Zoom.Zoom
	# Cisco.WebexTeams
)

GAMES=(
	Valve.Steam
	# ElectronicArts.EADesktop
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
	DigitalScholar.Zotero
	geeksoftwareGmbH.PDF24Creator
	Brave.Brave
	ByteDance.CapCut
	WiresharkFoundation.Wireshark
	Amazon.AWSCLI
	Audacity.Audacity
	Piriform.Recuva
	Zeit.Hyper
	GnuPG.Gpg4win
	GnuPG.GnuPG
	JetBrains.IntelliJIDEA.Ultimate
	JetBrains.IntelliJIDEA.Community
	Rufus.Rufus
	Hex-Rays.IDA.Free
	Figma.Figma
	AnyDeskSoftwareGmbH.AnyDesk
	marha.VcXsrv
	gsass1.NTop
	CHIRPSoftware.CHIRP-next
	Yarn.Yarn
	RaspberryPiFoundation.RaspberryPiImager
	BraveSoftware.BraveBrowser
	Rustlang.Rustup
	Google.Chrome.Canary
	DeepL.DeepL
	alcpu.CoreTemp
	Yubico.YubikeyManager
	Mega.MEGASync
	Oracle.VirtualBox
	VMware.WorkstationPlayer
	TorProject.TorBrowser
	RaspberryPiFoundation.RaspberryPiImager
	Insecure.Nmap
	Loom.Loom
	OpenVPNTechnologies.OpenVPNConnect
	MullvadVPN.MullvadVPN
	Surfshark.SurfsharkVPN
	NordVPN.NordVPN
	ProtonTechnologies.ProtonVPN
	ExpressVPN.ExpressVPN
	Jigsaw.OutlineManager
	ZeroTier.ZeroTierOne
	mRemoteNG.mRemoteNG
	Xming.Xming
	Mikrotik.TheDude
	Elgato.ControlCenter            # control of Elgato Key Light Mini
	CrystalDewWorld.CrystalDiskMark # disk benchmark
	NVAccess.NVDA
	Mozilla.Firefox.DeveloperEdition
	Nextcloud.NextcloudDesktop
	Balena.Etcher
	Microsoft.OfficeDeploymentTool
	Grammarly.ForOffice
	Inkscape.Inkscape
	TorProject.TorBrowser
	flux.flux
	Postman.Postman
	Opera.Opera
	Opera.OperaGX
	AntibodySoftware.WizTree
	WinDirStat.WinDirStat
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
	GIMP.GIMP
	SublimeHQ.SublimeText.3
	Alacritty.Alacritty
	Mirantis.Lens
	Telerik.Fiddler.Everywhere
	Hashicorp.Vagrant
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
	Autodesk.EAGLE
	Audacity.Audacity
)

# In case there is a need to accept some new Terms of Transaction
# ${WINGET_ALIAS} list

# Needs to be executed before every install/update
# if this doesn't help, try:
# winget source reset --force
${WINGET_ALIAS} source update

function resolve_winget_id() {
	local query="$1"

	pwsh.exe -NoProfile -Command "
		\$ErrorActionPreference = 'Stop'

		function D([string]\$msg) {
			[Console]::Error.WriteLine('[resolve_winget_id] ' + \$msg)
		}

		D('query = $query')

		# Extract last segment after dot
		\$needle = ('$query' -split '\.')[-1]
		D('needle = ' + \$needle)

		function Search-Winget([string]\$q) {
			D('running: winget search ' + \$q)
			winget search \$q 2>&1
		}

		# First attempt: full query
		\$raw = Search-Winget '$query'

		# If winget says "No package found", retry with needle
		if (\$raw -match 'No package found matching input criteria') {
			D('no results for full query, retrying with needle')
			\$raw = Search-Winget \$needle
		}

		D('raw winget output:')
		\$raw | ForEach-Object { [Console]::Error.WriteLine('  ' + \$_) }

		# Remove headers, separators, and error lines
		\$results = \$raw |
			Where-Object { \$_ -match '\S' } |
			Where-Object { \$_ -notmatch '^-{3,}' } |
			Where-Object { \$_ -notmatch '^Name\s+Id\s+Version' } |
			Where-Object { \$_ -notmatch '^No package found' } |
			ConvertFrom-String -PropertyNames Name,Id,Version,Match,Source

		if (-not \$results) {
			D('No parsed rows')
			exit 1
		}

		D('parsed rows = ' + \$results.Count)

		D('parsed candidates (Name | Id | Source):')
		\$results | ForEach-Object {
			[Console]::Error.WriteLine(('  {0} | {1} | {2}' -f \$_.Name, \$_.Id, \$_.Source))
		}

		# Exact Name match (case-insensitive) against needle
		\$match = \$results |
			Where-Object {
				\$_.Name -and
				\$_.Name.Equals(\$needle, 'InvariantCultureIgnoreCase')
			} |
			Select-Object -First 1

		if (-not \$match) {
			D('NO MATCH found for Name == needle')
			exit 1
		}

		D('MATCH: Name=' + \$match.Name + ' Id=' + \$match.Id)

		Write-Output \$match.Id
	"
}

function install_if_not_installed() {
	local package_name="$1"

	if $WINGET_ALIAS list | grep -qi "$package_name"; then
		echo "Already installed: $package_name"
		return 0
	fi

	echo "Installing winget package: $package_name"

	# First attempt: exact ID
	if ${WINGET_COMMAND_INSTALL} "$package_name"; then
		return 0
	fi

	echo "Exact ID failed, resolving via search..."

	local resolved_id
	resolved_id=$(resolve_winget_id "$package_name" | tr -d '\r')

	if [[ -z "$resolved_id" ]]; then
		echo "ERROR: Package not found via winget search: $package_name" >&2
		exit 1
	fi

	echo "Resolved ID: $resolved_id"

install_output=$(${WINGET_COMMAND_INSTALL} "$resolved_id" 2>&1)

status=$?

if [[ $status -eq 0 ]]; then
	return 0
fi

if echo "$install_output" | grep -qi "already installed"; then
	echo "Already installed (winget reported): $resolved_id"
	return 0
fi

echo "$install_output" >&2
echo "ERROR: Failed to install resolved package: $resolved_id" >&2
exit 1
}


for package in "${MUST_HAVE[@]}"; do
	printf "Installing: %s\n" "$package"
	install_if_not_installed "$package"
done
# for package in "${MAY_HAVE[@]}"; do
# 	install_if_not_installed "$package"
# done
# for package in "${CONFERENCE_SOFTWARE[@]}"; do
# 	install_if_not_installed "$package"
# done
# for package in "${GAMES[@]}"; do
# 	install_if_not_installed "$package"
# done
