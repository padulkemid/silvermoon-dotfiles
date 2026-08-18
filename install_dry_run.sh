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

ensureBrewPath() {
  if command -v brew >/dev/null 2>&1; then
    return 0
  fi
  if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [ -x /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
}

installBrew() {
  echo "--- dry run: homebrew installation ---"
  ensureBrewPath

  if ! command -v brew >/dev/null 2>&1; then
    echo "you cannot brew, as the package is not found! let us pour the joy! 🍻"
    echo "/bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
    echo "eval \"\$(/opt/homebrew/bin/brew shellenv)\"   # Apple Silicon"
    echo "eval \"\$(/usr/local/bin/brew shellenv)\"      # Intel"
  else
    echo "homebrew is already installed at $(command -v brew) (prefix $(brew --prefix), arch $(uname -m))"
  fi

  echo "lets check the packages from Brewfile!"
  if command -v brew >/dev/null 2>&1; then
    brew bundle check --file="$(pwd)/Brewfile" || true
  else
    echo "skip brew bundle check (brew not on PATH yet)"
  fi
  echo "--------------------------------------"
}

installXcode() {
  echo "--- dry run: Xcode Command Line Tools installation ---"
  if ! xcode-select --print-path >/dev/null 2>&1; then
    echo "xcode-select --install"
    echo "until xcode-select --print-path; do sleep 5; done"
    echo "# prefer full Xcode if present, else CLT (Apple Silicon laptops often CLT-only)"
    echo "sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer   # if Xcode.app exists"
    echo "sudo xcode-select -switch /Library/Developer/CommandLineTools          # else"
  else
    echo "Xcode / CLT already at: $(xcode-select --print-path)"
  fi
  echo "----------------------------------------------------"
}

symlinkDotfiles() {
  echo "--- dry run: symlinking dotfiles ---"
  declare -a DIRS_TO_SYMLINK=(
    "alacritty"
    "emacs"
    "ghostty"
    "jj"
    "mise"
    "nvim"
    "skhd"
    "tuicr"
    "yabai"
    "tmux"
    "zsh"
    "karabiner"
  )

  for dir in "${DIRS_TO_SYMLINK[@]}"; do
    SOURCE_DIR="$(pwd)/$dir"
    TARGET_DIR="$DEFAULT_DOTFILES_CONFIG_DIR/$dir"

    if [ ! -d "$SOURCE_DIR" ]; then
      echo "skip missing $SOURCE_DIR"
      continue
    fi

    if [ -e "$TARGET_DIR" ] || [ -L "$TARGET_DIR" ]; then
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
