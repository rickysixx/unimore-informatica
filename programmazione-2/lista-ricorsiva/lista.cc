#include "lista.h"
#include "nodo.h"
#include "tipo.h"
#include <iostream>

static Nodo* cerca_nodo_in_coda(const Lista& lista)
{
    if (lista_vuota(lista))
    {
        return nullptr;
    }
    else if (lista->next == nullptr)
    {
        return lista;
    }
    else
    {
        return cerca_nodo_in_coda(lista->next);
    }
}

static Nodo* cerca_nodo_in_posizione(const Lista& lista, unsigned int posizione)
{
    if (lista_vuota(lista))
    {
        return nullptr;
    }
    else if (posizione == 0)
    {
        return lista;
    }
    else
    {
        return cerca_nodo_in_posizione(lista->next, posizione - 1);
    }
}

static Nodo* cerca_nodo_per_valore(const Lista& lista, const tipo_t& valore)
{
    if (lista_vuota(lista))
    {
        return nullptr;
    }
    else if (compare(lista->valore, valore) == 0)
    {
        return lista;
    }
    else
    {
        return cerca_nodo_per_valore(lista->next, valore);
    }
}

bool lista_vuota(const Lista& lista)
{
    return lista == nullptr;
}

void inserisci_in_testa(Lista& lista, const tipo_t& valore)
{
    Nodo* nodo = crea_nodo(valore);

    collega(nodo, lista);

    lista = nodo;
}

bool inserisci_in_posizione(Lista& lista, const tipo_t& valore, unsigned int posizione)
{
    if (posizione == 0)
    {
        inserisci_in_testa(lista, valore);

        return true;
    }
    else
    {
        Nodo* precedente = cerca_nodo_in_posizione(lista, posizione - 1);

        if (precedente != nullptr)
        {
            Nodo* successivo = precedente->next;
            Nodo* nuovo_nodo = crea_nodo(valore);

            collega(precedente, nuovo_nodo);
            collega(nuovo_nodo, successivo);

            return true;
        }
        else
        {
            return false;
        }
    }
}

void inserisci_in_coda(Lista& lista, const tipo_t& valore)
{
    Nodo* nodo = crea_nodo(valore);
    Nodo* coda = cerca_nodo_in_coda(lista);

    collega(coda, nodo);
}

void rimuovi_dalla_testa(Lista& lista)
{
    if (!lista_vuota(lista))
    {
        Nodo* nuova_testa = lista->next;

        scollega(lista, nuova_testa);

        delete lista;

        lista = nuova_testa;
    }
}

void rimuovi_dalla_coda(Lista& lista)
{
    if (!lista_vuota(lista))
    {
        Nodo* coda = cerca_nodo_in_coda(lista);

        if (coda == lista)
        {
            // la lista ha un solo elemento, cioè la testa, quindi anche il suo puntatore dev'essere aggiornato
            lista = nullptr;
        }
        else
        {
            coda->prev->next = nullptr;
        }

        delete coda;
    }
}

void rimuovi_da_posizione(Lista& lista, unsigned int posizione)
{
    if (posizione == 0)
    {
        rimuovi_dalla_testa(lista);
    }
    else
    {
        Nodo* nodo_da_eliminare = cerca_nodo_in_posizione(lista, posizione);

        if (nodo_da_eliminare != nullptr)
        {
            collega(nodo_da_eliminare->prev, nodo_da_eliminare->next);

            delete nodo_da_eliminare;
        }
    }
}

void stampa_lista(const Lista& lista, std::ostream& out)
{
    stampa_lista(lista, out, Direzione::LTR);
}

void stampa_lista(const Lista& lista, std::ostream& out, const Direzione& direzione)
{
    if (lista_vuota(lista))
    {
        out << "La lista è vuota." << std::endl;
    }
    else
    {
        if (direzione == LTR)
        {
            stampa(lista->valore, out);

            for (Nodo* i = lista->next; i != nullptr; i = i->next)
            {
                out << " ";

                stampa(i->valore, out);
            }
        }
        else
        {
            Nodo* coda = cerca_nodo_in_coda(lista);

            stampa(coda->valore, out);

            for (Nodo* i = coda->prev; i != nullptr; i = i->prev)
            {
                out << " ";

                stampa(i->valore, out);
            }
        }

        out << std::endl;
    }
}

bool contiene(const Lista& lista, const tipo_t& valore)
{
    return cerca_nodo_per_valore(lista, valore) != nullptr;
}

unsigned int numero_elementi(const Lista& lista)
{
    if (lista_vuota(lista))
    {
        return 0;
    }
    else
    {
        return 1 + numero_elementi(lista->next);
    }
}

void svuota_lista(Lista& lista)
{
    if (!lista_vuota(lista))
    {
        Nodo* next = lista->next;

        delete_nodo(lista);

        svuota_lista(next);
    }
}

void copia(Lista& target, const Lista& source)
{
    for (Nodo* i = cerca_nodo_in_coda(source); i != nullptr; i = i->prev)
    {
        inserisci_in_testa(target, i->valore);
    }
}

const tipo_t* cerca_elemento_in_posizione(const Lista& lista, unsigned int posizione)
{
    Nodo* nodo = cerca_nodo_in_posizione(lista, posizione);

    if (nodo != nullptr)
    {
        return &(nodo->valore);
    }
    else
    {
        return nullptr;
    }
}

bool modifica_elemento_in_posizione(Lista& lista, unsigned int posizione, const tipo_t& nuovo_valore)
{
    Nodo* nodo = cerca_nodo_in_posizione(lista, posizione);

    if (nodo != nullptr)
    {
        copia(nodo->valore, nuovo_valore);

        return true;
    }
    else
    {
        return false;
    }
}