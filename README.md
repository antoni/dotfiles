# Installation

## macOS

1.  Make sure "Allow user to administer this computer" in System Preferences → Users & Groups is checked for the current user
    Get Homebrew (it will install macOS Command Line Tools, like Git, as well):

        ```console
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        ```

2.  Get the dotfiles:

    ```console
    ssh-keyscan github.com >> ~/.ssh/known_hosts; git clone git@github.com:antoni/dotfiles.git ~/dotfiles
    ```

3.  Install:

```console
    ~/dotfiles/mac/install.sh
    ~/dotfiles/symlink.sh
    ~/dotfiles/mac/defaults.sh # Configure the system
```

## Useful links

- [Automatically reattach tmux session using iTerm2](https://coderwall.com/p/-mumdg/automatically-reattach-tmux-session-using-iterm2): `tmux attach -t base || tmux new -s base`

## Other dotfiles repositories

- [mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles)
- https://github.com/CMCDragonkai/.dotfiles-windows

## Ideas

- config.sh: (1) Make it per machine, (2) Get username dynamically: powershell.exe -NoLogo '$env:UserName', (it takes time, return value should be stored somewhere)
- macOS: replace sleepwatcher with [custom LaunchAgent](https://github.com/alb12-la/KBOS/tree/master)
- custom winget repository
- Move from Chrome to Chromium
- custom Chromium build for Win (like: https://github.com/Hibbiki/chromium-win64)
- Add Windows install script based on (fly.io)[https://fly.io/]: https://fly.io/install.ps1
- Use this for Windows machine prov.?: https://github.com/ntdevlabs/tiny11builder
- Windows: automatic custom keyboard layout
- macOS: toggle Bluetooth on lid open/close
- [save PowerToys config (Windows)](https://github.com/microsoft/PowerToys/issues/3004#issuecnt-638686691)
- [copy some patterns from this repo?](https://github.com/ur0n2/dotfiles-for-windows)
- Linux/WSL: [write Windows on USB](https://github.com/WoeUSB/WoeUSB-ng)
- technology badges (a la [dolanmiu](https://github.com/dolanmiu))
- sysctl.conf: https://stackoverflow.com/a/55763478/963881
- windows minimize windows at startup
- [jq in place](https://stackoverflow.com/questions/36565295/jq-to-replace-text-directly-on-file-like-sed-i?noredirect=1&lq=1)
- add to Windows install scripts: `cp -r wallpapers /mnt/c/Users/vivob`

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
