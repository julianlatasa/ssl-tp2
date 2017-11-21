#include "symbol.h"
#include "semantic.h"
#include "parser.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


static int num_temp = 0;
static int semantic_err = 0;

void do_read(const char* id_name) {
	static char err_msg_string[] = "Error semantico: identificador %s NO declarado";
	static char ok_msg_string[] = "Read %s, Integer\n";
	char *return_msg;
	if (!exist(id_name)) {
		asprintf(&return_msg,err_msg_string, id_name);
		yyerror(return_msg);
		add_semantic_error();
		free(return_msg);
		return;
	} 
	printf(ok_msg_string, id_name);
}

char * do_operation(char * operation, char * param1, char * param2){
  //printf("MULT %s, %s\n", $$, $3); $$ = $1;}
 char * name = "Temp#1"; // TODO: Concatenar Temp# con el número.
 printf("%s: %s %s \n", operation, param1, param2);
// add_dict(name);

 return name;
}

void add_semantic_error() {
	semantic_err++;
}

int semantic_error() {
	return semantic_err;
}
