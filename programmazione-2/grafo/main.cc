#include <iostream>
#include <fstream>
#include <cstring>
#include "grafo.h"

void aggiungi_arco(graph& grafo, int sorgente, int destinazione, float peso, bool connesso)
{
    if (connesso)
    {
        add_arc(grafo, sorgente, destinazione, peso);
    }
    else
    {
        add_edge(grafo, sorgente, destinazione, peso);
    }
}

bool leggi_grafo_da_file(graph& grafo, char* nome_file, bool connesso, bool pesato)
{
    std::ifstream file(nome_file);

    if (file)
    {
        int numero_nodi;

        file >> numero_nodi;

        grafo = new_graph(numero_nodi);

        int sorgente, destinazione;

        if (pesato)
        {
            float peso;

            while (file >> sorgente >> destinazione >> peso)
            {
                aggiungi_arco(grafo, sorgente, destinazione, peso, connesso);
            }
        }
        else
        {
            while (file >> sorgente >> destinazione)
            {
                aggiungi_arco(grafo, sorgente, destinazione, 0.0f, connesso);
            }
        }

        return true;
    }
    else
    {
        return false;
    }
}

int main(int argc, char** argv)
{
    if (argc < 4)
    {
        std::cerr << "Numero di argomenti non valido." << std::endl;
        std::cout << "Utilizzo: " << program_invocation_name << " INPUT_FILE CONNECTED WEIGHTED" << std::endl;

        return 1;
    }

    graph grafo;

    if (leggi_grafo_da_file(grafo, argv[1], static_cast<bool>(atoi(argv[2])), static_cast<bool>(atoi(argv[3]))))
    {
        std::cout << "Il grafo letto da file è:" << std::endl;
        stampa(grafo);

        std::cout << "Visita DFS:" << std::endl;
        stampa_dfs(grafo);

        std::cout << "Visita BFS:" << std::endl;
        stampa_bfs(grafo);

        std::cout << "Il grafo è connesso? " << connesso(grafo) << std::endl;

        int* albero = albero_cammini_minimi(grafo, 1);
        std::cout << "L'array dei padri è:" << std::endl;
        std::cout << albero[0];

        for (int i = 1; i < grafo.dim; i++)
        {
            std::cout << ", " << albero[i];
        }

        std::cout << std::endl;

        int* spanning_tree = minimum_spanning_tree_prim(grafo, 1);
        std::cout << "Il minimum spanning tree partendo dal nodo 1 è:" << std::endl;
        
        for (int i = 0; i < grafo.dim; i++)
        {
            std::cout << "Padre di " << i + 1 << ": " << spanning_tree[i] << std::endl;
        }
    }
    else
    {
        std::cerr << "Si è verificato un errore durante la lettura dal file " << argv[1] << std::endl;

        return 1;
    }
}