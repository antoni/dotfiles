# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

source $HOME/dotfiles/common_rc.sh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="antoni"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
docker
fzf-zsh-plugin
zsh-autosuggestions
zsh-syntax-highlighting
virtualenv
zsh-yarn-completions
)

# User configuration

# export PATH="$HOME/.rvm/gems/ruby-2.1.5/bin:$HOME/.rvm/gems/ruby-2.1.5@global/bin:$HOME/.rvm/rubies/ruby-2.1.5/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:~/yasara:$HOME/.rvm/bin:$HOME/opt/yasara:$HOME/.rvm/bin"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Disable Ctrl+S in a terminal (to use it inside Vim)
# http://askubuntu.com/a/359338/342465
stty stop undef

# This will prevent ZSH to print an error when no match can be found.
unsetopt nomatch

# xmodmap .speedswapper

# Execute ls after cd
# chpwd() ls

# Ignore case when 'ls'
unsetopt CASE_GLOB

# See: http://www.johnhawthorn.com/2012/09/vi-escape-delays/
KEYTIMEOUT=1

unsetopt correct_all

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Fix: https://github.com/zsh-users/zsh-autosuggestions/issues/141#issuecomment-210615799
zstyle ':bracketed-paste-magic' active-widgets '.self-*'

# Print current directory contents and 'git status' on Enter
my-accept-line () {
# check if the buffer does not contain any words
if [ ${#${(z)BUFFER}} -eq 0 ]; then
    # put newline so that the output does not start next
    # to the prompt
    echo
    # check if inside git repository
    if git rev-parse --git-dir > /dev/null 2>&1 ; then
        # if so, execute `git status' and `ls'
        ls
        echo ""
        git --no-pager status
    else
        # else run `ls'
        ls
    fi
fi
# in any case run the `accept-line' widget
zle accept-line
}
# create a widget from `my-accept-line' with the same name
zle -N my-accept-line
# rebind Enter, usually this is `^M'
bindkey '^M' my-accept-line

# autojump
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# Collect executed commands statistics
preexec () {
  local -r last_command_full="$history[$HISTCMD]"

 if echo $last_command_full | grep --quiet --ignore-case TOKEN; then
   return
 fi

  local -r last_command_binary="${last_command_full%% *}"
  printf '"%s","%s","%s"\n' \
      "$last_command_binary" \
      "$last_command_full" \
      "$(date_iso_8601)" >> \
      ~/usage_statistics.txt
}

# https://docs.brew.sh/Shell-Completion
if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

    autoload -Uz compinit
    compinit
fi

# retrieves and runs last command
function run-again {
    # get previous history item
    zle up-history
    # confirm command
    zle accept-line
}

# run-again widget from function of the same name
zle -N run-again

# bind widget to Ctrl+X in viins mode
bindkey -M viins '^B' run-again
# bind widget to Ctrl+X in vicmd mode
bindkey -M vicmd '^B' run-again

# Add .NET Core SDK tools
export PATH="$PATH:/Users/${WINDOWS_USERNAME}/.dotnet/tools"

#export VOLTA_HOME="$HOME/.volta"
#export PATH="$VOLTA_HOME/bin:$PATH"

# Moving between words in iTerm
bindkey "[D" backward-word
bindkey "[C" forward-word
bindkey "^[a" beginning-of-line
bindkey "^[e" end-of-line

# GNU utils (GNU grep, etc.)
PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

export BUN_INSTALL="$HOME/antoni/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# pnpm
export PNPM_HOME="/home/antoni/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export PATH=$PATH:$JAVA_HOME/bin

# export $(dbus-launch)
# export LIBGL_ALWAYS_INDIRECT=1
export WSL_HOST=$(tail -1 /etc/resolv.conf | cut -d' ' -f2)
# export DISPLAY=$WSL_HOST:0

# export WSL_HOST=$(tail -1 /etc/resolv.conf | cut -d' ' -f2)
# export ADB_SERVER_SOCKET=tcp:$WSL_HOST:5037
# export WSL_HOST=127.0.0.1
# export WSL_HOST=localhost
export ADB_SERVER_SOCKET=tcp:$WSL_HOST:5037

export ANDROID_HOME=$HOME/Android
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

# bun completions
[ -s "/home/antoni/antoni/.bun/_bun" ] && source "/home/antoni/antoni/.bun/_bun"

# https://github.com/cdown/sshrc
compdef sshrc=ssh
