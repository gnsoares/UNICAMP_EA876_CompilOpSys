#include <stdio.h>
#include <string.h>

#define TAM_BUFFER 500
#define mod(a, b) \
    ({ __typeof__ (a) _a = (a); \
        __typeof__ (b) _b = (b); \
      _a >= 0 ? _a % _b : _a % _b + _b; })

char buffer_entrada[TAM_BUFFER];
char buffer_saida[TAM_BUFFER];
const char KEY[] = "SENHASECRETA";


int main() {
    /* Leitura da entrada */
    fgets(buffer_entrada, TAM_BUFFER, stdin);

    /* Decifracao */
    for (int i = 0; buffer_entrada[i] != 0; i++)
        buffer_saida[i] = buffer_entrada[i] < 'A' || buffer_entrada[i] > 'Z' ?
            buffer_entrada[i] :
            'A' + mod(buffer_entrada[i] - KEY[i % strlen(KEY)], 26);

    /* Escrever saida na tela */
    printf("%s", buffer_saida);

    return 0;
}
