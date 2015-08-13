[ -z "$PS1" ] && return

HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000

shopt -s checkwinsize

function psexit() {
  a=$?
  if [[ $a != 0 ]]; then
    echo -ne "\e[31m($a)"
  fi
  exit 0
}

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

function logged_cd() {
  \cd "$@"
  pwd
}

if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
  color_prompt=yes
    else
  color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\] \[\033[01;34m\]\w $(psexit)\n\$\[\033[00m\] '
else
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\n\$ '
fi
unset color_prompt force_color_prompt


case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

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

shopt -s histverify

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi
export MECAB_PATH=/usr/lib/libmecab.so.2
export PYTHONSTARTUP="/home/eshiho/.pyrc"

export TERM=xterm-256color
export PATH=$PATH:~/scripts:~/prog/bin/:

PATH=$PATH:/home/eshiho/010editor;export PATH; 

