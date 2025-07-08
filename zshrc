# set up variables for ZSH
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
  git gitfast gh tmux fzf asdf \
  yarn npm \
  rails gem bundler \
  # urltools docker docker-compose gcloud aws pip \
)

# actually initialize ZSH
source $ZSH/oh-my-zsh.sh

# ensures that the coloring in the completion menu matches `ls` colors
# (e.g., green for executables, blue for directories)
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"

# init zsh tab completion
autoload -Uz compinit && compinit

# pattern-matching when you type - for example, typing `rm *.sh`
# and then pressing Tab would list all matching files
setopt extendedglob

# init fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# load asdf with autocomplete 
. /opt/homebrew/opt/asdf/libexec/asdf.sh

# if not in vim, source ~/.zshenv
[[ -z $VIMRUNTIME ]] || source ~/.zshenv

# set zoxide, a smarter cd command - https://github.com/ajeetdsouza/zoxide
which zoxide > /dev/null 2>&1 && eval "$(zoxide init zsh)"
alias cd=z
