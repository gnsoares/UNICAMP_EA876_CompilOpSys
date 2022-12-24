
%{
#include <stdio.h>
#include <string.h>
%}

USERNAME [[:alnum:]]{1,2}|[[:alnum:]][[:alnum:]\.\_\-]+[[:alnum:]]
DOMAIN {USERNAME}\.?
EMAIL {USERNAME}@{DOMAIN} 

%%

{EMAIL}                                   { int len = strlen(yytext);
                                            if (yytext[len - 1] == '.')
                                              yytext[len - 1] = '\0';
                                            printf("%s\n", yytext);
                                          }
[[:space:]]+                              ;
[[:^space:]]+                             ;

%%

int main() {
  yylex();
  return 0;
}