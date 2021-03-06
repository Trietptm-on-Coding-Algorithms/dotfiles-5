#define esc
#  printf "%c[",0x1b
#end
#
define printinfo
#  bt 
#  printf "\n"
#  i f 0
#  printf "\n"
#  esc
#  printf "32m"
#  x/8i $pc
#  esc
#  printf "38m\n"
#  esc
#  printf "31m"
#  x/32wx $sp
#  esc
#  printf "37m\n"
#  printf "eax = %08x\tecx = %08x\tedx = %08x\tebx = %08x\n", $eax, $ecx, $edx, $ebx
#  printf "esp = %08x\tebp = %08x\tesi = %08x\tedi = %08x\n", $esp, $ebp, $esi, $edi
#  printf "\n"
#  esc
#  printf "0m\n"
  xr
end

define setup
  target sim
  load
end

define n
  nexti
  printinfo
end

define s
  stepi
  printinfo
end

define rn
  reverse-nexti
  printinfo
end

define rs
  reverse-stepi
  printinfo
end

define b
  break $arg0
  commands
    printi
  end
end

set follow-fork-mode child
set print address
set prompt gdb> 
set pagination off

source ~/dotfiles/dump-gdb.py

set disassembly-flavor intel
