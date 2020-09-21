%{
// Gustavo Nascimento Soares 217530

#include <stdlib.h>
#include "y.tab.h"

void yyerror(char *);
%}

%%

\(                        {return OPEN_PAR;}
\)                        {return CLOSE_PAR;}
\+                        {return PLUS;}
\*                        {return TIMES;}
\/                        {return SLASH;}
\^                        {return CIRCUMFLEX;}
\=                        {return EQUALS;}
[[:digit:]]+              {// numeros so podem ser inteiros positivos
                           yylval.value = atoi(yytext); return NUMBER;}
[[:lower:]]               {// variaveis so podem ser caracteres minusculos a-z
                           yylval.label = yytext[0]; return VAR;}
"\n"                      {return EOL;}
[[:space:]]               ;
[[:^space:]]              ;

%%

int yywrap() {
  return 1;
}
