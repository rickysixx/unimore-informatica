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

carta* scala(lista carte, int& lunghezza)
{
    carta* prima_carta_scala = nullptr;
    lunghezza = 0;
    elem* prima_carta_scala_corrente = carte;
    int lunghezza_scala_corrente = 1;

    for (elem* it = tail(carte); it != nullptr; it = tail(it))
    {
        if (prima_carta_scala_corrente->inf.seme == head(it).seme && head(it).valore == prev(it)->inf.valore + 1)
        { 
            ++lunghezza_scala_corrente;
        }
        else
        {
            if (lunghezza_scala_corrente >= 3 && lunghezza_scala_corrente > lunghezza)
            {
                prima_carta_scala = &prima_carta_scala_corrente->inf;
                lunghezza = lunghezza_scala_corrente;
            }

            prima_carta_scala_corrente = it;
            lunghezza_scala_corrente = 1;
        }

        if (lunghezza_scala_corrente >= 3 && lunghezza_scala_corrente > lunghezza)
        {
            prima_carta_scala = &prima_carta_scala_corrente->inf;
            lunghezza = lunghezza_scala_corrente;
        }
    }

    return prima_carta_scala;
}

void stampa_scala(const lista& lista, const carta* prima_carta_scala, const int lunghezza_scala)
{
    elem* it = search(lista, *prima_carta_scala);

    for (int i = 0; i < lunghezza_scala; i++)
    {
        print(head(it));
        std::cout << " ";

        it = tail(it);
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

    int lunghezza_scala_giocatore_1;
    int lunghezza_scala_giocatore_2;
    carta* scala_giocatore_1 = scala(giocatore_1, lunghezza_scala_giocatore_1);
    carta* scala_giocatore_2 = scala(giocatore_2, lunghezza_scala_giocatore_2);

    std::cout << "Scale:" << std::endl;

    std::cout << "giocatore 1: ";
    stampa_scala(giocatore_1, scala_giocatore_1, lunghezza_scala_giocatore_1);
    std::cout << std::endl;

    std::cout << "giocatore 2: ";
    stampa_scala(giocatore_2, scala_giocatore_2, lunghezza_scala_giocatore_2);
    std::cout << std::endl;

    return 0;
}