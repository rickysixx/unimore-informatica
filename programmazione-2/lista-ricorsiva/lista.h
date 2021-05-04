#ifndef LISTA_H
#define LISTA_H 1

#include "tipo.h"
#include "nodo.h"
#include <iostream>

typedef Nodo* Lista;

enum Direzione
{
    LTR,
    RTL
};

bool lista_vuota(const Lista&);

void inserisci_in_testa(Lista&, const tipo_t&);
void inserisci_in_coda(Lista&, const tipo_t&);

/**
 * Inserisce un nuovo valore in una determinata posizione.
 * Restituisce false se la posizione sfora gli estremi della lista.
 * La posizione data sarà la posizione dell'elemento una volta inserito nella lista.
 */ 
bool inserisci_in_posizione(Lista&, const tipo_t&, unsigned int);

void rimuovi_dalla_testa(Lista&);
void rimuovi_dalla_coda(Lista&);
void rimuovi_da_posizione(Lista&, unsigned int);

bool contiene(const Lista&, const tipo_t&);

void stampa_lista(const Lista&, std::ostream&);
void stampa_lista(const Lista&, std::ostream&, const Direzione&);

unsigned int numero_elementi(const Lista&);

void svuota_lista(Lista& lista);

void copia(Lista&, const Lista&);

const tipo_t* cerca_elemento_in_posizione(const Lista&, unsigned int);

bool modifica_elemento_in_posizione(Lista&, unsigned int, const tipo_t&);

Lista& unisci(const Lista&, const Lista&);

#endif