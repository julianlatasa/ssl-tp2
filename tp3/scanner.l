/*** Definiciones ***/
%{
	#include <stdio.h>
	#include <strings.h>
	#include "tokens.h"
%}

/* Esto determina las opciones de flex */
%option header-file="scanner.h"
%option outfile="scanner.c"
%option yylineno


/*** Definicion General de Reglas ***/

/* Palabras reservadas */
reserved_word_programa "programa"
reserved_word_variables "variables"
reserved_word_codigo "codigo"
reserved_word_fin "fin"
reserved_word_definir "definir"
reserved_word_leer "leer"
reserved_word_escribir "escribir"

/* Letras */
letter [a-zA-Z]

/* Números */
number [0-9]

/* Símbolo de asignación */
asignment_symbol :=

/* Caracteres de puntuación */
punctuation_character_pizq \(
punctuation_character_pder \)
punctuation_character_puntocoma ;
punctuation_character_coma ,
punctuation_character_coment  //

/* Operadores */
operator_suma \+
operator_resta \-
operator_mult \*
operator_div \/

/*** Reglas ***/
%%
{operator_div}{operator_div}{letter}* 				;
{reserved_word_programa}?						return RWORD_PROGRAMA;
{reserved_word_variables}?   				return RWORD_VARIABLES;
{reserved_word_codigo}?    					return RWORD_CODIGO;
{reserved_word_fin}?    						return RWORD_FIN;
{reserved_word_definir}?     				return RWORD_DEFINIR;
{reserved_word_leer}?    						return RWORD_LEER;
{reserved_word_escribir}?   	 			return RWORD_ESCRIBIR;
{letter}+({letter}|{number})*				return IDENT;
{number}+ 	            						return CONST;
{asignment_symbol}      						return ASIGNSYM;
{punctuation_character_pder}? 			return PUNTCHAR_PDER;
{punctuation_character_pizq}? 			return PUNTCHAR_PIZQ;
{punctuation_character_puntocoma}? 	return PUNTCHAR_PUNTOCOMA;
{punctuation_character_coma}? 			return PUNTCHAR_COMA;
{operator_suma}?             				return OPER_MAS;
{operator_resta}?             			return OPER_MENOS;
{operator_mult}?             				return OPER_MULT;
{operator_div}?             				return OPER_DIV;
[ \t\n\r]	 													;
<<EOF>>															return FDT;
.																		{
																				//nerrlex++;
																				//yyerror("Caracter no valido\n");
																				return ERROR;
																		};
%%

/*** Seccion de Codigo C ***/
/* TODO: hacerlo en main.c */

char *token_names[] = {
	"Programa",
	"Variables",
	"Código",
	"Fin",
	"Definir",
	"Leer",
	"Escribir",
	"Identificador",
	"Constante",
	"Asignación",
	"\'(\'", // Paréntesis izquierdo
	"\')\'", // Paréntesis derecho
	"\';\'", // Punto y coma
	"\',\'", // Coma
	"Comentario",
	"\'+\'", // Más
	"\'-\'", // Menos
	"\'*\'", // Por
	"\'/\'", // Dividir
	"Fin de Archivo",
	"ERROR"
};
int main() {
	enum token t;
	while (t != FDT){
		t = yylex();
		printf("Token: %s\t\tLexema: %s\n", token_names[t], yytext);
	}

	return 0;
}
