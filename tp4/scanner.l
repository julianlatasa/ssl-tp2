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
")"  																									return ')';
"("  																									return '(';
;  																										return ';';
,  																										return ',';
"+"							              												return '+';
-								              												return '-';
"*"							             													return '*';
"/"							              												return '/';

{letter}+({letter}|{number})*													{yylval = strdup(yytext);  return IDENTIFICADOR;}
{number}+ 	            															{sscanf(yytext, "%s", yylval); return CONSTANTE;}

[[:space:]]+																					;
"//".* 																								;

{number}+{letter}+({letter}|{number})*								{nerrlex++; yyerror("Error Lexico, Constante con sufijo invalido: ");}
{letter}+({letter}|{number}|{caracter_invalido})*			{nerrlex++; yyerror("Error léxico: identificador inválido: ");}
{caracter_invalido}+																	{nerrlex++; yyerror("Error léxico: cadena desconocida: ");}
.																											{nerrlex++; yyerror("Error léxico: caracter desconocido: ");}

%%
