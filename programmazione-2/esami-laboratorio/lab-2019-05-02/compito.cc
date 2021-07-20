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

carta* best_scala(lista carte, int& lunghezza_scala_migliore)
{
    int punteggio_scala_migliore = 0;
    int punteggio_scala_corrente = 0;
    carta* prima_carta_scala_migliore = nullptr;
    elem* prima_carta_scala_corrente = carte;
    int lunghezza_scala_corrente = 1;
    lunghezza_scala_migliore = 0;
    
    for (elem* it = tail(carte); it != nullptr; it = tail(it))
    {
        carta carta_corrente = head(it);

        if (carta_corrente.seme == head(prima_carta_scala_corrente).seme && carta_corrente.valore == head(prev(it)).valore + 1)
        {
            punteggio_scala_corrente += carta_corrente.valore;
            lunghezza_scala_corrente++;

            if (tail(it) == nullptr && lunghezza_scala_corrente >= 3 && punteggio_scala_corrente > punteggio_scala_migliore)
            {
                punteggio_scala_migliore = punteggio_scala_corrente;
                prima_carta_scala_migliore = &prima_carta_scala_corrente->inf;
                lunghezza_scala_migliore = lunghezza_scala_corrente;
            }
        }
        else
        {
            if (lunghezza_scala_corrente >= 3 && punteggio_scala_corrente > punteggio_scala_migliore)
            {
                punteggio_scala_migliore = punteggio_scala_corrente;
                prima_carta_scala_migliore = &prima_carta_scala_corrente->inf;
                lunghezza_scala_migliore = lunghezza_scala_corrente;
            }

            punteggio_scala_corrente = 0;
            prima_carta_scala_corrente = it;
            lunghezza_scala_corrente = 1;
        }
    }
    
    return prima_carta_scala_migliore;
}

int cala(lista& carte)
{
    int numero_carte_scala;
    elem* it = search(carte, *best_scala(carte, numero_carte_scala));
    int punteggio = 0;

    std::cout << "Carte calate: ";

    for (int i = 0; i < numero_carte_scala; i++)
    {
        elem* next = tail(it);
        carta carta = head(it);

        print(carta);
        std::cout << " ";

        punteggio += carta.valore;
        
        carte = delete_elem(carte, it);
        it = next;
    }

    std::cout << std::endl;

    return punteggio;
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
    carta* scala_giocatore_1 = best_scala(giocatore_1, lunghezza_scala_giocatore_1);
    carta* scala_giocatore_2 = best_scala(giocatore_2, lunghezza_scala_giocatore_2);

    std::cout << "Scale migliori:" << std::endl;

    std::cout << "giocatore 1: ";
    stampa_scala(giocatore_1, scala_giocatore_1, lunghezza_scala_giocatore_1);
    std::cout << std::endl;

    std::cout << "giocatore 2: ";
    stampa_scala(giocatore_2, scala_giocatore_2, lunghezza_scala_giocatore_2);
    std::cout << std::endl;

    const unsigned int nr_turni_gioco = 2;
    int vincitore = -1;
    int punteggio_giocatore_1 = 0;
    int punteggio_giocatore_2 = 0;

    for (unsigned int i = 1; i <= nr_turni_gioco && vincitore == -1; i++)
    {
        std::cout << "=== TURNO " << i << " ===" << std::endl;

        std::cout << "giocatore 1, pesca una carta:" << std::endl;
        pesca(giocatore_1);

        std::cout << "giocatore 1 cala le carte:" << std::endl;
        punteggio_giocatore_1 += cala(giocatore_1);
        std::cout << "Punteggio totale giocatore 1: " << punteggio_giocatore_1 << std::endl;

        if (giocatore_1 == nullptr)
        {
            vincitore = 1;
        }
        else
        {
            std::cout << "giocatore 1, carte in mano: ";
            stampa(giocatore_1);

            std::cout << "giocatore 2, pesca una carta:" << std::endl;
            pesca(giocatore_2);

            std::cout << "giocatore 2 cala le carte:" << std::endl;
            punteggio_giocatore_2 += cala(giocatore_2);
            std::cout << "Punteggio totale giocatore 2: " << punteggio_giocatore_2 << std::endl;

            if (giocatore_2 == nullptr)
            {
                vincitore = 2;
            }
            else
            {
                std::cout << "giocatore 2, carte in mano: ";
                stampa(giocatore_2);
            }
        }
    }

    if (vincitore == -1)
    {
        vincitore = (punteggio_giocatore_1 > punteggio_giocatore_2) ? 1 : 2;
    }

    if (vincitore == 1)
    {
        std::cout << "Fine gioco!! Vince il giocatore 1 con " << punteggio_giocatore_1 << " punti." << std::endl;
    }
    else
    {
        std::cout << "Fine gioco!! Vince il giocatore 2 con " << punteggio_giocatore_2 << " punti." << std::endl;
    }

    return 0;
}