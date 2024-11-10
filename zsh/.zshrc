# core paths
GPG_TTY=$(tty)
export GPG_TTY
export PATH="$(brew --prefix)/bin:$PATH"
export ZSH="$ALL_CONFIG_DIR/oh-my-zsh"
export ZSH_CUSTOM="$ZSH/custom"

# zsh config
# this is my own personal theme based on "imajes"
ZSH_THEME="padulkemid"
HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"
FPATH="$(brew --prefix)/share/zsh-completions:$FPATH"

plugins=(git brew)

autoload -Uz compinit && compinit

source $ZSH/oh-my-zsh.sh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh


# gnu stuffs
export PATH="$(brew --prefix)/opt/gnu-sed/libexec/gnubin:$PATH"
export PATH="$(brew --prefix)/opt/curl/bin:$PATH"

# locations
export ZSHRC_LOCATION="$ALL_DOTFILES_DIR/zsh/.zshrc"
export ZPROFILE_LOCATION="$ALL_DOTFILES_DIR/zsh/.zprofile"
export INITLUA_LOCATION="$ALL_DOTFILES_DIR/nvim/init.lua"
export ALACRITTY_YAML_LOCATION="$ALL_DOTFILES_DIR/alacritty/alacritty.toml"
export TMUX_CONF_LOCATION="$ALL_DOTFILES_DIR/tmux/tmux.conf"
export STARSHIP_CONFIG_LOCATION="$ALL_DOTFILES_DIR/starship/starship.toml"
export SKHDRC_LOCATION="$ALL_DOTFILES_DIR/skhd/skhdrc"
export YABAIRC_LOCATION="$ALL_DOTFILES_DIR/yabai/yabairc"
export JUMP_HOME="$ALL_CONFIG_DIR/jump"
export GITCONFIG_LOCATION="$ALL_DOTFILES_DIR/git/config"
export MISE_CONFIG_LOCATION="$ALL_DOTFILES_DIR/mise/config.toml"

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
alias tctl="docker exec temporal-admin-tools tctl"
alias man="\man"
alias pdsh="$ALL_SHARE_DIR/scripts/pdsh"
alias create_norg_note="$ALL_SHARE_DIR/scripts/create_norg_note"
alias spot="ncspot"

## files
alias zc="nvim $ZSHRC_LOCATION"
alias zpc="nvim $ZPROFILE_LOCATION"
alias szc="source $ZSHRC_LOCATION"
alias vc="nvim $INITLUA_LOCATION"
alias alc="nvim $ALACRITTY_YAML_LOCATION"
alias tc="nvim $TMUX_CONF_LOCATION"
alias skc="nvim $SKHDRC_LOCATION"
alias ybc="nvim $YABAIRC_LOCATION"
alias gtc="nvim $GITCONFIG_LOCATION"
alias mc="nvim $MISE_CONFIG_LOCATION"

# apps
export CLOUDSDK_PYTHON="$(brew --prefix)/bin/python3"
export GOPATH="$ALL_SHARE_DIR/go"

# shells
eval "$(jump shell)"
eval "$(mise activate zsh)"

# options
export IGNOREEOF=2

# bash like ctrl-d wrapper for IGNOREEOF
setopt ignore_eof
function bash-ctrl-d() {
  if [[ $CURSOR == 0 && -z $BUFFER ]]
  then
    [[ -z $IGNOREEOF || $IGNOREEOF == 0 ]] && exit
    if [[ "$LASTWIDGET" == "bash-ctrl-d" ]]
    then
      (( --__BASH_IGNORE_EOF <= 0 )) && exit
    else
      (( __BASH_IGNORE_EOF = IGNOREEOF ))
    fi
  fi
}
zle -N bash-ctrl-d
bindkey "^d" bash-ctrl-d
