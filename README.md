# 🌙 Silvermoon

this is my current dotfiles, its kinda bit different from my old one,
and my Artix. all of this dotfiles are linked and not intended to place them
straight into their respected config folder ( e.g : `~/.config` ) because the
symlinks all already done.  

# 📷 Pics

![prompt screen](https://i.imgur.com/H7EJkwn.png)
![emacs config](https://i.imgur.com/1iPsVPM.png)

# 🏃🏻‍♂️ 💨 Running the Script

1. change to this directory
2. run the script
3. ???
4. profit!

you can try to run the dry-run first:

```console
padulkemid@silvermoon: ~/.dotfiles $ chmod +x ./install_dry_run.sh
padulkemid@silvermoon: ~/.dotfiles $ ./install_dry_run.sh
```

or just yolo:

```console
padulkemid@silvermoon: ~/.dotfiles $ chmod +x ./install.sh
padulkemid@silvermoon: ~/.dotfiles $ ./install.sh
```

the installer will still dry-run everything so you're not mistaken, if there is
some step missing you could fix it right away!


# 🗒 Progress

- [x] update install script
- [x] doesnt work in M chip, need to reconfigure (to cater this, please run down all the plugins and review it 1-by-1)
- [x] `yabai` doesn't do excellent stuff with `csrutil` enabled (its ok though)
- [x] minimal install works
