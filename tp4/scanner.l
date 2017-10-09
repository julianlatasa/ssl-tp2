/*** Definiciones ***/
%{
	#include <stdio.h>
	#include <strings.h>
	#include "parser.h"
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

caracter_invalido [[:punct:]]{-}[;()/*-+,]+

/*** Reglas ***/
%%
programa																							return RWORD_PROGRAMA;
variables   																					return RWORD_VARIABLES;
codigo    																						return RWORD_CODIGO;
fin     																							return RWORD_FIN;
definir     																					return RWORD_DEFINIR;
leer    																							return RWORD_LEER;
escribir								    	 												return RWORD_ESCRIBIR;

:=								      															return ASIGNSYM;
")"  																									return PUNTCHAR_PDER;
"("  																									return PUNTCHAR_PIZQ;
;  																										return PUNTCHAR_PUNTOCOMA;
,  																										return PUNTCHAR_COMA;
"+"							              												return OPER_MAS;
-								              												return OPER_MENOS;
"*"							             													return OPER_MULT;
"/"							              												return OPER_DIV;

{letter}+({letter}|{number})*													return IDENTIFICADOR;
{number}+ 	            															return CONSTANTE;

[[:space:]]+																					;
"//".* 																								;

{number}+{letter}																			{nerrlex++; yyerror("Error Lexico, Constante con sufico invalido");}
{letter}+({letter}|{number}|{caracter_invalido})*			{nerrlex++; yyerror("Error léxico: identificador inválido");}
{caracter_invalido}+																	{nerrlex++; yyerror("Error léxico: cadena desconocida");}
.																											{nerrlex++; yyerror("Error léxico: caracter desconocido");}

%%
