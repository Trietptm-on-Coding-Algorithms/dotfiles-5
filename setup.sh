#!/bin/bash

SCRIPT_PATH=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)

function entry () {
  if [ "`echo \"$1\"|perl -p0e\"$\=m|/$|;}{\"`" = "1" ]; then
    target=${1%/}
  else
    target=$1
  fi
  if [ -L "$HOME/$target" ]; then
    rm "$HOME/$target"
  fi
  if [ -f "$HOME/$target" ]; then
    mv "$HOME/$target" "$HOME/$target.bak"
  fi
  ln -s "$SCRIPT_PATH/$target" "$HOME/$target"
}

entry ".pyrc"
entry ".vimrc"
entry ".bashrc"
entry ".Xresources"
entry ".gdbinit"

entry ".vim/"
entry "opt/"
