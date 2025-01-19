# fasm_assembly_examples

Playing around with fasm the flat assembler to see how tiny we can create executables and to refresh my assembly skills

## Building executables

```
sudo apt install fasm
make
```

You now see executables created for the asm files using fasm.
They are working and absolutely tiny !

## Running

```
./loopmacro
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
ls -lh loopmacro
-rwxrwxr-x 1 wschrep wschrep 445 Jan 19 22:03 loopmacro
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

## Inspiration and links

Got interested again into assembly thanks to this project from tsoding https://github.com/tsoding/todo.asm
