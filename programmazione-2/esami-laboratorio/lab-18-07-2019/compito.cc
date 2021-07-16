#include <iostream>
#include <fstream>
#include "grafi.h"
#include "node.h"
#include "coda.h"

const char* GRAFO_NOME_FILE = "graph";
const char* NODI_NOME_FILE = "node";

void leggi_riga(std::istream& stream, char* buffer, unsigned int lunghezza_massima)
{
    while (stream.peek() == '\n')
    {
        stream.get();
    }

    stream.getline(buffer, lunghezza_massima);
}

void stampa(const graph& grafo)
{
    for (int i = 1; i <= grafo.dim; i++)
    {
        std::cout << "Lista di adiacenza del nodo " << i << ": ";

        adj_node* iteratore = get_adjlist(grafo, i);

        while (iteratore != nullptr)
        {
            std::cout << get_adjnode(iteratore) << " ";
            
            iteratore = get_nextadj(iteratore);
        }

        std::cout << std::endl;
    }
}

void stampa(const graph& grafo, const node* nodi)
{
    for (int i = 1; i <= grafo.dim; i++)
    {
        node sorgente = nodi[i - 1];
        adj_node* iteratore = get_adjlist(grafo, i);

        while (iteratore != nullptr)
        {
            node destinazione = nodi[get_adjnode(iteratore) - 1];

            std::cout << sorgente.cont << " ";

            if (sorgente.tipo == TIPO_UTENTE && destinazione.tipo == TIPO_TWEET)
            {
                std::cout << "LIKE ";
            }
            else if (sorgente.tipo == TIPO_UTENTE && destinazione.tipo == TIPO_UTENTE)
            {
                std::cout << "FOLLOW ";
            }
            else
            {
                std::cout << "OWNER ";
            }

            std::cout << destinazione.cont << std::endl;

            iteratore = get_nextadj(iteratore);
        }

        std::cout << std::endl;
    }
}

int* totalLike(const graph& grafo, const node* nodi)
{
    int* numero_like_per_utente = new int[grafo.dim];

    for (int i = 0; i < grafo.dim; i++)
    {
        numero_like_per_utente[i] = 0;
    }

    for (int i = 1; i <= grafo.dim; i++)
    {
        if (nodi[i - 1].tipo == TIPO_UTENTE)
        {
            adj_node* iteratore = get_adjlist(grafo, i);

            while (iteratore != nullptr)
            {
                int id_nodo = get_adjnode(iteratore);

                if (nodi[id_nodo - 1].tipo == TIPO_TWEET)
                {
                    adj_node* owner = get_adjlist(grafo, id_nodo);
                    int id_owner = get_adjnode(owner);

                    numero_like_per_utente[id_owner - 1]++;
                }

                iteratore = get_nextadj(iteratore);
            }
        }
    }

    return numero_like_per_utente;
}

void stampa_most_influential_people(const graph& grafo, const node* nodi, const int* numero_like_per_utente)
{
    int numero_like_massimo = numero_like_per_utente[0];

    for (int i = 1; i < grafo.dim; i++)
    {
        if (numero_like_per_utente[i] > numero_like_massimo)
        {
            numero_like_massimo = numero_like_per_utente[i];
        }
    }

    for (int i = 0; i < grafo.dim; i++)
    {
        if (numero_like_per_utente[i] == numero_like_massimo)
        {
            std::cout << nodi[i].cont << std::endl;
        }
    }
}

int main()
{
    std::ifstream file_grafo(GRAFO_NOME_FILE);

    if (file_grafo)
    {
        int numero_nodi;

        file_grafo >> numero_nodi;

        graph grafo = new_graph(numero_nodi);

        int id_sorgente, id_destinazione;

        while (file_grafo >> id_sorgente >> id_destinazione)
        {
            add_arc(grafo, id_sorgente, id_destinazione, 0);
        }

        std::cout << "Grafo:" << std::endl;
        stampa(grafo);
        std::cout << std::endl;

        std::ifstream file_nodi(NODI_NOME_FILE);

        if (file_nodi)
        {
            node* nodi = new node[grafo.dim];

            for (int i = 0; i < grafo.dim; i++)
            {
                leggi_riga(file_nodi, nodi[i].cont, NODO_DIMENSIONE_CONTENUTO);
                file_nodi >> nodi[i].tipo;
            }

            std::cout << "Grafo (verbose output):" << std::endl << std::endl;
            stampa(grafo, nodi);

            int* numero_like_per_utente = totalLike(grafo, nodi);
            
            std::cout << "I most influential people sono:" << std::endl;
            stampa_most_influential_people(grafo, nodi, numero_like_per_utente);

            return 0;
        }
        else
        {
            std::cerr << "Si è verificato un errore durante la lettura del file " << NODI_NOME_FILE << std::endl;

            return 1;
        }
    }
    else
    {
        std::cerr << "Si è verificato un errore durante la lettura del file " << GRAFO_NOME_FILE << std::endl;

        return 1;
    }
}