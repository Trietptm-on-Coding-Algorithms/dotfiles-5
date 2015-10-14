HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000

shopt -s checkwinsize

function md_cd() {
  mkdir $1 && echo $1 && cd $1
}

function catch_segfault() {
  export LD_PRELOAD_BAK=$LD_PRELOAD
  export LD_PRELOAD=/lib/libSegFault.so
  export SEGFAULT_SIGNALS=all
}

function uncatch_segfault() {
  export LD_PRELOAD=$LD_PRELOAD_BAK
}

function quote_plus() {
python -c "print __import__('urllib').quote_plus(__import__('sys').stdin.read())"
}

function unquote_plus() {
python -c "print __import__('urllib').unquote_plus(__import__('sys').stdin.read())"
}

function logged_cd() {
  \cd "$@" && pwd
}

export PS1='\033[04;37m\[`LC_ALL=C date` \w\]\033[00m\n> '
unset color_prompt force_color_prompt

unalias ls
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias tmux='tmux -S $HOME/opt/tmux/socket'
alias d='dirs'
alias -- +=pushd
alias -- -=popd
alias ":q"="echo \"ここはVimじゃねーよクソ\""
alias ":wq"="echo \"ここはVimじゃねーよクソ\""
alias -- ".."="cd .."
alias -- "gvim"="gvim 2>/dev/null"
alias -- "strings"="strings -tx"
alias -- "mkdir"="md_cd"
alias -- "cd"="logged_cd"
alias -- "objdump"="objdump -Mintel"
alias -- "rot13"="conv -e rot13"
alias -- "zlib"="conv -e zlib"
alias -- "unzlib"="conv -d zlib"
alias -- "checksec"="python -m roputils checksec"

shopt -s histverify

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi
export MECAB_PATH=/usr/lib/libmecab.so.2
export PYTHONSTARTUP="$HOME/.pyrc"

export TERM=xterm-256color
export PATH=$PATH:~/scripts:~/prog/bin/:/home/eshiho/010editor

