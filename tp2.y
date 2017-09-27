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

todo	: listado {if (nerrlex) YYABORT;} 
listado : cte
	| listado cte
	;
cte	: ID {printf("Token: %s\t\tValor texto: %s\n", token_names[0], $<str>1);}
	| DECIMAL {printf("Token: %s\t\tValor entero: %d\n",
			token_names[1], $DECIMAL);}
	| REAL {printf("Token: %s\t\tValor real: %g\n", 
			token_names[2], $REAL);}
	;
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

