## EA876 Trabalho 1 - Gustavo Nascimento Soares 217530
### Instruções de uso
----

### Entrada
Uma série de atribuições ou expressões matemáticas, uma em cada linha.

Uma expressão deve ser formada por números inteiros positivos incluindo as operações de adição, multiplicação, divisão e potenciação. As operações podem estar envolvidas em parênteses, bem como toda a expressão.

Uma atribuição deve ser da forma `var = expressao`. Cada variável pode ser apenas um caracter de A a Z minúsculo. Uma variável não pode ser utilizada antes de ter um valor atribuido.

### Saída
A saída é uma série de instruções assembly que podem ser executadas em (https://schweigi.github.io/assembler-simulator/] e o valor da expressão final será guardada no registrador A.

### Exemplo

| Entrada | Saída |
| ------- | ----- |
| ```a = 2``` | ```    MOV A, 0;``` |
| ```b = 3``` | ```    MOV B, 0;``` |
| ```(1+a)*b``` | ```    MOV C, 0;``` |
|  | ```    MOV B, 0;``` |
|  | ```    MOV C, 0;``` |
|  | ```    MOV D, 0;``` |
|  | ```    MOV SP, 229;``` |
|  | ```    JMP start;``` |
|  | `````` |
|  | ```exp: CMP B, 0;``` |
|  | ```     JZ ret;``` |
|  | ```     MUL C;``` |
|  | ```     DEC B;``` |
|  | ```     JMP exp;``` |
|  | ```ret: RET;``` |
|  | `````` |
|  | ```start:``` |
|  | ```       PUSH 2;``` |
|  | ```       POP A;``` |
|  | ```       MOV [230], A;``` |
|  | ```       PUSH 3;``` |
|  | ```       POP A;``` |
|  | ```       MOV [231], A;``` |
|  | ```       PUSH 1;``` |
|  | ```       PUSH [230];``` |
|  | ```       POP B;``` |
|  | ```       POP A;``` |
|  | ```       ADD A, B;``` |
|  | ```       PUSH A;``` |
|  | ```       PUSH [231];``` |
|  | ```       POP B;``` |
|  | ```       POP A;``` |
|  | ```       MUL B;``` |
|  | ```       PUSH A;``` |
|  | ```       POP A;``` |
|  | ```       HLT;``` |


Não há otimizações da expressão, apenas o código assembly necessária para executar cada operação como dado é gerado.

### Execução

Para compilar o programa basta usar:

`$ make`

Um arquivo executável `main` será gerado.

Para executar diversos casos de teste, basta adicionar cada um como um arquivo `.in` na pasta tests e usar:

`$ make run_tests`

A saída de cada caso será um arquivo `.out` de mesmo nome.
