# 🌙 Silvermoon

this is my current dotfiles, its kinda bit different from my old one,
and my Artix. all of this dotfiles are linked and not intended to place them
straight into their respected config folder ( e.g : `~/.config` ) because the
symlinks all already done.  

always put everything CLI first. I use `nvim` to code and `emacs` to journal
and document my work, etc. (org mode is greater than markdown)

# 📷 Pics

![nvim_screen](https://i.imgur.com/nRuWr9I.png)

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
- [x] Apple Silicon: `install.sh` now `brew shellenv` + CLT-only xcode-select (plugins still review 1-by-1)
- [x] `yabai` doesn't do excellent stuff with `csrutil` enabled (its ok though) — need partial SIP + `boot-args=-arm64e_preview_abi`
- [x] post-Tahoe checklist: `~/Work/tahoe-post-upgrade-notes.txt`
- [x] minimal install works
