#!/bin/bash

# my default dotfiles config dir
DEFAULT_DOTFILES_CONFIG_DIR = "$HOME/.config"

createDirs() {
  declare -a dirs=(
    "$DEFAULT_DOTFILES_CONFIG_DIR"
    "$DEFAULT_DOTFILES_CONFIG_DIR/alacritty"
    "$DEFAULT_DOTFILES_CONFIG_DIR/karabiner"
    "$DEFAULT_DOTFILES_CONFIG_DIR/nvim"
    "$DEFAULT_DOTFILES_CONFIG_DIR/skhd"
    "$DEFAULT_DOTFILES_CONFIG_DIR/tmux"
    "$DEFAULT_DOTFILES_CONFIG_DIR/yabai"
    "$DEFAULT_DOTFILES_CONFIG_DIR/zsh"
  )

  for i in "${dirs[@]}"; do
    mkdir "$i"
  done
}

installBrew() {
  if ! command -v "brew" &> /dev/null; then
    printf "You cannot brew, as the package is not found! let us pour the joy!
    🍻"

    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  fi

  printf "Lets install all the packages!"
  brew bundle
}

installXcode() {
  if ! xcode-select --print-path &> /dev/null; then
    xcode-select --install &> /dev/null

    until xcode-select --print-path &> /dev/null; do
      sleep 5
    done

    sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer

    sudo xcodebuild -license
  fi
}

symlinkDotfiles() {
  declare -a FILES_TO_SYMLINK=$(find .  -type f -not -path "./.git*" -not -path "./git*" -not -path "./zsh*" -not -path "./Brew*" -not -path "./starship*"  -not -path "*.md" -not -path "*.sh" | sed 's/.//')

  # same location
  for i in "${FILES_TO_SYMLINK[@]}"; do
    SOURCE_FILE="$(pwd)/$i"
    TARGET_FILE="$DEFAULT_DOTFILES_CONFIG_DIR/$i"

    ln -sv "$SOURCE_FILE" "$TARGET_FILE"
  done

  # defaults
  ln -sv "$(pwd)/zsh/.zprofile" "$HOME/.zprofile"
  ln -sv "$(pwd)/zsh/.zprofile" "$HOME/.profile"
  ln -sv "$(pwd)/zsh/.zshrc" "$DEFAULT_DOTFILES_CONFIG_DIR/zsh/.zshrc"
}


main() {
  read -p "Get ready to install, are you sure want to install padulkemid's dotfiles ? (y/n)" -n 1 -r
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    printf "📂 Creating directories\n"
    createDirs

    printf "🛠 Installing Xcode Command Line Tools\n"
    installXcode

    printf "🔗 Symlinking dotfiles\n"
    symlinkDotfiles

    printf "🍺 Installing Homebrew and its packages\n"
    installBrew

    printf "After this you should configure your git config, mise config, and yabai ( extra steps on macOS Big Sur+ )\n"
    printf "Thank you! \n"
  fi
    printf "Okay then, take your time!\n"
    exit 1
}
