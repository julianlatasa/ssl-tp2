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
{letter}+({letter}|{number})*				{ yylval = strdup(yytext);  return IDENTIFICADOR; }
{number}+ 	            				{ sscanf(yytext, "%s", yylval); return CONSTANTE; }
[[:space:]]+						;
"//".* 							;
{number}+{letter}+({letter}|{number})*			{
								nerrlex++;
								char msg_basico[] = "Error Lexico, Constante con sufijo invalido";
								char *msg; msg = malloc(strlen(msg_basico) + strlen(yytext));
								sprintf(msg, "%s: %s", msg_basico, yytext);
								yyerror(msg);
							}
{letter}+({letter}|{number}|{caracter_invalido})*	{
								nerrlex++;
								char msg_basico[] = "Error léxico: identificador inválido";
								char *msg; msg = malloc(strlen(msg_basico) + strlen(yytext));
								sprintf(msg, "%s: %s", msg_basico, yytext);
								yyerror(msg);
							}
{caracter_invalido}+					{
								nerrlex++;
								char msg_basico[] = "Error léxico: cadena desconocida";
								char *msg; msg = malloc(strlen(msg_basico) + strlen(yytext));
								sprintf(msg, "%s: %s", msg_basico, yytext);
								yyerror(msg);
							}
.							{
								nerrlex++;
								char msg_basico[] = "Error léxico: caracter desconocido";
								char *msg; msg = malloc(strlen(msg_basico) + strlen(yytext));
								sprintf(msg, "%s: %s", msg_basico, yytext);
								yyerror(msg);
							}

%%
