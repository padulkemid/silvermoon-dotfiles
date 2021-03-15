# defaults
export LC_ALL="en_US.UTF-8"
export EDITOR="nvim"

# config store dirs
export ALL_DOTFILES_DIR="$HOME/.dotfiles"
export ALL_CONFIG_DIR="$HOME/.config"
export ALL_SHARE_DIR="$HOME/.local/share"

# config cleanups
export LESSHISTFILE="-"
export ZDOTDIR="$ALL_CONFIG_DIR/zsh"
export ASDF_DATA_DIR="$ALL_CONFIG_DIR/asdf"
export HISTFILE="$ALL_SHARE_DIR/history"
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix)/opt/openssl@1.1"

