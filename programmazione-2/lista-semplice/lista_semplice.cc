#include <iostream>

using namespace std;

struct Nodo
{
    int valore;
    Nodo* next;
};

int head(const Nodo* nodo)
{
    return nodo->valore;
}

Nodo* tail(const Nodo* nodo)
{
    return nodo->next;
}

Nodo* crea_nodo(int valore)
{
    return new Nodo {
        valore,
        nullptr
    };
}

bool lista_vuota(const Nodo* testa)
{
    return testa == nullptr;
}

Nodo* inserisci_in_testa(Nodo* testa, Nodo* nodo)
{
    nodo->next = testa;

    return nodo;
}

Nodo* inserisci_in_coda(Nodo* testa, Nodo* nodo)
{
    if (lista_vuota(testa))
    {
        return inserisci_in_testa(testa, nodo);
    }
    else
    {
        Nodo* i = testa;

        while (tail(i) != nullptr)
        {
            i = tail(i);
        }

        i->next = nodo;
    }

    return testa;
}

void stampa_lista(const Nodo* testa)
{
    if (lista_vuota(testa))
    {
        cout << "La lista è vuota." << endl;
    }
    else
    {
        cout << head(testa);

        for (Nodo* i = tail(testa); i != nullptr; i = tail(i))
        {
            cout << " " << head(i);
        }

        cout << endl;
    }
}

void delete_nodo(Nodo*& nodo)
{
    delete nodo;

    nodo = nullptr;
}

/**
 * Confronta il valore di 2 nodi. Restituisce:
 * * un numero positivo se a > b;
 * * 0 se a = b;
 * * un numero negativo se a < b
 */
int confronta_nodi(const Nodo* a, const Nodo* b)
{
    return head(a) - head(b);
}

Nodo* rimuovi_nodo(Nodo*& testa, Nodo* nodo)
{
    Nodo* i = nullptr;
    Nodo* j = testa;

    while (j != nullptr && confronta_nodi(j, nodo) != 0)
    {
        i = j;
        j = tail(j);
    }

    if (j != nullptr)
    {
        if (i == nullptr)
        {
            testa = tail(testa);
        }
        else
        {
            i->next = tail(j);
        }

        delete_nodo(j);
    }

    return testa;
}

int cerca_posizione(Nodo* testa, const Nodo* nodo)
{
    int posizione = 0;
    Nodo* i = testa;

    while (i != nullptr && confronta_nodi(i, nodo) != 0)
    {
        i = i->next;
        ++posizione;
    }

    return (i != nullptr) ? posizione : -1;
}

bool contiene_nodo(Nodo* testa, const Nodo* nodo)
{
    return cerca_posizione(testa, nodo) != -1;
}

int numero_elementi(Nodo* testa)
{
    int numero_elementi = 0;

    for (Nodo* i = testa; i != nullptr; i = i->next)
    {
        ++numero_elementi;
    }

    return numero_elementi;
}

Nodo* elimina_lista(Nodo*& testa)
{
    while (testa != nullptr)
    {
        testa = rimuovi_nodo(testa, testa);
    }

    return testa;
}

int main()
{
    Nodo* testa = nullptr;
    int scelta;

    do
    {
        cout << "0. Esci dal programma." << endl;
        cout << "1. Inserisci un elemento in testa." << endl;
        cout << "2. Inserisci un elemento in coda." << endl;
        cout << "3. Rimuovi un elemento dalla lista." << endl;
        cout << "4. Stampa la lista." << endl;
        cout << "5. Verifica se un elemento è contenuto nella lista." << endl;
        cout << "6. Conta il numero di elementi nella lista." << endl;
        cout << "7. Elimina la lista." << endl;
        cout << "Seleziona un'opzione: ";
        cin >> scelta;

        switch (scelta)
        {
            case 0:
                cout << "Arrivederci." << endl;
                break;
            case 1: {
                int valore;

                cout << "Inserisci il valore dell'elemento da aggiungere alla lista: ";
                cin >> valore;

                Nodo* nodo = crea_nodo(valore);

                testa = inserisci_in_testa(testa, nodo);

                cout << "Elemento inserito." << endl;

                break;
            } 
            case 2: {
                int valore;

                cout << "Inserisci l'elemento da aggiungere nella lista: ";
                cin >> valore;

                Nodo* nodo = crea_nodo(valore);

                testa = inserisci_in_coda(testa, nodo);

                cout << "Elemento inserito." << endl;

                break;
            }
            case 3: {
                int valore;

                cout << "Inserisci l'elemento da rimuovere dalla lista: ";
                cin >> valore;

                Nodo* nodo = crea_nodo(valore);

                testa = rimuovi_nodo(testa, nodo);

                cout << "Elemento rimosso dalla lista." << endl;

                break;
            }
            case 4: 
                stampa_lista(testa);
                break;
            case 5: {
                int valore;

                cout << "Inserisci il valore dell'elemento da cercare: ";
                cin >> valore;

                Nodo* nodo = crea_nodo(valore);
                int posizione = cerca_posizione(testa, nodo);

                if (posizione != -1)
                {
                    cout << "L'elemento è presente nella lista (posizione " << posizione << ")." << endl;
                }
                else
                {
                    cout << "L'elemento non è presente nella lista." << endl;
                }

                break;
            }
            case 6: 
                cout << "La lista contiene " << numero_elementi(testa) << " elementi." << endl;
                break;
            case 7:
                testa = elimina_lista(testa);

                cout << "Lista eliminata." << endl;

                break;
            
        }
    } while (scelta != 0);
    
    return 0;
}