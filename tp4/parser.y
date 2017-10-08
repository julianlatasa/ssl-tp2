/*** Definiciones ***/
%code top{
	#include <stdio.h>
	#include "scanner.h"
	#include "tokens.h"
}
%code provides {
	void yyerror(const char *s);
	extern int nerrlex;
}
%defines "parser.h"
%output "parser.c"
%union {
	int    num;
	char   *str;
}
%token<str> IDENTIFICADOR
%token<num> CONSTANTE

%code {
	char *token_names[] = {"Identificador", "Constante"};
}

%% /*** Reglas BNF ***/

programa : "programa" sector_definicion_variables codigo "fin"

sector_definicion_variables : "variables" definicion_variables

definicion_variables : "definir" IDENTIFICADOR";"
			     | "definir" IDENTIFICADOR";" definicion_variables

codigo : "codigo" conjunto_sentencias

conjunto_sentencias : sentencia";"
										| sentencia";" conjunto_sentencias

sentencia : "leer("lista_identificadores")"
	  | "escribir("lista_expresiones")"
	  | IDENTIFICADOR ":=" expresion

lista_identificadores : IDENTIFICADOR
		      | IDENTIFICADOR"," lista_identificadores

lista_expresiones : expresion
		  | expresion"," lista_expresiones

expresion : termino
	  | expresion "+" termino
	  | expresion "-" termino

termino : factor
	| termino "*" factor
	| termino "/" factor

factor: operando
      |	"("expresion")"
      | "-"expresion

operando : IDENTIFICADOR | CONSTANTE

%% /*** Codigo C ***/

int nerrlex = 0;
int main() {
	switch( yyparse() ){
	case 0:
		puts("Pertenece al LIC"); return 0;
	case 1:
		puts("No pertenece al LIC"); return 1;
	case 2:
		puts("Memoria insuficiente"); return 2;
	}
	return 0;
}

/* Informa la ocurrencia de un error. */
void yyerror(const char *s){
	printf("línea #%d: %s\n", yylineno, s);
	return;
}
