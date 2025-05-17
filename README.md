# FASM examples

Playing around with fasm: the flat assembler in linux.
Wanted to see how tiny we can create executables and to refresh my assembly skills again in 2025.
Fasm is way better than nasm in that it also allows you to create macros to get clean looking assembly code ;).
Check out loopmacro.asm it has nested forloops using macros that make it look almost like python code.

Snippet of the main entry point in loopmacro.asm:

```
start:
  for counter, 1, 5
    print_number counter
    write newline, 1

    for i, 1, 3
      write message, message_len
    endfor i
  endfor counter

  exit 0
```

## Building executables

```
$ sudo apt install fasm
$ make
```

You now see executables created for the asm files using fasm.
They are working and absolutely tiny !

## Running

```
$ ./loopmacro
1
Dit is een zinnetje voor Noah met assembler
Dit is een zinnetje voor Noah met assembler
Dit is een zinnetje voor Noah met assembler
2
Dit is een zinnetje voor Noah met assembler
Dit is een zinnetje voor Noah met assembler
Dit is een zinnetje voor Noah met assembler
3
Dit is een zinnetje voor Noah met assembler
Dit is een zinnetje voor Noah met assembler
Dit is een zinnetje voor Noah met assembler
4
Dit is een zinnetje voor Noah met assembler
Dit is een zinnetje voor Noah met assembler
Dit is een zinnetje voor Noah met assembler
5
Dit is een zinnetje voor Noah met assembler
Dit is een zinnetje voor Noah met assembler
Dit is een zinnetje voor Noah met assembler
```

```
file loopmacro
loopmacro: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), statically linked, no section header
```

This nested loops example has some nice macros to do for loops in assembly and does some system linux calls
to display text. All in a binary that is statically linked and is only 445 bytes large!

```
$ ls -lh loopmacro
-rwxrwxr-x 1 wschrep wschrep 445 Jan 19 22:03 loopmacro
```

## Fibonacci

Here the first 91 Fibonacci numbers calculated using an executable that is static and only 374 bytes:

```
$ ./fib
0
1
1
2
3
5
8
13
21
34
55
89
144

...

679891637638612258
1100087778366101931
1779979416004714189
2880067194370816120


$ ls -lh fib
-rwxrwxr-x 1 wschrep wschrep 374 May 17 22:56 fib


$ ldd fib
	not a dynamic executable
```

## DISASSEMBLE

How to disassemble these binaries, a little howto:

```
readelf -e ./loopmacro

# => copy the Entry point address
# Now start gdb  (or gf2)

gdb ./loopmacro

# write b for break, then * then the address found at Entry point adress with readelf above
b *0x4000ec

# start tui
tui enable

# now show asm code:
layout asm

# now run in gdb
run

# now step using 'ni' command
ni

# show all registers
tui reg all
```

## Easier disassemble using a python script

Just run this script with python and it will perform above readelf and gdb commands automatically
and basically open any wanted executable with gdb and show you all registers + start debugging the instructions.

```
pip install pexpect
python disassemble.py ./hello_fasm
```

This goes to breakpoint and shows the assembly tui view. Also it runs one step with ni so you can just press enter
multiple times now to step through each asm instruction manually.

## Inspiration and links

Got interested again into assembly thanks to this project from tsoding https://github.com/tsoding/todo.asm
