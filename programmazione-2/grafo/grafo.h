#ifndef GRAFO_H
#define GRAFO_H
struct adj_node
{
    int node;
    float weight;
    adj_node* next;
};

typedef adj_node* adj_list;

struct graph
{
    adj_list* nodes;
    int dim;
};

graph new_graph(int n);

void add_arc(graph& g, int s, int d, float w);
void add_edge(graph& g, int s, int d, float w);

int get_dim(graph);

adj_list get_adjlist(graph, int);
adj_list get_nextadj(adj_list);

void stampa(const graph& grafo);
void stampa_dfs(const graph& grafo);
void stampa_bfs(const graph& grafo);

bool connesso(const graph& grafo);

/**
 * @brief Ritorna l'albero dei cammini minimi calcolato utilizzando l'algoritmo di Dijkstra.
 * 
 * @param grafo grafo su cui calcolare l'albero dei cammini minimi
 * @param sorgente identificativo del nodo da cui parte l'esplorazione del grafo. Questo nodo sarà la radice dell'albero restituito.
 * @return int* array di interi, da intendersi come vettore dei padri, che rappresenta l'albero di copertura.
 */
int* albero_cammini_minimi(const graph& grafo, int sorgente);

/**
 * @brief Ritorna il minimum spanning tree calcolato utilizzando l'algoritmo di Prim.
 * 
 * @param grafo grafo su cui calcolare il minimum spanning tree
 * @param sorgente il nodo del grafo che sarà la radice dell'albero restituito
 * @return int* un array di interi, da intendersi come vettore dei padri, che rappresenta l'albero di copertura
 */
int* minimum_spanning_tree_prim(const graph& grafo, int sorgente);


#endif