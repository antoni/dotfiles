
#!/usr/bin/env bash

# TODO: Enabling colors here causes indentation issues in some scripts output (like install.sh)

# declare -A colors

# colors[Reset_Color]='\033[0m' # Text color reset

# # Regular Colors
# colors[Black]='\033[0;30m'  # Black
# colors[Red]='\033[0;31m'    # Red
# colors[Green]='\033[0;32m'  # Green
# colors[Yellow]='\033[0;33m' # Yellow
# colors[Blue]='\033[0;34m'   # Blue
# colors[Purple]='\033[0;35m' # Purple
# colors[Cyan]='\033[0;36m'   # Cyan
# colors[White]='\033[0;37m'  # White

# # Bold
# colors[BoldBlack]='\033[1;30m'  # Black
# colors[BoldRed]='\033[1;31m'    # Red
# colors[BoldGreen]='\033[1;32m'  # Green
# colors[BoldYellow]='\033[1;33m' # Yellow
# colors[BoldBlue]='\033[1;34m'   # Blue
# colors[BoldPurple]='\033[1;35m' # Purple
# colors[BoldCyan]='\033[1;36m'   # Cyan
# colors[BoldWhite]='\033[1;37m'  # White

# # Underline
# colors[UnderlineBlack]='\033[4;30m'  # Black
# colors[UnderlineRed]='\033[4;31m'    # Red
# colors[UnderlineGreen]='\033[4;32m'  # Green
# colors[UnderlineYellow]='\033[4;33m' # Yellow
# colors[UnderlineBlue]='\033[4;34m'   # Blue
# colors[UnderlinePurple]='\033[4;35m' # Purple
# colors[UnderlineCyan]='\033[4;36m'   # Cyan
# colors[UnderlineWhite]='\033[4;37m'  # White

# # Background
# colors[On_Black]='\033[40m'  # Black
# colors[On_Red]='\033[41m'    # Red
# colors[On_Green]='\033[42m'  # Green
# colors[On_Yellow]='\033[43m' # Yellow
# colors[On_Blue]='\033[44m'   # Blue
# colors[On_Purple]='\033[45m' # Purple
# colors[On_Cyan]='\033[46m'   # Cyan
# colors[On_White]='\033[47m'  # White

# # High Intensity
# colors[HighIntensityBlack]='\033[0;90m'  # Black
# colors[HighIntensityRed]='\033[0;91m'    # Red
# colors[HighIntensityGreen]='\033[0;92m'  # Green
# colors[HighIntensityYellow]='\033[0;93m' # Yellow
# colors[HighIntensityBlue]='\033[0;94m'   # Blue
# colors[HighIntensityPurple]='\033[0;95m' # Purple
# colors[HighIntensityCyan]='\033[0;96m'   # Cyan
# colors[HighIntensityWhite]='\033[0;97m'  # White

# # Bold High Intensity
# colors[HighIntensityBoldBlack]='\033[1;90m'  # Black
# colors[HighIntensityBoldRed]='\033[1;91m'    # Red
# colors[HighIntensityBoldGreen]='\033[1;92m'  # Green
# colors[HighIntensityBoldYellow]='\033[1;93m' # Yellow
# colors[HighIntensityBoldBlue]='\033[1;94m'   # Blue
# colors[HighIntensityBoldPurple]='\033[1;95m' # Purple
# colors[HighIntensityBoldCyan]='\033[1;96m'   # Cyan
# colors[HighIntensityBoldWhite]='\033[1;97m'  # White

# # High Intensity backgrounds
# colors[On_HighIntensityBlack]='\033[0;100m'  # Black
# colors[On_HighIntensityRed]='\033[0;101m'    # Red
# colors[On_HighIntensityGreen]='\033[0;102m'  # Green
# colors[On_HighIntensityYellow]='\033[0;103m' # Yellow
# colors[On_HighIntensityBlue]='\033[0;104m'   # Blue
# colors[On_HighIntensityPurple]='\033[0;105m' # Purple
# colors[On_HighIntensityCyan]='\033[0;106m'   # Cyan
# colors[On_HighIntensityWhite]='\033[0;107m'  # White

# # Usage:
# # color=${colors[$input_color]}
# # reset_color=${colors[Reset_Color]}

# # for color in "${!colors[@]}"
# # do
# # echo -e "$color = ${colors[$color]}I love you$reset_color"
# # done
