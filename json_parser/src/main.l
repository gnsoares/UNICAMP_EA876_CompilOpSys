%{
#include <stdlib.h>
#include "y.tab.h"

void yyerror(char *);
%}

INTEGER  0|\-?[1-9]([[:digit:]]+)?
FRACTION [[:digit:]]+
FLOAT    {INTEGER}\.{FRACTION}
EXPONENT ({FLOAT}|{INTEGER})[eE][+-]?{FRACTION}
NUMBER   {EXPONENT}|{FLOAT}|{INTEGER}
STRING   \"[^\"\\\/\b\f\n\r\t]+\"

%%

\{                  return open_curly;
\}                  return close_curly;
\[                  return open_square;
\]                  return close_square;
\:                  return colon;
\,                  return comma;
{STRING}            return string;
{NUMBER}            return number;
true                return true;
false               return false;
null                return null;
[[:space:]]         ;
[[:^space:]]        ;

%%

int yywrap() {
  return 1;
}
