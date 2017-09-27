/*** Definition section ***/ 
%{ /* C code to be copied verbatim */ 
%} 
 
/* This tells flex to read only one input file */ 
%option noyywrap 

%%     /*** Rules section ***/ 

/* [0-9]+ matches a string of one or more digits */ 
[0-9]+  { /* yytext is a string containing the matched text. */ 
            printf("Es una constante entera: %s\n", yytext);    
			return CONSTANTE;
		} 

/* [0-9]+ matches a string of one or more digits */ 
[a-zA-Z0-9]+  { /* yytext is a string containing the matched text. */ 
				printf("Es una identificador: %s\n", yytext);    
				return IDENTIFICADOR;
			  } 

		
.|\n    {   /* Ignore all other characters. */   
			return ERROR;
		} 
 
%% 
/*** C Code section ***/ 