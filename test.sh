# Script para testes de unidade automaticos

# A primeira linha indica que o script foi inicializado corretamente
echo "Testando $1"

# A variavel dirtestes indica onde os arquivos teste .in estao
dirtestes=./tests

# Essas variaveis de contagem devem ser inicializadas com zero
ntestes=0
program=$1

# Expressao do SED que significa: substituir .in por .out
sedexpression='s/\.in/\.out/'

# tests sera inicializada com o resultado da expressao find,
# encontrando todos os arquivos .in do diretorio dirtestes
tests=`find $dirtestes -name '*.in'`

# Para cada teste...
for t in $tests
do
  # Adiciona 1 no contador de testes
  ntestes=`echo $ntestes + 1 | bc`

  # Encontra o nome do arquivo relacionado a saida do teste
  o=`echo $t | sed $sedexpression`

  # Executa o programa que foi compilado usando o arquivo de teste.in como
  # entrada e salva em teste.out
  $program < $t > ./$o
done

echo "Total de testes: $ntestes"
