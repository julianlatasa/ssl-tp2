/*** Definiciones ***/
%{
	#include <stdio.h>
	#include <strings.h>
	#include "tokens.h"
%}

/* Esto determina las opciones de flex */
%option header-file="src/scanner.h"
%option outfile="src/scanner.c"
%option yylineno
%option noinput
%option nounput


/*** Definicion General de Reglas ***/
/* Letras */
letter [a-zA-Z]

/* Números */
number [0-9]

caracter_invalido [[:punct:]]{-}[;=()/*+,-]

/*** Reglas ***/
%%
programa						return RWORD_PROGRAMA;
variables   						return RWORD_VARIABLES;
codigo    						return RWORD_CODIGO;
fin     						return RWORD_FIN;
definir     						return RWORD_DEFINIR;
leer    						return RWORD_LEER;
escribir						return RWORD_ESCRIBIR;

:=							return ASIGNSYM;
")"  							return ')';
"("  							return '(';
;  							return ';';
,  							return ',';
"+"							return '+';
-							return '-';
"*"							return '*';
"/"							return '/';

{letter}+({letter}|{number})*				return IDENT;
{number}+ 	            				return CONST;

[[:space:]]+						;
"//".* 							;

{number}+{letter}+({letter}|{number})*			printf("Error léxico: constante con sufijo inválido: %s\n", yytext);
{letter}+({letter}|{number}|{caracter_invalido})*	printf("Error léxico: identificador inválido: %s\n", yytext);
{caracter_invalido}+					printf("Error léxico: cadena desconocida: %s\n", yytext);
.							printf("Error léxico: caracter desconocido: %s\n", yytext);

%%
