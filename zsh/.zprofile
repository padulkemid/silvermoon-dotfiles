# defaults
export LC_ALL="en_US.UTF-8"
export EDITOR="nvim"
export SHELL="zsh"

# config store dirs
export ALL_DOTFILES_DIR="$HOME/.dotfiles"
export ALL_CONFIG_DIR="$HOME/.config"
export ALL_SHARE_DIR="$HOME/.local/share"
export TMUX_PLUGIN_MANAGER_PATH="${ALL_CONFIG_DIR}/tmux/plugins/tpm"

# config cleanups
export LESSHISTFILE="-"
export ZDOTDIR="$ALL_CONFIG_DIR/zsh"
export ASDF_DATA_DIR="$ALL_CONFIG_DIR/asdf"
export HISTFILE="$ALL_SHARE_DIR/history"
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix)/opt/openssl@1.1"

# android path
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
