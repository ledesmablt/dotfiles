#!/bin/bash

BASE=$(pwd)

# home
for rc in *rc zsh* tmux.conf; do
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
