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

## Thanks to

- @ur0n2 for [ur0n2/dotfiles-for-windows](https://github.com/ur0n2/dotfiles-for-windows), where I have taken few scripts/aliases/ideas from

## TODO

- [save PowerToys config (Windows)](https://github.com/microsoft/PowerToys/issues/3004#issuecnt-638686691)
- [copy some patterns from this repo?](https://github.com/ur0n2/dotfiles-for-windows)
