# Macros para compilacao
CC = gcc
CFLAGS = -Wextra -lfl
DIR = src
TESTS = tests
FILENAME = $(DIR)/main.c
YYTABH = $(DIR)/y.tab.h
YYTABC = $(DIR)/y.tab.c
LEXOUT = $(DIR)/lex.yy.c
YACCFILE = $(DIR)/main.y
LEXFILE = $(DIR)/main.l
TARGET = ./main
BJS = $(SRCS:.c=.o)
YACC = bison
LEX = flex


# Macros para teste
BASH = sh
TEST_SCRIPT = test.sh

# Macros para construcao do zip
ZIP = zip
USERNAME ?= $(USER)
ZIPFILE = $(USERNAME).zip
EXTENSIONS = *.in *.sh *.l *.y *.md

.PHONY: depend clean

all:$(TARGET)

$(TARGET):$(LEXOUT) $(YYTABC)
	$(CC) -o$(TARGET) $(LEXOUT) $(YYTABC) $(CFLAGS)

$(LEXOUT):$(LEXFILE) $(YYTABC)
	$(LEX) -o$(LEXOUT) $(LEXFILE)

$(YYTABC):$(YACCFILE)
	$(YACC) -o$(YYTABC) -dy $(YACCFILE)

# run_tests roda todos os arquivos .in no dir tests e salva sua saída como .out
# para executar é só copiar o .out e colar no simulador de assembly
run_tests:all
	$(BASH) $(TEST_SCRIPT) $(TARGET)

zip:clean
	$(ZIP) -R $(ZIPFILE)  Makefile $(EXTENSIONS)

clean:
	$(RM) $(YYTABC)
	$(RM) $(YYTABH)
	$(RM) $(LEXOUT)
	$(RM) ./$(TARGET)
	$(RM) ./*.o
	$(RM) $(DIR)/*.o
	$(RM) $(TESTS)/*.out
	$(RM) ./$(ZIPFILE)
