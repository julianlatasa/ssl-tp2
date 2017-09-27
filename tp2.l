/*** Definiciones ***/ 
%{
	#include <stdio.h>
	#include "tokens.h"
%}

/* Esto determina las opciones de flex */ 
/* %option noyywrap */ 
/* Que lea solo un archivo */  

/*** Definicion General de Reglas ***/
reservedword_programa "programa"
reservedword_variables "variables"
reservedword_codigo "codigo"
reservedword_fin "fin"
reservedword_definir "definir"
reservedword_leer "leer"
reservedword_escribir "escribir"
letter [a-zA-Z0-9]
number [0-9]
asignmentsymbol ":=​"
punctuationcharacter "(" | ")"​ | ";"​ | ","​ | "//"​
operator "*" | "+"​ | "-" | "/"

/*** Reglas ***/
%%
{reservedword_programa}?    return RWORDPROGRAMA;
{reservedword_variables}?   return RWORDVARIABLES;
{reservedword_codigo}?    	return RWORDCODIGO;
{reservedword_fin}?    		return RWORDFIN;
{reservedword_definir}?     return RWORDDEFINIR;
{reservedword_leer}?    	return RWORDLEER;
{reservedword_escribir}?    return RWORDESCRIBIR;
{letter}+{letter|number}*	return IDENT;
{number}+ 	            	return CONST;
{asignmentsymbol}?      	return ASIGNSYM;
{punctuationcharacter}? 	return PUNTCHAR;
{operator}?             	return OPER;
[ \t\n\r]	 				;
<<EOF>>						return EOF;
.							return ERROR;
%%

char *token_names[] = {"RWORD_PROGRAMA", "RWORD_VARIABLES", "RWORD_CODIGO", "RWORD_FIN", "RWORD_DEFINIR", "RWORD_LEER", "RWORD_ESCRIBIR", "IDENT", "CONST", "ASIGNSYM", "PUNTCHAR", "OPER", "ERROR"};
int main() {
	enum token t;
	while ((t = yylex()) != EOF)
		printf("Token: %s\t\tValor: %s\n", token_names[t], yytext);
	return 0;
}

/*** Seccion de Codigo C ***/ 