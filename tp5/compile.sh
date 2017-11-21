#!/bin/bash
flex -l scanner.l && bison -d parser.y && gcc -o tp5 main.c parser.c scanner.c semantic.c symbol.c -lfl -D _GNU_SOURCE && ./tp5 < ./docs/entradaerr2.txt 

