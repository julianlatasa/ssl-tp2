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

programa : RWORD_PROGRAMA { printf("Load rtl,\n"); } sector_definicion_variables codigo RWORD_FIN { printf("Stop\n"); }

sector_definicion_variables : RWORD_VARIABLES definicion_variables

definicion_variables : definicion_variables definicion
					 | definicion

definicion : RWORD_DEFINIR IDENTIFICADOR ';' {  add_dict($2);} //printf("Declare %s,Integer\n", $2);
					 | error ';'

codigo : RWORD_CODIGO conjunto_sentencias

conjunto_sentencias : conjunto_sentencias sentencia
										| sentencia

sentencia : RWORD_LEER '(' lista_identificadores ')' ';'
	  | RWORD_ESCRIBIR '(' lista_expresiones ')' ';' { do_write($3); } // printf("escribir\n"); }
	  | IDENTIFICADOR ASIGNSYM expresion ';' {  do_assign($2, $3); }// printf("asignación\n"); }
		| error  ';'

lista_identificadores : IDENTIFICADOR { do_read($1); } //printf("Read %s, Integer\n", $1);
		      | IDENTIFICADOR ',' lista_identificadores { do_read($1); }

lista_expresiones : expresion
		  | expresion ',' lista_expresiones

expresion : IDENTIFICADOR { if (declared_id($1) == 0) YYERROR; }
	  | CONSTANTE
	  | expresion '+' expresion { $$ = do_operation("ADD", $1, $3); }//printf("suma\n"); }
	  | expresion '-' expresion { $$ = do_operation("SUBS", $1, $3); } //printf("resta\n"); }
		| expresion '*' expresion { $$ = do_operation("MULT", $1, $3); } //printf("MULT %s, %s\n", $$, $3); $$ = $1;}
		| expresion '/' expresion { $$ = do_operation("DIV", $1, $3); } //printf("división\n"); }
    |	'(' expresion ')' 
    | '-' expresion %prec MENOS_UNARIO { $$ = do_operation("INV", $2, ""); } // printf("INV %s\n", $2); $$ = $2;}


%%
