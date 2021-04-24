#include "lista.h"
#include "nodo.h"
#include "tipo.h"
#include <iostream>

static Nodo* cerca_nodo_in_coda(const Lista& lista)
{
    Nodo* i = lista.testa;

    while (i != nullptr && i->next != nullptr)
    {
        i = i->next;
    }

    return i;
}

static Nodo* cerca_nodo_in_posizione(const Lista& lista, unsigned int posizione)
{
    unsigned int i = 0;
    Nodo* j = lista.testa;

    while (j != nullptr && i < posizione)
    {
        ++i;
        j = j->next;
    }

    return j;
}

bool lista_vuota(const Lista& lista)
{
    return lista.testa == nullptr;
}

void inserisci_in_testa(Lista& lista, const tipo_t& valore)
{
    Nodo* nodo = crea_nodo(valore);

    collega(nodo, lista.testa);

    lista.testa = nodo;
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
        Nodo* nuova_testa = lista.testa->next;

        scollega(lista.testa, nuova_testa);

        delete lista.testa;

        lista.testa = nuova_testa;
    }
}

void rimuovi_dalla_coda(Lista& lista)
{
    if (!lista_vuota(lista))
    {
        Nodo* coda = cerca_nodo_in_coda(lista);

        if (coda == lista.testa)
        {
            // la lista ha un solo elemento, cioè la testa, quindi anche il suo puntatore dev'essere aggiornato
            lista.testa = nullptr;
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
            stampa(lista.testa->valore, out);

            for (Nodo* i = lista.testa->next; i != nullptr; i = i->next)
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
    bool trovato = false;

    for (Nodo* i = lista.testa; i != nullptr && !trovato; i = i->next)
    {
        trovato = compare(i->valore, valore) == 0;
    }

    return trovato;
}

unsigned int numero_elementi(const Lista& lista)
{
    unsigned int numero_elementi = 0;

    for (Nodo* i = lista.testa; i != nullptr; i = i->next)
    {
        ++numero_elementi;
    }

    return numero_elementi;
}

void svuota_lista(Lista& lista)
{
    Nodo* i = lista.testa;

    while (i != nullptr)
    {
        Nodo* prossimo = i->next;

        delete_nodo(i);

        i = prossimo;
    }
}

void copia(Lista& target, const Lista& source)
{
    for (Nodo* i = cerca_nodo_in_coda(source); i != nullptr; i = i->prev)
    {
        inserisci_in_testa(target, i->valore);
    }
}