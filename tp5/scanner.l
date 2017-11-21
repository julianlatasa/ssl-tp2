/*** Definiciones ***/
%{
	#include <stdio.h>
	#include <strings.h>
	#include "parser.h"
	void msgerror(const char * msg, const char * yytext);
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

caracter_invalido [[:punct:]]{-}[:;()/*+,=-]

/*** Reglas ***/
%%
programa						return RWORD_PROGRAMA;
variables						return RWORD_VARIABLES;
codigo   						return RWORD_CODIGO;
fin     						return RWORD_FIN;
definir  						return RWORD_DEFINIR;
leer    						return RWORD_LEER;
escribir						return RWORD_ESCRIBIR;
:=							return ASIGNSYM;
")" 							return ')';
"("  							return '(';
;  							return ';';
,  							return ',';
"+"	   						return '+';
-							return '-';
"*"							return '*';
"/"							return '/';
{letter}+({letter}|{number})*				{ yylval = strdup(yytext); return IDENTIFICADOR; }
{number}+ 	            				{ yylval = strdup(yytext); return CONSTANTE; }
[[:space:]]+						;
"//".* 							;
{number}+{letter}+({letter}|{number})*			{ msgerror("Error Lexico, Constante con sufijo invalido: %s", yytext); }
{letter}+({letter}|{number}|{caracter_invalido})*	{ msgerror("Error léxico: identificador inválido: %s", yytext); }
{caracter_invalido}+					{ msgerror("Error léxico: cadena desconocida: %s", yytext); }
.							{ msgerror("Error léxico: caracter desconocido :%s", yytext); }

%%

void msgerror(const char * msg, const char * yytext){
	nerrlex++;
	char *errormsg;
	asprintf(&errormsg, msg, yytext);
	yyerror(errormsg);
	free(errormsg);
}
