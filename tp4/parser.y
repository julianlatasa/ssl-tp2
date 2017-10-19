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
%token PUNTCHAR_PIZQ
%token PUNTCHAR_PDER
%token PUNTCHAR_PUNTOCOMA
%token PUNTCHAR_COMA
%left OPER_MAS OPER_MENOS
%left OPER_MULT OPER_DIV

%define parse.error verbose
%define api.value.type {char *}

%% /*** Reglas BNF ***/
todo	: programa { if (yynerrs || nerrlex) YYABORT;}

programa : RWORD_PROGRAMA sector_definicion_variables codigo RWORD_FIN

sector_definicion_variables : RWORD_VARIABLES definicion_variables

definicion_variables : definicion_variables definicion
					 | definicion

definicion : RWORD_DEFINIR IDENTIFICADOR PUNTCHAR_PUNTOCOMA { printf("definir %s\n", $2); }
					 | error PUNTCHAR_PUNTOCOMA

codigo : RWORD_CODIGO conjunto_sentencias

conjunto_sentencias : conjunto_sentencias sentencia
										| sentencia

sentencia : RWORD_LEER PUNTCHAR_PIZQ lista_identificadores PUNTCHAR_PDER PUNTCHAR_PUNTOCOMA { printf("leer\n"); }
	  | RWORD_ESCRIBIR PUNTCHAR_PIZQ lista_expresiones PUNTCHAR_PDER PUNTCHAR_PUNTOCOMA { printf("escribir\n"); }
	  | IDENTIFICADOR ASIGNSYM expresion PUNTCHAR_PUNTOCOMA { printf("asignación\n"); }
		| error  PUNTCHAR_PUNTOCOMA

lista_identificadores : IDENTIFICADOR
		      | IDENTIFICADOR PUNTCHAR_COMA lista_identificadores

lista_expresiones : expresion
		  | expresion PUNTCHAR_COMA lista_expresiones

expresion : IDENTIFICADOR | CONSTANTE
	  | expresion OPER_MAS expresion { printf("suma\n"); }
	  | expresion OPER_MENOS expresion { printf("resta\n"); }
		| expresion OPER_MULT expresion { printf("multiplicación\n"); }
		| expresion OPER_DIV expresion { printf("división\n"); }
    |	PUNTCHAR_PIZQ expresion PUNTCHAR_PDER { printf("paréntesis\n"); }
    | OPER_MENOS expresion { printf("inversión\n"); }


%%
