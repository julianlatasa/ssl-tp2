/*** Definiciones ***/
%code top{
	#include <stdio.h>
	#include "semantic.h"
	#include "symbol.h"
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
%precedence MENOS_UNARIO


%define parse.error verbose
%define api.value.type {char *}

%% /*** Reglas BNF ***/
todo	: programa { if (yynerrs || nerrlex) YYABORT;}

programa : RWORD_PROGRAMA { printf("Load rtl,\n"); } sector_definicion_variables codigo RWORD_FIN

sector_definicion_variables : RWORD_VARIABLES definicion_variables

definicion_variables : definicion_variables definicion
					 | definicion

definicion : RWORD_DEFINIR IDENTIFICADOR ';' {  add_dict($2);} //printf("Declare %s,Integer\n", $2);
					 | error ';'

codigo : RWORD_CODIGO conjunto_sentencias

conjunto_sentencias : conjunto_sentencias sentencia
										| sentencia

sentencia : RWORD_LEER '(' lista_identificadores ')' ';'
	  | RWORD_ESCRIBIR '(' lista_expresiones ')' ';' { printf("escribir\n"); }
	  | IDENTIFICADOR ASIGNSYM expresion ';' { printf("asignación\n"); }
		| error  ';'

lista_identificadores : IDENTIFICADOR { do_read($1); } //printf("Read %s, Integer\n", $1);
		      | IDENTIFICADOR ',' lista_identificadores { do_read($1); }

lista_expresiones : expresion
		  | expresion ',' lista_expresiones

expresion : IDENTIFICADOR { do_read($1); }
	  | CONSTANTE
	  | expresion '+' expresion { printf("suma\n"); }
	  | expresion '-' expresion { printf("resta\n"); }
		| expresion '*' expresion { $$ = do_operation("MULT", $$, $3); } //printf("MULT %s, %s\n", $$, $3); $$ = $1;}
		| expresion '/' expresion { printf("división\n"); }
    |	'(' expresion ')' { printf("paréntesis\n"); }
    | '-' expresion %prec MENOS_UNARIO { printf("Declar\nINV %s\n", $2); $$ = $2;}


%%
