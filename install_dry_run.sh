#!/bin/bash

set -euo pipefail

# This is a dry-run script. It will not execute any commands that modify
# your system. Instead, it will print the commands that it would have run.

# my default dotfiles config dir
DEFAULT_DOTFILES_CONFIG_DIR="$HOME/.config"

createDirs() {
  echo "--- dry run: creating directories ---"
  echo "mkdir -p \"$DEFAULT_DOTFILES_CONFIG_DIR\""
  echo "------------------------------------"
}

installBrew() {
  echo "--- dry run: homebrew installation ---"
  if ! command -v "brew" &> /dev/null;
 then
    echo "you cannot brew, as the package is not found! let us pour the joy! 🍻"
    echo "/bin/bash -c ""\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
  else
    echo "homebrew is already installed."
  fi

  echo "lets check the packages from Brewfile!"
  brew bundle check
  echo "--------------------------------------"
}

installXcode() {
  echo "--- dry run: Xcode Command Line Tools installation ---"
  if ! xcode-select --print-path &> /dev/null;
 then
    echo "xcode-select --install"
    echo "until xcode-select --print-path &> /dev/null; do sleep 5; done"
    echo "sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer"
    echo "sudo xcodebuild -license"
  else
    echo "Xcode Command Line Tools are already installed."
  fi
  echo "----------------------------------------------------"
}

symlinkDotfiles() {
  echo "--- dry run: symlinking dotfiles ---"
  declare -a DIRS_TO_SYMLINK=(
    "alacritty"
    "emacs"
    "mise"
    "nvim"
    "skhd"
    "yabai"
    "tmux"
    "zsh"
    "karabiner"
  )

  for dir in "${DIRS_TO_SYMLINK[@]}"; do
    SOURCE_DIR="$(pwd)/$dir"
    TARGET_DIR="$DEFAULT_DOTFILES_CONFIG_DIR/$dir"

    if [ -e "$TARGET_DIR" ]; then
        echo "backing-up existing $TARGET_DIR to $TARGET_DIR.bak"
        echo "mv \"$TARGET_DIR\" \"$TARGET_DIR.bak\""
    fi
    echo "ln -sv \"$SOURCE_DIR\" \"$TARGET_DIR\""
  done
  echo "------------------------------------"
}


main() {
  read -p "get ready to install, are you sure want to dry-run padulkemid's dotfiles ? (y/n) " -r
  echo 
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    printf "📂 creating directories\n"
    createDirs

    printf "🛠 installing Xcode Command Line Tools\n"
    installXcode

    printf "🔗 symlinking dotfiles\n"
    symlinkDotfiles

    printf "🍺 installing Homebrew and its packages\n"
    installBrew

    echo
    printf "get ready for the real deal... \n"
    echo
  else
    printf "okay then, take your time!\n"
    exit 1
  fi
}

main
