#include <iostream>
#include "tipo.h"
#include "liste.h"

void pesca(lista& lista)
{
    carta carta;

    std::cout << "Inserisci il numero della carta pescata: ";
    std::cin >> carta.valore;

    std::cout << "Inserisci il seme della carta (C, F, Q, P): ";
    std::cin >> carta.seme;

    lista = ord_insert_elem(lista, new_elem(carta));

    std::cout << "Carta aggiunta alla lista." << std::endl;
}

void stampa(lista lista)
{
    if (lista != nullptr)
    {
        print(head(lista));

        std::cout << " ";

        stampa(tail(lista));
    }
    else
    {
        std::cout << std::endl;
    }
}

int main()
{
    lista giocatore_1 = nullptr;
    lista giocatore_2 = nullptr;
    unsigned int nr_carte;

    std::cout << "Inserisci il numero di carte da pescare: ";
    std::cin >> nr_carte;

    for (unsigned int i = 0; i < nr_carte; i++)
    {
        std::cout << "Carta " << (i + 1) << " giocatore 1:" << std::endl;
        pesca(giocatore_1);

        std::cout << "Carta " << (i + 1) << " giocatore 2:" << std::endl;
        pesca(giocatore_2);
    }

    std::cout << "giocatore 1: ";
    stampa(giocatore_1);

    std::cout << "giocatore 2: ";
    stampa(giocatore_2);

    return 0;
}