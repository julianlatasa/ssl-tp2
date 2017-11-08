#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "symbol.h"

char *(dict[20]);
static int pos = 0;
// TODO Inicilizar todos los elementos con 0

int add_dict(const char *nombre) {
	if (pos == 0) {
		dict[pos] = malloc(1);
		dict[pos] = 0;		
	}

	if (!exist(nombre))
	{
		dict[pos] = malloc(strlen(nombre)+1);
		strcpy(dict[pos],nombre);
		pos++;
		return 1;
	}
	printf("error");
	return 0;
}

int exist(const char *nombre) {
	int i=0;
	while (dict[i] != 0) {
		if (strcmp(dict[i],nombre) == 0)
			return 0;
		i++;
	}
	return 1;
}
