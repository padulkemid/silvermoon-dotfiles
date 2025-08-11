#!/bin/bash

set -euo pipefail

# my default dotfiles config dir
DEFAULT_DOTFILES_CONFIG_DIR="$HOME/.config"

createDirs() {
  mkdir -p "$DEFAULT_DOTFILES_CONFIG_DIR"
}

installBrew() {
  if ! command -v "brew" &> /dev/null;
  then
    printf "you cannot brew, as the package is not found! let us pour the joy! 🍻"

    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  fi

  printf "lets install all the packages!"
  brew bundle
}

installXcode() {
  if ! xcode-select --print-path &> /dev/null;
  then
    xcode-select --install

    until xcode-select --print-path &> /dev/null;
    do
      sleep 5
    done

    sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer
    sudo xcodebuild -license
  fi
}

symlinkDotfiles() {
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
        echo "Backing up existing $TARGET_DIR to $TARGET_DIR.bak"
        mv "$TARGET_DIR" "$TARGET_DIR.bak"
    fi
    ln -sv "$SOURCE_DIR" "$TARGET_DIR"
  done
}


main() {
  echo "--- running the dry-run script first to show planned actions ---"
  chmod +x ./install_dry_run.sh

  ./install_dry_run.sh

  ASK_COUNT=0
  while [[ ASK_COUNT -lt 3 ]]; do
    read -p "are you absolutely sure you want to proceed with the installation? (yes/no) " -r
    echo

    if [[ $REPLY =~ ^[Yy][Ee][Ss]$ ]]; then
      ASK_COUNT=$((ASK_COUNT + 1))
      printf "confirmation %s of 3! \n" "$ASK_COUNT"
    elif [[ $REPLY =~ ^[Nn][Oo]$ ]]; then
      printf "installation aborted by user.\n"
      exit 1
    else
      printf "invalid input. Please enter 'yes' or 'no'.\n"
    fi
  done
  
  printf "confirmation received. starting installation...\n"
  printf "📂 creating directories\n"
  createDirs

  printf "🛠 installing Xcode Command Line Tools\n"
  installXcode

  printf "🔗 symlinking dotfiles\n"
  symlinkDotfiles

  printf "🍺 installing Homebrew and its packages\n"
  installBrew

  printf "after this you should configure your git config, mise config, and yabai ( extra steps on macOS Big Sur+ )\n"
  printf "also don't forget to install tmp (tmux), oh-my-zsh, and several stuff...\n"
  printf "Again, check 1-by-1 for breaking change!\n"
  printf "Thank you! \n"

  exit 0
}

main
