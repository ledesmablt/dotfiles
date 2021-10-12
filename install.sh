#!/bin/bash

BASE=$(pwd)

# home
for rc in *rc zsh* tmux.conf gitconfig; do
  mkdir -pv backup
  rcpath=~/."$rc"
  [ -e "$rcpath" ] && mv -v "$rcpath" backup/."$rc"
  ln -sfv "$BASE/$rc" "$rcpath"
done

# .config
for cfgdir in $(ls config); do
  mkdir -pv backup/config
  cfgpath=~/.config/"$cfgdir"
  [ -e "$cfgpath" ] && mv -v "$cfgpath" backup/config/
  ln -sfv "$BASE/config/$cfgdir" "$cfgpath"
done

## optional installs

# install yarn dependencies
if [[ " $@ " =~ " yarn " ]]; then
  yarn global add $(cat dependencies/yarn-global.txt)
fi

# install vim deps
if [[ " $@ " =~ " vim " ]]; then
  # vim-plug (nvim)
  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
         https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

  # packer (nvim)
  git clone --depth 1 https://github.com/wbthomason/packer.nvim\
     ~/.local/share/nvim/site/pack/packer/start/packer.nvim
fi

# install tmux plugins
if [[ " $@ " =~ " tmux " ]]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi


# install fzf
if [[ " $@ " =~ " fzf " ]]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install
fi
