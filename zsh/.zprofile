# homebrew (arm)
export PATH="/opt/homebrew/bin:$PATH"
eval "$(/opt/homebrew/bin/brew shellenv)"

# defaults
export LC_ALL="en_US.UTF-8"
export EDITOR="nvim"
export SHELL="zsh"

# config store dirs
export ALL_DOTFILES_DIR="$HOME/.dotfiles"
export ALL_CONFIG_DIR="$HOME/.config"
export ALL_SHARE_DIR="$HOME/.local/share"
export TMUX_PLUGIN_MANAGER_PATH="${ALL_CONFIG_DIR}/tmux/plugins/tpm"
export DOOMDIR="${ALL_CONFIG_DIR}/doom"

# config cleanups
export LESSHISTFILE="-"
export REDISCLI_HISTFILE="-"
export ZDOTDIR="$ALL_CONFIG_DIR/zsh"
export HISTFILE="$ALL_SHARE_DIR/history"
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix)/opt/openssl@1.1"

# android path
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

# locations
export ZSHRC_LOCATION="$ALL_DOTFILES_DIR/zsh/.zshrc"
export ZPROFILE_LOCATION="$ALL_DOTFILES_DIR/zsh/.zprofile"
export INITLUA_LOCATION="$ALL_DOTFILES_DIR/nvim/init.lua"
export TMUX_CONF_LOCATION="$ALL_DOTFILES_DIR/tmux/tmux.conf"
export SKHDRC_LOCATION="$ALL_DOTFILES_DIR/skhd/skhdrc"
export YABAIRC_LOCATION="$ALL_DOTFILES_DIR/yabai/yabairc"
export JUMP_HOME="$ALL_CONFIG_DIR/jump"
export GITCONFIG_LOCATION="$ALL_DOTFILES_DIR/git/config"
export MISE_CONFIG_LOCATION="$ALL_DOTFILES_DIR/mise/config.toml"
export GHOSTTY_CONFIG_LOCATION="$ALL_DOTFILES_DIR/ghostty/config"
export ALACRITTY_CONFIG_LOCATION="$ALL_DOTFILES_DIR/alacritty/alacritty.toml"

# apps
export CLOUDSDK_PYTHON="python3"
# export GOOGLE_CLOUD_PROJECT="prj-dev-app5720ba"
export GOPATH="$ALL_SHARE_DIR/go"
