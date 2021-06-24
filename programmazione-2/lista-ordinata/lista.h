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

// Stampa su out tutti gli elementi che sono presenti in l1 ma non in l2.
void diff(const Lista& l1, const Lista& l2, std::ostream& out);
#endif