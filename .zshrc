# Path to your oh-my-zsh configuration.
ZSH=$HOME/.nix-profile/share/oh-my-zsh/

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
plugins=(git vi-mode)

DISABLE_AUTO_UPDATE=true

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export DEFAULT_USER="axis"
export VISUAL=nvim
export EDITOR="$VISUAL"

alias vi=nvim
alias gs="git status"
alias glt='git log --oneline --decorate --graph --all'
alias notifyDone='terminal-notifier -title "Terminal" -message "Done with task!"'
alias todo="vi ~/todo"

PATH=$PATH:$HOME/.local/bin:/usr/local/sbin

# . /usr/local/etc/profile.d/z.sh

export LSCOLORS="cxfxcxdxbxegedabagacad"

export BAT_THEME="zenburn"

# lower vi-mode escape delay
KEYTIMEOUT=1

#bindkey '^P' history-beginning-search-backward
#bindkey '^N' history-beginning-search-forward

# backspace can go beyond beginning of insertion point
zle -A .backward-kill-word vi-backward-kill-word
zle -A .backward-delete-char vi-backward-delete-char

unsetopt correct_all
unsetopt share_history

if [ -e ~/.zshrc_custom ]
then
    source ~/.zshrc_custom
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# [ -f "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/bin" ] && source "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/bin"
PATH="$HOME/.ghcup/bin:$PATH"

# Nix
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi
# End NixA
