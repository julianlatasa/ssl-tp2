/*** Definition section ***/ 
%{ /* C code to be copied verbatim */ %} 
 
%token <symp> IDENTIFICADOR 
%token <dval> CONSTANTE
%token <symp> OTRO 
 
%type <symp> expression 
 
%% /*** Rules section ***/ 
statement_list: statement '\n'
                | statement_list statement '\n' 
 
statement: IDENTIFICADOR '=' expression { $1->value = $3; }
           | expression { printf("= %g\n", $1); } 
 
expression: CONSTANTE 
 
%% /*** C Code section ***/