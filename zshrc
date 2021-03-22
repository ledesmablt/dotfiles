### zsh configs
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="pmcgee"

DISABLE_AUTO_TITLE="true"
DISABLE_UPDATE_PROMPT="true"
# DISABLE_AUTO_UPDATE="true"
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=( \
  git gitfast tmux \
  docker docker-compose fzf gcloud \
  yarn pip gem bundler rails rvm golang \
  urltools \
)

source $ZSH/oh-my-zsh.sh
# export MANPATH="/usr/local/man:$MANPATH"

### settings
# lscolors fix
export LS_COLORS="ow=01;36;40"

# make cd use lscolors
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
autoload -Uz compinit
compinit

# use extendedglob
setopt extendedglob

### init services (wsl)
# cron
[[ `pgrep --exact cron` ]] || sudo service cron start > /dev/null

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# source env & aliases
source ~/.zshenv

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
