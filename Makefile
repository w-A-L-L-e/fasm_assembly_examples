all: hello_fasm example1 example2 loopmacro

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


clean:
	rm hello_fasm example1 example2 loopmacro

