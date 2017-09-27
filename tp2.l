/*** Definiciones ***/ 
%{
	#include <stdio.h>
	#include "tokens.h"
%}

/* Esto determina las opciones de flex */ 
/* %option noyywrap */ /* Que lea solo un archivo */  

/*** Definicion General de Reglas ***/
reservedword "programa" | "variables" | "codigo" | "fin" | "definir" | "leer" | "escribir"
identifier [a-zA-Z0-9] /* Ojo que aca un identificador arranca con 0-9 y esto no deberia de pasar */
constant [0-9]
asignmentsymbol \:\=​
punctuationcharacter \( | \)​ | \;​ | \,​ | \/\/​
operator \* | \+​ | \- | \/

/*** Reglas ***/
%%
{reservedword}?         return RWORD;
{identifier}*			return IDENT;
{constant}*             return CONST;
{asignmentsymbol}*      return ASIGNSYM;
{punctuationcharacter}* return PUNTCHAR;
{operator}*             return OPER;
\t|\n\|\r    			;
<<EOF>>					return EOF;
.						return ERROR;
%%

char *token_names[] = {"RWORD", "IDENT", "CONST", "ASIGNSYM", "PUNTCHAR", "OPER", "ERROR"};
int main() {
	enum token t;
	while ((t = yylex()) != EOF)
		printf("Token: %s\t\tValor: %s\n", token_names[t], yytext);
	return 0;
}

/*** Seccion de Codigo C ***/ 