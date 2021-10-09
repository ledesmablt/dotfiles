# env
export MANPAGER='nvim +Man!'
export FZF_DEFAULT_COMMAND='ag -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export EDITOR=nvim
export GOPATH="$HOME/.go"

export PATH="$PATH:$GOPATH"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$PATH:$HOME/scripts"

# aliases (must be here to work in vim :! mode)
alias so=source
alias python="python3"
alias pip="pip3"
alias pydoc="python3 -m pydoc"
alias src="source ~/.zshrc"
alias erc="vim ~/.config/vim/init.vim -c 'cd ~/.config/vim'"
alias vim="nvim"
alias v="nvim"
alias rg="rg -p"
alias sp="spotify"
alias ww="vim +VimwikiIndex"
alias todo="vim +VimwikiIndex -c 'VimwikiGoto todo'"
alias tsk="tmux send-keys -t"
alias pr="gh pr checkout"

# load other zshenvs
for f in $(ls -a $HOME | grep ".zshenv.")
do
  source $HOME/$f
done
