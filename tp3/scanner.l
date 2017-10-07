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
punctuation_character_coment  "//"

/* Operadores */
operator_suma \+
operator_resta \-
operator_mult \*
operator_div \/

caracter_invalido [^letter|number| \t\n\r;()/*-+,-]

/*** Reglas ***/
%%
programa																			return RWORD_PROGRAMA;
variables   																	return RWORD_VARIABLES;
codigo    																		return RWORD_CODIGO;
fin     																			return RWORD_FIN;
definir     																	return RWORD_DEFINIR;
leer    																			return RWORD_LEER;
escribir								    	 								return RWORD_ESCRIBIR;
{operator_resta}              								return OPER_MENOS;
{letter}+({letter}|{number})*									return IDENT;
{letter}+{caracter_invalido}+									printf("Error léxico: identificador inválido: %s\n", yytext);
{number}+ 	            											return CONST;
{number}+{letter}															printf("Error léxico: constante con sufijo inválido: %s\n", yytext);
{asignment_symbol}      											return ASIGNSYM;
{punctuation_character_pder}  								return PUNTCHAR_PDER;
{punctuation_character_pizq}  								return PUNTCHAR_PIZQ;
{punctuation_character_puntocoma}  						return PUNTCHAR_PUNTOCOMA;
{punctuation_character_coma}  								return PUNTCHAR_COMA;
{operator_suma}              									return OPER_MAS;
{operator_mult}             									return OPER_MULT;
{operator_div}              									return OPER_DIV;
[[:space:]]+																	;
punctuation_character_coment.* 								;
<<EOF>>																				return FDT;
{caracter_invalido}+													printf("Error léxico: cadena desconocida: %s\n", yytext);

%%
