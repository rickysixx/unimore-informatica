CC=g++
CFLAGS=-Wall -error -pedantic-errors -c

main: main.o tipo.o nodo.o lista.o
	$(CC) -o main.out main.o tipo.o nodo.o lista.o

main.o: main.cc tipo.h lista.h
	$(CC) $(CFLAGS) main.cc

lista.o: lista.cc tipo.h nodo.h
	$(CC) $(CFLAGS) lista.cc

nodo.o: nodo.cc tipo.h
	$(CC) $(CFLAGS) nodo.cc

tipo.o: tipo.cc
	$(CC) $(CFLAGS) tipo.cc