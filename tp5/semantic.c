#include "symbol.h"
#include "semantic.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


static int num_temp = 0;

char * do_operation(char * operation, char * param1, char * param2){
  //printf("MULT %s, %s\n", $$, $3); $$ = $1;}
 char * name = "Temp#1"; // TODO: Concatenar Temp# con el número.
 printf("%s: %s %s \n", operation, param1, param2);
// add_dict(name);

 return name;
}
