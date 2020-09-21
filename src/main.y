%{
// Gustavo Nascimento Soares 217530

#include <stdio.h>

void yyerror(char *c);
int yylex(void);

%}

%union {
    int value;
    char label;
}

%token OPEN_PAR CLOSE_PAR PLUS TIMES SLASH CIRCUMFLEX NUMBER VAR EQUALS EOL

// precedencia: exponenciacao > multiplicao ou divisao > adicao
%left PLUS
%left TIMES SLASH
%left CIRCUMFLEX

%%

// fim do parse: levar resultado da pilha ao reg A
program:
    program line | ;

// uma linha pode conter uma atribuicao ou uma expressao
line:
    attribution EOL |
    expression EOL{
        printf("       POP A;\n");
    };

// expressao encontrada: guardar valor do reg A na pilha
expression:
    // parenteses tem a maior precendencia entre as expressoes
    OPEN_PAR expression CLOSE_PAR |
    exponentiation {
        printf("       PUSH A;\n");
    } |
    multiplication {
        printf("       PUSH A;\n");
    } |
    division {
        printf("       PUSH A;\n");
    } |
    addition {
        printf("       PUSH A;\n");
    } |
    NUMBER {
        printf("       PUSH %d;\n", $<value>1);
    } |
    VAR {
        printf("       PUSH [%d];\n", $<label>1 + 230 - 'a');
    }
    ;

// exponenciacao inicializa os registradores e chama a subrotina
// o resultado é gurdado no reg A
exponentiation:
    expression CIRCUMFLEX expression {
        printf("       POP B;\n");
        printf("       POP C;\n");
        printf("       MOV A, 1;\n");
        printf("       CALL exp;\n");
    };

// multiplicacao retira os valores da pilha e guarda o resultado no reg A
multiplication:
    expression TIMES expression {
        printf("       POP B;\n");
        printf("       POP A;\n");
        printf("       MUL B;\n");
    };

// divisao retira os valores da pilha e guarda o resultado no reg A
division:
    expression SLASH expression {
        printf("       POP B;\n");
        printf("       POP A;\n");
        printf("       DIV B;\n");
    };

// adicao retira os valores da pilha e guarda o resultado no reg A
addition:
    expression PLUS expression {
        printf("       POP B;\n");
        printf("       POP A;\n");
        printf("       ADD A, B;\n");
    };

// atribuicao retira um valor da pilha e guarda o resultado no reg A
// do reg A, o valor é guardado na RAM na posição correspondente à variável
attribution:
    VAR EQUALS expression {
        printf("       POP A;\n");
        printf("       MOV [%d], A;\n", $<label>1 + 230 - 'a');
    };

%%

void yyerror(char *s) {
  printf("\n");
}

int main() {

    // inicialização do programa
    printf("    MOV A, 0;\n");
    printf("    MOV B, 0;\n");
    printf("    MOV C, 0;\n");
    printf("    MOV D, 0;\n");

    // mover o início da pilha em 2 posições permite usar os
    // endereços de 230 a 255 para guardar os valores das variáveis
    printf("    MOV SP, 229;\n");
    printf("    JMP start;\n\n");

    // definicao da subrotina de exponenciacao
    printf("exp: CMP B, 0;\n");
    printf("     JZ ret;\n");
    printf("     MUL C;\n");
    printf("     DEC B;\n");
    printf("     JMP exp;\n");
    printf("ret: RET;\n\n");

    // inicio do programa
    printf("start:\n");

    // parse da expressao
    yyparse();

    // parada de execucao
    printf("       HLT;\n");
    return 0;
}
