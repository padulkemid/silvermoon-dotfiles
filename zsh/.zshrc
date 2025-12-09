# core paths
GPG_TTY=$(tty)
export GPG_TTY
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
# source $(brew --prefix)/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh


# gnu stuffs
export PATH="$(brew --prefix)/opt/gnu-sed/libexec/gnubin:$PATH"
export PATH="$(brew --prefix)/opt/curl/bin:$PATH"

# aliases
## commands override
alias c="clear"
alias x="exit"
alias v="nvim"
alias view="nvim"
alias please="sudo"
alias ls="gls --color -AF --group-directories-first"
alias tmux="tmux -f $ALL_CONFIG_DIR/tmux/tmux.conf new -s padul"
alias tctl="docker exec temporal-admin-tools tctl"
alias man="\man"
alias pdsh="$ALL_SHARE_DIR/scripts/pdsh"
alias cnn="$ALL_SHARE_DIR/scripts/create_norg_note"
alias csn="$ALL_SHARE_DIR/scripts/create_sena_note"
alias csp="$ALL_SHARE_DIR/scripts/cloud-sql-proxy"
alias gai="git add --interactive"
alias melon="melos"
# alias update_yabai=`echo "$(whoami) ALL=(root) NOPASSWD: sha256:$(shasum -a 256 $(which yabai) | cut -d " " -f 1) $(which yabai) --load-sa" | sudo tee /private/etc/sudoers.d/yabai`

## files
alias zc="nvim $ZSHRC_LOCATION"
alias zpc="nvim $ZPROFILE_LOCATION"
alias szc="source $ZSHRC_LOCATION"
alias vc="nvim $INITLUA_LOCATION"
alias ghc="nvim $GHOSTTY_CONFIG_LOCATION"
alias alc="nvim $ALACRITTY_CONFIG_LOCATION"
alias tc="nvim $TMUX_CONF_LOCATION"
alias skc="nvim $SKHDRC_LOCATION"
alias ybc="nvim $YABAIRC_LOCATION"
alias gtc="nvim $GITCONFIG_LOCATION"
alias mc="nvim $MISE_CONFIG_LOCATION"

# shells
eval "$(jump shell)"
eval "$(mise activate zsh)"
eval "$(/usr/libexec/path_helper)"
export PATH="$PATH:$HOME/.pub-cache/bin"

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
