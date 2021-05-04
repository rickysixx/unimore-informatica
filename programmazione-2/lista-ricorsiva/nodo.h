#ifndef NODO_H
#define NODO_H 1

#include "tipo.h"

struct Nodo
{
    Nodo* prev = nullptr;
    tipo_t valore;
    Nodo* next = nullptr;
};

Nodo* crea_nodo(const tipo_t&);

void collega(Nodo*, Nodo*);
void scollega(Nodo*, Nodo*);
void isola(Nodo*);
void delete_nodo(Nodo*);

#endif

