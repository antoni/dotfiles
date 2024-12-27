# Installation

## macOS

1. Make sure "Allow user to administer this computer" in System Preferences → Users & Groups is checked for the current user
2. Get Homebrew (it will install macOS Command Line Tools, like git, as well):

```console
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

3. Install newer version of Bash

```console
echo >> /Users/a/.zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/a/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

brew install bash

sudo sh -c 'echo /opt/homebrew/bin/bash >> /etc/shells'
chsh -s /opt/homebrew/bin/bash
bash
```

3. Get the dotfiles:

```console
git clone https://github.com/antoni/dotfiles.git ~/dotfiles
```

4. Install:

```console
~/dotfiles/mac/install.sh
~/dotfiles/symlink.sh
~/dotfiles/mac/defaults.sh # Configure the system
```

## Useful links

- [Automatically reattach tmux session using iTerm2](https://coderwall.com/p/-mumdg/automatically-reattach-tmux-session-using-iterm2): Open iTerm2's preferences, then select the 'Profiles' tab, and finally the 'General' pane. In the 'Command' section locate the 'Send text at start:' option and put in this command, substituting your session name for base.

```console
tmux attach -t base || tmux new -s base
```

## Other dotfiles repositories

- [mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles)
- https://github.com/CMCDragonkai/.dotfiles-windows

## TODO

* macOS: add Rosetta 2 instalation step:

```console
sudo softwareupdate --install-rosetta --agree-to-license
```

## ChatGPT prompts

1.

```text
Write this Bash command so that it uses only command flags with double hyphen (wherever possible):
<bash command goes here>
```

2.

```text
Add comment to the top of this Bash function:
<bash command goes here>



## Credits

- [ur0n2/dotfiles-for-windows](https://github.com/ur0n2/dotfiles-for-windows), where I have taken few scripts/aliases/ideas from
```
