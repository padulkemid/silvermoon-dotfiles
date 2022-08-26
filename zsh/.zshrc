# core paths
GPG_TTY=$(tty)
export GPG_TTY
export PATH="$HOME/bin:/usr/local/sbin:$PATH"
export ZSH="$ALL_CONFIG_DIR/oh-my-zsh"
export ZSH_CUSTOM="$ZSH/custom"

# zsh config
ZSH_THEME="robbyrussell"
HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"
FPATH="$(brew --prefix)/share/zsh-completions:$FPATH"

plugins=(git brew macos)

autoload -Uz compinit && compinit

source $ZSH/oh-my-zsh.sh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# gnu stuffs
export PATH="$(brew --prefix)/opt/gnu-sed/libexec/gnubin:$PATH"
export PATH="$(brew --prefix)/opt/grep/libexec/gnubin:$PATH"
export PATH="$(brew --prefix)/opt/curl/bin:$PATH"

# locations
export ZSHRC_LOCATION="$ALL_DOTFILES_DIR/zsh/.zshrc"
export INITVIM_LOCATION="$ALL_DOTFILES_DIR/nvim/init.vim"
export ALACRITTY_YAML_LOCATION="$ALL_DOTFILES_DIR/alacritty/alacritty.yml"
export TMUX_CONF_LOCATION="$ALL_DOTFILES_DIR/tmux/tmux.conf"
export STARSHIP_CONFIG_LOCATION="$ALL_DOTFILES_DIR/starship/starship.toml"
export SKHDRC_LOCATION="$ALL_DOTFILES_DIR/skhd/skhdrc"
export YABAIRC_LOCATION="$ALL_DOTFILES_DIR/yabai/yabairc"
export JUMP_HOME="$ALL_CONFIG_DIR/jump"
export ASDF_SH_LOCATION="$(brew --prefix)/opt/asdf"
export GITCONFIG_LOCATION="$ALL_DOTFILES_DIR/git/config"

# aliases
## commands override
alias c="clear"
alias x="exit"
alias v="nvim"
alias please="sudo"
alias ls="gls --color -AF --group-directories-first"
alias tmux="tmux -f $ALL_CONFIG_DIR/tmux/tmux.conf new -s padul"
alias set_sirius_env="source $ALL_SHARE_DIR/scripts/set_sirius_env"
alias unset_sirius_env="source $ALL_SHARE_DIR/scripts/unset_sirius_env"
alias create_arch_tree="$ALL_SHARE_DIR/scripts/create_arch_tree"

## files
alias zc="nvim $ZSHRC_LOCATION"
alias szc="source $ZSHRC_LOCATION"
alias vc="nvim $INITVIM_LOCATION"
alias alc="nvim $ALACRITTY_YAML_LOCATION"
alias tc="nvim $TMUX_CONF_LOCATION"
alias strc="nvim $STARSHIP_CONFIG_LOCATION"
alias skc="nvim $SKHDRC_LOCATION"
alias ybc="nvim $YABAIRC_LOCATION"
alias gtc="nvim $GITCONFIG_LOCATION"

# apps
## java jdk version chooser
jdk() {
  version="$1"
  
  export JAVA_HOME="$(/usr/libexec/java_home -v $version)"

  java -version
}

## google cloud sdk
export CLOUDSDK_PYTHON="$(brew --prefix)/bin/python3"
source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"

# shells
eval "$(jump shell)"
eval "$(starship init zsh)"
eval "$(thefuck --alias)"
[ -s "$ASDF_SH_LOCATION/asdf.sh" ] && \. "$ASDF_SH_LOCATION/asdf.sh"
