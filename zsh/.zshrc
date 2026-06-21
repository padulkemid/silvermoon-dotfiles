# core paths
GPG_TTY=$(tty)
BREW_PREFIX="/opt/homebrew"
export GPG_TTY
export ZSH="$ALL_CONFIG_DIR/oh-my-zsh"
export ZSH_CUSTOM="$ZSH/custom"
export PATH="$PATH:$HOME/.pub-cache/bin"

# zsh config
# this is my own personal theme based on "imajes"
ZSH_THEME="padulkemid"
HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"
FPATH="$BREW_PREFIX/share/zsh-completions:$FPATH"

# after I comfortable with `jj` I might remove this and move everything to `jj`
plugins=(git)

source "$ZSH/oh-my-zsh.sh"
source "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
# source $(brew --prefix)/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

# gnu stuffs
export PATH="$BREW_PREFIX/opt/gnu-sed/libexec/gnubin:$PATH"
export PATH="$BREW_PREFIX/opt/curl/bin:$PATH"

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
alias csp="$ALL_SHARE_DIR/scripts/cloud-sql-proxy"
alias gai="git add --interactive"
alias melon="melos"
alias ftest="flutter test --no-test-assets --reporter=expanded"
alias update_yabai='echo "$(whoami) ALL=(root) NOPASSWD: sha256:$(shasum -a 256 $(which yabai) | cut -d " " -f 1) $(which yabai) --load-sa" | sudo tee /private/etc/sudoers.d/yabai'
alias bubu="brew update && brew outdated && brew upgrade && brew cleanup"

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
alias jtc="nvim $JJ_CONFIG_LOCATION"

# options
export IGNOREEOF=2
export HISTSIZE=100000
export SAVEHIST=100000
setopt nobeep
setopt histignorealldups
setopt histfindnodups
setopt histreduceblanks

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

# fix cursor blink
function _fix_cursor_blink() {
  printf '\033[1 q'
}
zle -N zle-line-init _fix_cursor_blink

# shells
eval "$(jump shell)"
eval "$(mise activate zsh)"
