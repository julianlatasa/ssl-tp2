/*** Definiciones ***/
%{
	#include <stdio.h>
	#include <strings.h>
	#include "parser.h"
	char* msgerror(const char * msg, const char * yytext);
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
{number}+{letter}+({letter}|{number})*			{ yyerror(msgerror("Error Lexico, Constante con sufijo invalido", yytext)); } // FREE
{letter}+({letter}|{number}|{caracter_invalido})*	{ yyerror(msgerror("Error léxico: identificador inválido", yytext)); }
{caracter_invalido}+					{ yyerror(msgerror("Error léxico: cadena desconocida", yytext)); }
.							{  yyerror(msgerror("Error léxico: caracter desconocido", yytext)); }

%%

char* msgerror(const char * msg, const char * yytext){
	nerrlex++;
  char *returnmsg =  malloc(strlen(msg) + strlen(yytext) + 3);
	sprintf(returnmsg, "%s: %s", msg, yytext);
  return returnmsg;
}
