#include <iostream>
#include "lista.h"

void inserisci_valore(Lista& lista, int valore)
{
    Nodo* nodo = new Nodo {
        valore,
        nullptr
    };

    if (lista == nullptr || valore <= lista->valore)
    {
        // inserimento in testa
        nodo->next = lista;
        lista = nodo;
    }
    else
    {
        Nodo* it = lista; // it punta al nodo dopo il quale verrà inserito il valore

        while (it->next != nullptr && it->next->valore <= valore)
        {
            it = it->next;
        }

        nodo->next = it->next;
        it->next = nodo;
    }
}

void stampa(const Lista& lista, std::ostream& out)
{
    if (lista != nullptr)
    {
        out << lista->valore;

        for (Nodo* it = lista->next; it != nullptr; it = it->next)
        {
            out << " " << it->valore;
        }
        out << std::endl;
    }
}

void diff(const Lista& l1, const Lista& l2, std::ostream& out)
{
    if (l1 != nullptr)
    {
        if (l2 == nullptr)
        {
            out << l1->valore << " ";
        }
        else
        {
            if (l1->valore < l2->valore)
            {
                out << l1->valore << " ";

                diff(l1->next, l2, out);
            }
            else if (l1->valore == l2->valore)
            {
                diff(l1->next, l2->next, out);
            }
            else
            {
                diff(l1, l2->next, out);
            }
        }
    }
    else
    {
        out << std::endl;
    }
}