#include "symbol.h"
#include "semantic.h"
#include "parser.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static int num_temp = 1;
static int semantic_err = 0;

void do_read(const char* id_name) {
	static char ok_msg_string[] = "Read %s, Integer\n";
	if (!declared_id(id_name)) {
		return;
	} 
	printf(ok_msg_string, id_name);
}

void do_write(const char* id_name) {
	static char ok_msg_string[] = "Write %s, Integer\n";
	if (!declared_id(id_name)) {
		return;
	} 
	printf(ok_msg_string, id_name);
}

void do_assign(const char* id_name, const char* temp_id) {
	static char ok_msg_string[] = "Store %s, %s\n";
	if (!declared_id(id_name)) {
		return;
	} 
	if (!declared_id(temp_id)) {
		return;
	} 
	printf(ok_msg_string, temp_id, id_name);
}

char * do_operation(char * operation, char * param1, char * param2){
  //printf("MULT %s, %s\n", $$, $3); $$ = $1;}
 char* temp_name = malloc(9);
 sprintf(temp_name, "%s%d", "Temp#", num_temp++);
 add_dict(temp_name);

 printf("%s %s,%s,%s \n", operation, param1, param2, temp_name);
 return temp_name;
}

int declared_id(const char *id_name){
	static char err_msg_string[] = "Error semantico: identificador %s NO declarado";
	char *return_msg;
	if (!exist(id_name)) {
		asprintf(&return_msg,err_msg_string, id_name);
		yyerror(return_msg);
		add_semantic_error();
		free(return_msg);
		return 0;
	}
	return 1;
}


void add_semantic_error() {
	semantic_err++;
}

int semantic_error() {
	return semantic_err;
}
