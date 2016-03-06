import re

class COLOR:
  BLACK   = "\x1b[30m"
  RED     = "\x1b[31m"
  GREEN   = "\x1b[32m"
  YELLOW  = "\x1b[33m"
  BLUE    = "\x1b[34m"
  MAGENTA = "\x1b[35m"
  CYAN    = "\x1b[36m"
  WHITE   = "\x1b[37m"
  DEFAULT = "\x1b[0m"
  BOLD    = "\x1b[1m"

class extended_examine(gdb.Command):
  def __init__(s):
    super(extended_examine, s).__init__("xr", gdb.COMMAND_OBSCURE)
  def invoke(s, args, from_tty):
    barlen = 100
    def exec_cmd(cmd, to_string = False):
      try:
        return gdb.execute(cmd, to_string=to_string)
      except RuntimeError as e:
        print(COLOR.BOLD + COLOR.RED + "!!!Error occurred!!! : " + str(e) + COLOR.DEFAULT)

    print(COLOR.BLUE + "="*barlen + COLOR.DEFAULT)
    print(COLOR.BOLD + COLOR.RED + "Backtrace: " + COLOR.DEFAULT)
    exec_cmd("bt")

    print(COLOR.BLUE + "="*barlen + COLOR.DEFAULT)
    print(COLOR.BOLD + COLOR.RED + "Current Frame: " + COLOR.DEFAULT)
    exec_cmd("i f 0")

    print(COLOR.BLUE + "="*barlen + COLOR.DEFAULT)
    print(COLOR.BOLD + COLOR.RED + "Disassemble: " + COLOR.DEFAULT)
    d = exec_cmd("x/32i $pc-40", True)
    if d != None:
      d = d.split("\n")
      s = ""
      rec = []
      i = -1
      for x in d:
        if "=>" in x:
          s = "\n".join(rec[-8:]) + "\n"
          s += x.replace("=>", COLOR.BOLD + COLOR.CYAN + "=>" + COLOR.DEFAULT + COLOR.GREEN) + "\n"
          i = 8
        elif i > 0:
          i -= 1
          s += x + "\n"
        else:
          rec += [x]
        if i == 0:
          break
      print(COLOR.GREEN + s + COLOR.DEFAULT)

    print(COLOR.BLUE + "="*barlen + COLOR.DEFAULT)
    print(COLOR.BOLD + COLOR.RED + "Stack: " + COLOR.DEFAULT)
    d = exec_cmd("x/32wx $sp-16", True)
    if d != None:
      print(COLOR.MAGENTA + d + COLOR.DEFAULT)

    print(COLOR.BLUE + "="*barlen + COLOR.DEFAULT)
    print(COLOR.BOLD + COLOR.RED + "Registers: " + COLOR.DEFAULT)
    registers = exec_cmd('i r', to_string=True)
    if registers != None:
      registers = registers.split("\n")
      i = 0
      s = ""
      for x in registers:
        r = re.match("(\w+)\s+(0x[0-9a-f]+)\s+\d+", x)
        if r != None:
          s += ('%s: ' % r.group(1)).ljust(6, " ")
          s += ('0x%08x\t' % eval(r.group(2))).rjust(19, " ")
          if (i + 1) % 4 == 0:
            print(COLOR.YELLOW + s + COLOR.DEFAULT)
            s = ""
          i += 1
    print(COLOR.BLUE + "="*barlen + COLOR.DEFAULT)

extended_examine()
