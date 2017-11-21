#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "semantic.h"
#include "symbol.h"
#include "parser.h"

char *(dict[100]);
static int pos = 0;

int add_dict(const char *nombre) {
	static char err_msg_string[] = "Error semantico: identificador %s ya declarado";
	if (pos == 0) {
		dict[pos] = malloc(1);
		dict[pos] = 0;
	}

	if (!exist(nombre)) {
		dict[pos] = malloc(strlen(nombre)+1);
		strcpy(dict[pos],nombre);
		pos++;
		printf("Declare %s, Integer\n", nombre);
		return 1;
	}
	char *err_msg;
	asprintf(&err_msg, err_msg_string, nombre);
	yyerror(err_msg);
	add_semantic_error();
	free(err_msg);
	return 0;
}

int exist(const char *nombre) {
	int i = 0;
	while (dict[i] != 0) {
		if (strcmp(dict[i],nombre) == 0)
			return 1;
		i++;
	}
	return 0;
}

