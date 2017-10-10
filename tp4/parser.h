/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_PARSER_H_INCLUDED
# define YY_YY_PARSER_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    IDENTIFICADOR = 258,
    CONSTANTE = 259,
    RWORD_PROGRAMA = 260,
    RWORD_VARIABLES = 261,
    RWORD_CODIGO = 262,
    RWORD_FIN = 263,
    RWORD_DEFINIR = 264,
    RWORD_LEER = 265,
    RWORD_ESCRIBIR = 266,
    ASIGNSYM = 267,
    PUNTCHAR_PIZQ = 268,
    PUNTCHAR_PDER = 269,
    PUNTCHAR_PUNTOCOMA = 270,
    PUNTCHAR_COMA = 271,
    PUNTCHAR_COMENT = 272,
    OPER_MAS = 273,
    OPER_MENOS = 274,
    OPER_MULT = 275,
    OPER_DIV = 276,
    ERROR_CONST = 277,
    ERROR_IDENT = 278,
    ERROR_DESC = 279,
    FDT = 280
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 13 "parser.y" /* yacc.c:1909  */

	int    num;
	char   *str;

#line 85 "parser.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);
/* "%code provides" blocks.  */
#line 6 "parser.y" /* yacc.c:1909  */

	void yyerror(const char *s);
	extern int nerrlex;
	extern int yynerrs;

#line 104 "parser.h" /* yacc.c:1909  */

#endif /* !YY_YY_PARSER_H_INCLUDED  */
