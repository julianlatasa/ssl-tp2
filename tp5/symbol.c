#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "symbol.h"

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
		printf("Guardado %s en la posición %d. \n", nombre, pos);
		return 1;
	}
	printf("ERROR: %s ya existe en el diccionario. \n", nombre); //TODO: Usar yyerror.
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
