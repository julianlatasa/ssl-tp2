/*** Definiciones ***/ 
%{
	#include <stdio.h>
	#include <strings.h>
	#include "tokens.h"
%}

/* Esto determina las opciones de flex */ 
%option header-file="tp2scanner.h"
%option outfile="tp2scanner.c"
%option yylineno

/*** Definicion General de Reglas ***/
reservedword_programa "programa"
reservedword_variables "variables"
reservedword_codigo "codigo"
reservedword_fin "fin"
reservedword_definir "definir"
reservedword_leer "leer"
reservedword_escribir "escribir"
letter [a-zA-Z]
number [0-9]
asignmentsymbol ":=​"
punctuationcharacter_pizq \(
punctuationcharacter_pder \)​
punctuationcharacter_puntocoma \;​
punctuationcharacter_coma \,​
punctuationcharacter_coment \/\/​
operator_suma \+
operator_resta \-
operator_mult \*
operator_div \/

/*** Reglas ***/
%%
{reservedword_programa}?    	return RWORDPROGRAMA;
{reservedword_variables}?   	return RWORDVARIABLES;
{reservedword_codigo}?    		return RWORDCODIGO;
{reservedword_fin}?    			return RWORDFIN;
{reservedword_definir}?     	return RWORDDEFINIR;
{reservedword_leer}?    		return RWORDLEER;
{reservedword_escribir}?   	 	return RWORDESCRIBIR;
{letter}+({letter}|{number})*	{yylval.str = strdup(yytext);
								return IDENT;}
{number}+ 	            		{sscanf(yytext, "%d", &yylval.num);
								return CONST;}
{asignmentsymbol}?      		return ASIGNSYM;
{punctuationcharacter_pizq}? 	return PUNTCHAR_PIZQ;
{punctuationcharacter_pder}? 	return PUNTCHAR_PDER;
{punctuationcharacter_puntocoma}? 	return PUNTCHAR_PUNTOCOMA;
{punctuationcharacter_coma}? 	return PUNTCHAR_COMA;
{punctuationcharacter_coment}? 	return PUNTCHAR_COMENT;
{operator_suma}?             	return OPER_SUMA;
{operator_resta}?             	return OPER_RESTA;
{operator_mult}?             	return OPER_MULT;
{operator_div}?             	return OPER_DIV;
[ \t\n\r]	 					;
<<EOF>>							return EOF;
.								{nerrlex++; yyerror("Caracter no valido\n"); return ERROR};
%%

char *token_names[] = {"RWORD_PROGRAMA", "RWORD_VARIABLES", "RWORD_CODIGO", "RWORD_FIN", "RWORD_DEFINIR", "RWORD_LEER", "RWORD_ESCRIBIR", "IDENT", "CONST", "ASIGNSYM", "PUNTCHAR", "OPER", "EOF", "ERROR"};
int main() {
	enum token t;
	while ((t = yylex()) != EOF)
		printf("Token: %s\t\tValor: %s\n", token_names[t], yytext);
	return 0;
}

/*** Seccion de Codigo C ***/ 