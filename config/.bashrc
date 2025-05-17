#!/bin/bash

case $- in
*i*) ;; # interactive
*) return ;;
esac

# Local utility functions

_have() { type "$1" &>/dev/null; }

# History control
shopt -s histappend
HISTCONTROL=ignoreboth
HISTSIZE=32768
HISTFILESIZE="${HISTSIZE}"

# Autocompletion
source /usr/share/bash-completion/bash_completion

# Set complete path
export PATH="./bin:$HOME/.local/bin:$PATH"
set +h

# Editor used by CLI
set-editor() {
	export EDITOR="$1"
	export VISUAL="$1"
	export GH_EDITOR="$1"
	export GIT_EDITOR="$1"
  export SUDO_EDITOR="$1"	
}
_have "vim" && set-editor vi
_have "nvim" && set-editor nvim

# File system
alias ls='eza -lh --group-directories-first --icons=auto'
alias lsa='ls -a'
alias lt='eza --tree --level=2 --long --icons --git'
alias lta='lt -a'
alias ff="fzf --preview 'batcat --style=numbers --color=always {}'"
alias fd='fdfind'
alias cd='z'

# Directories
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Tools
alias vi="\$EDITOR"
alias n='nvim'
alias g='git'
alias d='docker'
alias bat='batcat'
alias lzg='lazygit'
alias lzd='lazydocker'

# Git
alias gcm='git commit -m'
alias gcam='git commit -a -m'
alias gcad='git commit -a --amend'

# Technicolor dreams
force_color_prompt=yes
color_prompt=yes

# Simple prompt will be overridden if zellij installed
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# Initializations
_have gh && . <(gh completion -s bash)
_have mise && eval "$(mise activate bash)"
_have zoxide && eval "$(zoxide init bash)"

if _have fzf; then
  if [[ -f /usr/share/bash-completion/completions/fzf ]]; then
    source /usr/share/bash-completion/completions/fzf
  fi
  if [[ -f /usr/share/doc/fzf/examples/key-bindings.bash ]]; then
    source /usr/share/doc/fzf/examples/key-bindings.bash
  fi
fi

if _have zellij; then
  PS1=$'❯ '
  PS1="\[\e]0;\w\a\]$PS1"
  if [[ -z "$ZELLIJ" ]]; then
    zellij attach --create ${TERM_PROGRAM:-primary}
  fi
fi