CCompiler=gcc
CompilerFlags = -lfl

all: tp3

scanner.c: scanner.l
	flex scanner.l

tp3: scanner.c main.c
	$(CCompiler) -o scanner ./main.c ./src/scanner.c -I./src $(CompilerFlags)
