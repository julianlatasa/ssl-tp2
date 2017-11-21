#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "symbol.h"
#include "parser.h"

char *(dict[100]);
static int pos = 0;
// TODO Inicializar todos los elementos con 0

int add_dict(const char *nombre) {
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
//	char *errormsg =  malloc(strlen(msg) + strlen(yytext) + 3);
//	sprintf(errormsg, "%s: %s", msg, yytext);
	// TODO: Se podria hacer una funcion, o ver si hay alguna, que le pasamos un mensaje y una variable y devuelve un string
	// y se utilizaria aca y en el scanner.l
	char *err_msg = malloc(2000);
	sprintf(err_msg, "Error semantico: identificador %s ya declarado", nombre);
	yyerror(err_msg);
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
