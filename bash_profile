source $HOME/.common_profile.sh

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
#export SDKMAN_DIR="/Users/antek.ff_fra/.sdkman"
#[[ -s "/Users/antek.ff_fra/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/antek.ff_fra/.sdkman/bin/sdkman-init.sh"
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
