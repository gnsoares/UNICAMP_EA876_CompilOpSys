/* Data de submissao:
 * Nome: Gustavo Nascimento Soares
 * RA: 217530
 */

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>
const int tam_buffer=100;

void inverted_print(char * s, int n, char end) {
    int i;
    for (i = n - 1; i >= 0; i--)
        printf("%c", s[i]);
    printf("%c", end);
}

int main() {

    char buffer[tam_buffer];
    char ** split;
    int i, j, k;

    // Leitura entrada
    fgets(buffer, tam_buffer, stdin);

    // Alocação memória
    assert(split = malloc(tam_buffer * sizeof(char *)));
    for (i = 0; i < tam_buffer; i++)
  	   assert(split[i] = malloc(tam_buffer * sizeof(char)));

    // Divisão das palavras
    for (i = k = 0; k < (int) strlen(buffer); k++) {
        for (j = 0; buffer[k] != ' ' && buffer[k] != '\n';)
            split[i][j++] = buffer[k++];
        split[i++][j] = '\0';
    }

    // Impressão invertida de cada palavra
    for (j = 0; j < i - 1; j++)
        inverted_print(split[j], strlen(split[j]), ' ');
    inverted_print(split[i - 1], strlen(split[i - 1]), '\n');

    // Liberação de memória
    for (i = 0; i < tam_buffer; i++)
        free(split[i]);
    free(split);

    return 0;
}
