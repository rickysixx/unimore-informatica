#include "tipo.h"
#include "nodo.h"

Nodo* crea_nodo(const tipo_t& valore)
{
    return new Nodo {
        nullptr,
        valore,
        nullptr
    };
}

void collega(Nodo* a, Nodo* b)
{
    if (a != nullptr)
    {
        a->next = b;
    }

    if (b != nullptr)
    {
        b->prev = a;
    }
}

void scollega(Nodo* a, Nodo* b)
{
    if (a != nullptr)
    {
        a->next = nullptr;
    }

    if (b != nullptr)
    {
        b->prev = nullptr;
    }
}

void isola(Nodo* nodo)
{
    if (nodo != nullptr)
    {
        nodo->prev = nullptr;
        nodo->next = nullptr;
    }
}

void delete_nodo(Nodo* nodo)
{
    if (nodo->prev != nullptr)
    {
        nodo->prev->next = nodo->next;
    }

    if (nodo->next != nullptr)
    {
        nodo->next->prev = nodo->prev;
    }

    delete nodo;
}

