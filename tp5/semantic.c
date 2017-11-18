#include "symbol.h"
#include "semantic.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static int num_temp = 1;

char * do_operation(char * operation, char * param1, char * param2){
  //printf("MULT %s, %s\n", $$, $3); $$ = $1;}
 char temp_name[9];
 sprintf(temp_name, "%s%d", "Temp#", num_temp++);
 add_dict(temp_name);

 printf("%s: %s %s \n", operation, param1, param2);
 return temp_name;
}
