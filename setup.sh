#!/bin/bash

SCRIPT_PATH=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)

if [ -L ~/.vimrc ]; then
  rm ~/.vimrc
fi
if [ -L ~/.bashrc ]; then
  rm ~/.bashrc
fi
if [ -L ~/opt ]; then
  rm ~/opt
fi
if [ -L ~/.vim ]; then
  rm ~/.vim
fi
if [ -f ~/.vimrc ]; then
  mv ~/.vimrc ~/.vimrc.bak
fi
if [ -f ~/.bashrc ]; then
  mv ~/.bashrc ~/.bashrc.bak
fi
if [ -d ~/.vim ]; then
  mv ~/.vim ~/.vim.bak
fi
if [ -d ~/opt ]; then
  mv ~/opt ~/opt.bak
fi

ln -s $SCRIPT_PATH/.vimrc ~/.vimrc
ln -s $SCRIPT_PATH/.vim ~/.vim
ln -s $SCRIPT_PATH/.bashrc ~/.bashrc
ln -s $SCRIPT_PATH/opt ~/opt


