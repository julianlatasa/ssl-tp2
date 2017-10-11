/*
 ============================================================================
 TP4 - 2017
 Titulo      : Trabajo Práctico N.o 4
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
      puts("Compilación terminada con éxito");
      break;
    case 1:
      puts("Errores de compilación");
     break;
    case 2:
      puts("Memoria insuficiente");
      break;
  }

  printf("Errores sintácticos: %d - Errores léxicos: %d\n", yynerrs, nerrlex);

}

/* Informa la ocurrencia de un error. */
void yyerror(const char *s){
  printf("línea #%d: %s %s\n", yylineno, s, yytext);
  return;
}
