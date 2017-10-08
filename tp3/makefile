CCompiler=gcc
CompilerFlags = -lfl  

all: tp3

scanner.c: scanner.l
	flex scanner.l

tp3: scanner.c main.c
	$(CCompiler) -o tp3 ./main.c ./src/scanner.c -I./src $(CompilerFlags)
	rm ./src/scanner.h ./src/scanner.c
	
