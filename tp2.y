/*** Definiciones ***/ 
%code top{
	#include <stdio.h>
	#include "tp2scanner.h"
}
%code provides {
	void yyerror(const char *s);
	extern int nerrlex;
}
%defines "tp2arser.h"
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
definirvar: RWORDDEFINIR IDENT PUNTCHAR
		  | RWORDDEFINIR IDENT PUNTCHAR definirvar
defcodigo : RWORDCODIGO defsent
defsent : sentencia PUNTCHAR 
		| sentencia PUNTCHAR defsent
sentencia : RWORDLEER PUNTCHAR listaident PUNTCHAR 
          | RWORDESCRIBIR PUNTCHAR listaexp PUNTCHAR 
		  | IDENT ASIGNSYM exp
listaident : IDENT 
		   | IDENT PUNTCHAR listaident
listaexp : exp 
         | exp PUNTCHAR listaexp
exp : termino 
    | exp OPER termino 
termino : factor 
		| termino OPER factor
factor : operando 
       | - operando 
	   | PUNTCHAR exp PUNTCHAR 
	   | - exp
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

