# Installation

## macOS

1.  Make sure "Allow user to administer this computer" in System Preferences → Users & Groups is checked for the current user
    Get Homebrew (it will install macOS Command Line Tools, like Git, as well):

        ```shell
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        ```

2.  Get the dotfiles:

    ```shell
    ssh-keyscan github.com >> ~/.ssh/known_hosts; git clone git@github.com:antoni/dotfiles.git ~/dotfiles
    ```

3.  Install:

```shell
    ~/dotfiles/mac/install.sh
    ~/dotfiles/symlink.sh
    ~/dotfiles/mac/defaults.sh # Configure the system
```

## Useful links

- [Automatically reattach tmux session using iTerm2](https://coderwall.com/p/-mumdg/automatically-reattach-tmux-session-using-iterm2): `tmux attach -t base || tmux new -s base`

## Thanks to

- [ur0n2/dotfiles-for-windows](https://github.com/ur0n2/dotfiles-for-windows), where I have taken few scripts/aliases/ideas from

## Other dotfiles repositories

- [mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles)
- https://github.com/CMCDragonkai/.dotfiles-windows

## TODO

- Add Windows install script absed on (fly.io)[https://fly.io/]: https://fly.io/install.ps1
- Windows: automatyczne podpisanie custom keyboard layotu
- macOS: toggle Bluetooth on lid open/close
- [save PowerToys config (Windows)](https://github.com/microsoft/PowerToys/issues/3004#issuecnt-638686691)
- [copy some patterns from this repo?](https://github.com/ur0n2/dotfiles-for-windows)
- Linux/WSL: [write Windows on US](https://github.com/WoeUSB/WoeUSB-ng)
- technology badges (a la [dolanmiu](https://github.com/dolanmiu))
-
