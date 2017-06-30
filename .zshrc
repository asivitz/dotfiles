# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="afowler"
# ZSH_THEME="robbyrussell"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

DISABLE_AUTO_UPDATE=true

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export DEFAULT_USER="axis"
export VISUAL=nvim
export EDITOR="$VISUAL"

alias emacs="/usr/local/bin/emacs"
alias vi=nvim
alias gitx='open ~/Applications/GitX.app'
alias jump='/usr/local/sbin/lighttpd -D -f ~/Sites/lighttpd.conf'
alias gs="git status"

# [[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function

export PATH=$PATH

#export ZLSCOLORS="di=32"
#export LSCOLORS="cxfxcxdxbxegedabagacad"
bindkey -v

bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward

# PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
# PATH=$PATH:$HOME/.cabal/bin
PATH=$PATH:$HOME/.local/bin

. /usr/local/etc/profile.d/z.sh

# PATH=$PATH:/Users/axis/Development/ghc-ios-scripts

unsetopt correct_all
unsetopt share_history