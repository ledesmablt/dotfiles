# also load local env, if applicable
[ -f ~/.zshenv.local ] && source ~/.zshenv.local

# init homebrew env
[ -f /opt/homebrew/bin/brew ] && eval "$(/opt/homebrew/bin/brew shellenv)"

export PATH="$PATH:$HOME/.go/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.asdf/shims"
export PATH="$PATH:$HOME/.flutter/flutter/bin:"

export FZF_DEFAULT_COMMAND='ag -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export EDITOR=nvim

alias ls="exa"
alias so=source
alias python="python3"
alias pip="pip3"
alias vim="nvim"
alias v="nvim"
alias rg="rg -p"
alias sp="spotify"
alias tsk="tmux send-keys -t"
alias t="tmux"
alias pr="gh pr checkout"
alias tf="terraform"
alias rspec="bundle exec rspec"
