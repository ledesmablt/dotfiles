# env (avoid double-sourcing)
if [[ -z "$ZSHENV_SOURCED" ]]; then
  export ZSHENV_SOURCED=1
  export FZF_DEFAULT_COMMAND="ag -g"
  export EDITOR=nvim
  export GOPATH=/home/benj/.go
  export PATH=$PATH:$GOPATH
  export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
  export PATH="/home/benj/.local/bin:$PATH"
  export PATH=$PATH:/home/benj/scripts
fi

# aliases (must be here to work in vim :! mode)
alias so=source
alias config='/usr/bin/git --git-dir=/home/benj/.cfg/ --work-tree=/home/benj'
alias spicetify="powershell.exe spicetify"
alias python="python3"
alias pip="pip3"
alias pydoc="python3 -m pydoc"
alias man="viman"
alias erc="vim ~/.config/vim/init.vim -c 'cd ~/.config/vim'"
alias vim="nvim"
alias f="/home/benj/scripts/search"
alias rg="rg -p"
alias sp="spotify"
alias e="explorer.exe"
alias cmd="cmd.exe /r "
alias wyarn="cmd.exe /r yarn"

# react native setup (src: https://gist.github.com/bergmannjg/461958db03c6ae41a66d264ae6504ade#start-adb-server-in-windows)
# export ANDROID_HOME=/home/benj/Android
# export ANDROID_SDK_ROOT=/home/benj/Android
# 
# PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools
# PATH=$PATH:$ANDROID_HOME/bin
# 
# export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
# export WSL_HOST=$(tail -1 /etc/resolv.conf | cut -d' ' -f2)
# export ADB_SERVER_SOCKET=tcp:$WSL_HOST:5037
#
# Set env for EXPO 
# localAddress=`awk 'NR==4 {print $3}' /mnt/c/Users/Lenovo/AppData/Local/wsl2_host_config/*.config.log | sed 's/\\r//g'` 
# export REACT_NATIVE_PACKAGER_HOSTNAME=$localAddress 
# End
