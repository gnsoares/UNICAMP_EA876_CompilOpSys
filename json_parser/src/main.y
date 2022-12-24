%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(char *c);
int yylex(void);
%}

%token string number true false null colon comma open_curly close_curly open_square close_square

%%

JSON: JSON OBJECT {printf("VALIDO\n");}
    | ;

OBJECT: open_curly ATTR_LIST close_curly
      | open_curly close_curly;

ARRAY: open_square VALUE_LIST close_square
     | open_square close_square; 

VALUE_LIST: VALUE_LIST comma VALUE
          | VALUE; 

ATTR_LIST: ATTR_LIST comma ATTR
         | ATTR; 

ATTR: string colon VALUE;

VALUE: string | number | OBJECT | ARRAY | true | false | null;

%%

void yyerror(char *s) {
  printf("INVALIDO\n");
}

int main() {
  yyparse();
  return 0;
}
