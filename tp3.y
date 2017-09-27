/*** Definiciones ***/ 
%code top{
	#include <stdio.h>
	#include "tp2scanner.h"
}
%code provides {
	void yyerror(const char *s);
	extern int nerrlex;
}
%defines "tp2parser.h"
%output "tp2parser.c"
%union {
	int    num;
	char   *str;
}
%token<str> IDENT
%token<num> CONST

%code {
	char *token_names[] = {"IDENT", "CONST"};
}

%% /*** Ruglas BNF ***/

todo : RWORDPROGRAMA defvars defcodigo RWORDFIN
defvars : RWORDVARIABLES definirvar
definirvar: RWORDDEFINIR IDENT PUNTCHAR_PUNTOCOMA
		  | RWORDDEFINIR IDENT PUNTCHAR_PUNTOCOMA definirvar
defcodigo : RWORDCODIGO defsent
defsent : sentencia PUNTCHAR_PUNTOCOMA 
		| sentencia PUNTCHAR_PUNTOCOMA defsent
sentencia : RWORDLEER PUNTCHAR_PIZQ listaident PUNTCHAR_PDER 
          | RWORDESCRIBIR PUNTCHAR_PIZQ listaexp PUNTCHAR_PDER
		  | IDENT ASIGNSYM exp
listaident : IDENT 
		   | IDENT PUNTCHAR_COMA listaident
listaexp : exp 
         | exp PUNTCHAR_COMA listaexp
exp : termino 
    | exp OPER_SUMA termino 
    | exp OPER_RESTA termino 
termino : factor 
		| termino OPER_MULT factor
		| termino OPER_DIV factor
factor : operando 
       | OPER_RESTA operando 
	   | PUNTCHAR_PIZQ exp PUNTCHAR_PDER
	   | OPER_RESTA exp
operando : IDENT 
         | CONST

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

