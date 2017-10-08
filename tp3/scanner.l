/*** Definiciones ***/
%{
	#include <stdio.h>
	#include <strings.h>
	#include "tokens.h"
%}

/* Esto determina las opciones de flex */
%option header-file="scanner.h"
%option outfile="scanner.c"
%option yylineno
%option noinput
%option nounput


/*** Definicion General de Reglas ***/
/* Letras */
letter [a-zA-Z]

/* Números */
number [0-9]

caracter_invalido [^letter|number| \t\n\r;()/*-+,-]

/*** Reglas ***/
%%
programa																			return RWORD_PROGRAMA;
variables   																	return RWORD_VARIABLES;
codigo    																		return RWORD_CODIGO;
fin     																			return RWORD_FIN;
definir     																	return RWORD_DEFINIR;
leer    																			return RWORD_LEER;
escribir								    	 								return RWORD_ESCRIBIR;
-								              								return OPER_MENOS;
{letter}+({letter}|{number})*									return IDENT;
{letter}+{caracter_invalido}+									printf("Error léxico: identificador inválido: %s\n", yytext);
{number}+ 	            											return CONST;
{number}+{letter}															printf("Error léxico: constante con sufijo inválido: %s\n", yytext);
:=								      											return ASIGNSYM;
")"  																					return PUNTCHAR_PDER;
"("  																					return PUNTCHAR_PIZQ;
;  																						return PUNTCHAR_PUNTOCOMA;
,  																						return PUNTCHAR_COMA;
"+"							              								return OPER_MAS;
"*"							             									return OPER_MULT;
"/"							              								return OPER_DIV;
[[:space:]]+																	;
"//".* 																				;
<<EOF>>																				return FDT;
{caracter_invalido}+													printf("Error léxico: cadena desconocida: %s\n", yytext);

%%
