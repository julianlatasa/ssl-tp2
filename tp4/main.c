/*
 ============================================================================
 TP3 - 2017
 Titulo      : Trabajo Práctico N.o 3
 Grupo Nro.  : 03
 Integrantes : Decurgez Damian (149-341/3)
               Galliano Ignacio (156-363/4)
               Latasa Julian (150-163/0)
               Muscatiello Juan (156-098/0)
 ============================================================================
 */

#include <stdio.h>
#include <strings.h>
#include "parser.h"
#include "scanner.h"

int nerrlex = 0;
int main() {
  switch(yyparse()){
    case 0:
      puts("Compilacion Exitosa");
      break;
    case 1:
      printf("Errores sintacticos: %d, errores semanticos: %d\n", yynerrs, nerrlex); 
      puts("Error de Compilacion\n");
     break;
    case 2:
      puts("Memoria insuficiente");
      break;
  }
 
}

/* Informa la ocurrencia de un error. */
void yyerror(const char *s){
  printf("línea #%d: %s\n", yylineno, s);
  return;
}
