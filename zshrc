### zsh configs
export ZSH="$HOME/.oh-my-zsh"
if [[ -z $FLOATERM ]]; then
  ZSH_THEME="pmcgee"
else
  ZSH_THEME="imajes"
fi

DISABLE_AUTO_TITLE="true"
DISABLE_UPDATE_PROMPT="true"
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=( \
  gitfast tmux fzf yarn npm gh \
)
# git urltools docker docker-compose gcloud aws \
# nvm pip gem bundler rails rvm \

source $ZSH/oh-my-zsh.sh

### settings
# lscolors fix
export LS_COLORS="ow=01;36;40"
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"

# speed up compinit?
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done

setopt extendedglob

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# nvm - load only on call
nvm() {
  export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

  unset -f nvm
  export NVM_PREFIX=$(brew --prefix nvm)
  [ -s "$NVM_PREFIX/nvm.sh" ] && . "$NVM_PREFIX/nvm.sh"
  nvm "$@"
}

# source env & aliases for vim
[[ -z $VIMRUNTIME ]] || source ~/.zshenv

# # >>> conda initialize >>>
# # !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/opt/homebrew/Caskroom/miniforge/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh" ]; then
#         . "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh"
#     else
#         export PATH="/opt/homebrew/Caskroom/miniforge/base/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# # <<< conda initialize <<<
