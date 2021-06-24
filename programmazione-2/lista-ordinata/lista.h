#ifndef LISTA_H
#define LISTA_H
#include <iostream>

struct Nodo
{
    int valore;
    Nodo* next = nullptr;
};

typedef Nodo* Lista;

void inserisci_valore(Lista& lista, int valore);

void stampa(const Lista& lista, std::ostream& out);
#endif