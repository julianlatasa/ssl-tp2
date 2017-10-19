/*** Definiciones ***/
%code top{
	#include <stdio.h>
	#include "scanner.h"
}
%code provides {
	void yyerror(const char *s);
	extern int nerrlex;
	extern int yynerrs;
}
%defines "parser.h"
%output "parser.c"
%token IDENTIFICADOR CONSTANTE
%token RWORD_PROGRAMA RWORD_VARIABLES RWORD_CODIGO RWORD_FIN RWORD_DEFINIR RWORD_LEER RWORD_ESCRIBIR
%token ASIGNSYM
%left '+' '-'
%left '*' '/'
%token '(' ')'
%left ',' ';'


%define parse.error verbose
%define api.value.type {char *}

%% /*** Reglas BNF ***/
todo	: programa { if (yynerrs || nerrlex) YYABORT;}

programa : RWORD_PROGRAMA sector_definicion_variables codigo RWORD_FIN

sector_definicion_variables : RWORD_VARIABLES definicion_variables

definicion_variables : definicion_variables definicion
					 | definicion

definicion : RWORD_DEFINIR IDENTIFICADOR ';' { printf("definir %s\n", $2); }
					 | error ';'

codigo : RWORD_CODIGO conjunto_sentencias

conjunto_sentencias : conjunto_sentencias sentencia
										| sentencia

sentencia : RWORD_LEER '(' lista_identificadores ')' ';' { printf("leer\n"); }
	  | RWORD_ESCRIBIR '(' lista_expresiones ')' ';' { printf("escribir\n"); }
	  | IDENTIFICADOR ASIGNSYM expresion ';' { printf("asignación\n"); }
		| error  ';'

lista_identificadores : IDENTIFICADOR
		      | IDENTIFICADOR ',' lista_identificadores

lista_expresiones : expresion
		  | expresion ',' lista_expresiones

expresion : IDENTIFICADOR | CONSTANTE
	  | expresion '+' expresion { printf("suma\n"); }
	  | expresion '-' expresion { printf("resta\n"); }
		| expresion '*' expresion { printf("multiplicación\n"); }
		| expresion '/' expresion { printf("división\n"); }
    |	'(' expresion ')' { printf("paréntesis\n"); }
    | '-' expresion { printf("inversión\n"); }


%%
