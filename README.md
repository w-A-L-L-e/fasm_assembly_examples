# fasm_assembly_examples

Playing around with fasm the flat assembler to see how tiny we can create executables and to refresh my assembly skills

## building

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
