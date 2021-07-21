#include <iostream>
#include <cfloat>
#include "grafo.h"
#include "coda-bfs.h"
#include "codap.h"
#include "debug.h"

graph new_graph(int n)
{
    graph g;
    g.dim = n;
    g.nodes = new adj_list[g.dim];

    return g;
}

void add_arc(graph& g, int s, int d, float w)
{
    adj_node* node = new adj_node {
        d,
        w,
        nullptr
    };

    node->next = g.nodes[s - 1];
    g.nodes[s - 1] = node;
}

void add_edge(graph& g, int s, int d, float w)
{
    add_arc(g, s, d, w);
    add_arc(g, d, s, w);
}

int get_dim(graph g)
{
    return g.dim;
}

adj_list get_adjlist(graph g, int id_nodo)
{
    return g.nodes[id_nodo - 1];
}

adj_list get_nextadj(adj_list lista)
{
    return lista->next;
}

void stampa(const graph& grafo)
{
    for (int i = 0; i < grafo.dim; i++)
    {
        std::cout << "Archi uscenti nodo " << (i + 1) << ": ";
        
        for (adj_node* it = get_adjlist(grafo, i + 1); it != nullptr; it = get_nextadj(it))
        {
            std::cout << it->node << " (peso: " << it->weight << ")";

            if (get_nextadj(it) != nullptr)
            {
                std::cout << ", ";
            }
        }

        std::cout << std::endl;
    }
}

static void stampa_dfs(const graph& grafo, int id_nodo, bool* visited)
{
    std::cout << id_nodo << std::endl;
    visited[id_nodo - 1] = true;

    for (adj_node* it = get_adjlist(grafo, id_nodo); it != nullptr; it = get_nextadj(it))
    {
        if (!visited[it->node - 1])
        {
            stampa_dfs(grafo, it->node, visited);
        }
    }
}

void stampa_dfs(const graph& grafo)
{
    bool* visited = new bool[grafo.dim];

    for (int i = 0; i < grafo.dim; i++)
    {
        visited[i] = false;
    }

    for (int i = 0; i < grafo.dim; i++)
    {
        if (!visited[i])
        {
            stampa_dfs(grafo, i + 1, visited);
        }
    }

    delete[] visited;
}

void stampa_bfs(const graph& grafo)
{
    bool* visited = new bool[grafo.dim];

    for (int i = 0; i < grafo.dim; i++)
    {
        visited[i] = false;
    }

    codaBFS coda = newQueue();
    coda = enqueue(coda, 1);
    visited[0] = true;

    while (!isEmpty(coda))
    {
        int id_nodo = dequeue(coda);

        std::cout << id_nodo << std::endl;

        for (adj_node* it = get_adjlist(grafo, id_nodo); it != nullptr; it = get_nextadj(it))
        {
            if (!visited[it->node - 1])
            {
                coda = enqueue(coda, it->node);
                visited[it->node - 1] = true;
            }
        }
    }

    delete[] visited;
}

bool connesso(const graph& grafo)
{
    bool* visited = new bool[grafo.dim];
    codaBFS coda = newQueue();
    bool connesso = true;

    for (int i = 0; i < grafo.dim; i++)
    {
        visited[i] = false;
    }

    coda = enqueue(coda, 1);
    visited[0] = true;

    while (!isEmpty(coda))
    {
        int id_nodo = dequeue(coda);

        for (adj_node* it = get_adjlist(grafo, id_nodo); it != nullptr; it = get_nextadj(it))
        {
            if (!visited[it->node - 1])
            {
                coda = enqueue(coda, it->node);
                visited[it->node - 1] = true;
            }
        }
    }

    for (int i = 0; i < grafo.dim && connesso; i++)
    {
        connesso = visited[i];
    }

    return connesso;
}

int* albero_cammini_minimi(const graph& grafo, int sorgente)
{
    int* padri = new int[grafo.dim];
    float* dist = new float[grafo.dim];
    codap coda = nullptr;

    for (int i = 0; i < grafo.dim; i++)
    {
        padri[i] = 0;
        dist[i] = FLT_MAX;
        coda = enqueue(coda, i + 1, dist[i]);
    }

    dist[sorgente - 1] = 0;
    coda = Decrease_Priority(coda, sorgente, 0);

    while (!isEmpty(coda))
    {
        int id_nodo = dequeue(coda);
        
        for (adj_node* it = get_adjlist(grafo, id_nodo); it != nullptr; it = get_nextadj(it))
        {
            if (dist[id_nodo - 1] + it->weight < dist[it->node - 1])
            {
                dist[it->node - 1] = dist[id_nodo - 1] + it->weight;
                padri[it->node - 1] = id_nodo;
                coda = Decrease_Priority(coda, it->node, dist[it->node - 1]);
            }
        }
    }

    delete[] dist;

    return padri;
}

int* minimum_spanning_tree_prim(const graph& grafo, int sorgente)
{
    int* padri = new int[grafo.dim];
    float* costo = new float[grafo.dim];
    bool* s = new bool[grafo.dim];
    codap coda = nullptr;

    for (int i = 0; i < grafo.dim; i++)
    {
        padri[i] = 0;
        costo[i] = FLT_MAX;
        s[i] = false;
        coda = enqueue(coda, i + 1, costo[i]);
    }

    costo[sorgente - 1] = 0;
    s[sorgente - 1] = true;
    coda = Decrease_Priority(coda, sorgente, 0);

    while (!isEmpty(coda))
    {
        int id_nodo = dequeue(coda);
        s[id_nodo - 1] = true;

        for (adj_node* it = get_adjlist(grafo, id_nodo); it != nullptr; it = get_nextadj(it))
        {
            #ifdef DEBUG
            std::cout << "[DEBUG] Sto esplorando l'arco " << id_nodo << " -> " << it->node << std::endl;

            if (s[it->node - 1])
            {
                std::cout << "[DEBUG] Il nodo " << it->node << " fa già parte dell'albero di copertura. Passo al prossimo arco." << std::endl;
            }
            else
            {
                std::cout << "[DEBUG] Il nodo " << it->node << " non fa parte dell'albero di copertura." << std::endl;
                std::cout << "[DEBUG] costo[" << it->node << "] = " << costo[it->node - 1] << std::endl;
                std::cout << "[DEBUG] Peso dell'arco: " << it->weight << std::endl;
            }
            #endif

            if (!s[it->node - 1] && costo[it->node - 1] > it->weight)
            {
                costo[it->node - 1] = it->weight;
                padri[it->node - 1] = id_nodo;
                coda = Decrease_Priority(coda, it->node, costo[it->node - 1]);

                #ifdef DEBUG
                std::cout << "[DEBUG] Arco aggiunto all'albero di copertura." << std::endl;
                #endif
            }

            #ifdef DEBUG
            std::cout << "--------------------" << std::endl;
            #endif
        }
    }

    delete[] costo;
    delete[] s;

    return padri;
}