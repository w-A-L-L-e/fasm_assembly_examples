all: hello_fasm example1 example2 loopmacro mmap_example fib

hello_fasm: hello_fasm.asm
	fasm hello_fasm.asm 
	chmod +x hello_fasm

example1: example1.asm
	fasm example1.asm 
	chmod +x example1

example2: example2.asm
	fasm example2.asm 
	chmod +x example2

loopmacro: loopmacro.asm
	fasm loopmacro.asm 
	chmod +x loopmacro

fib: fib.asm
	fasm fib.asm
	chmod +x fib

mmap_example: mmap_example.asm
	fasm mmap_example.asm
	chmod +x mmap_example

clean:
	@rm -vf hello_fasm example1 example2 loopmacro mmap_example fib

