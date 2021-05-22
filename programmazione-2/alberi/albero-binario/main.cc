#include <iostream>
#include "binary_search_tree.h"
#include "binary_tree_node.h"
#include "value_type.h"

using namespace std;

int main()
{
    BinarySearchTree bst = nullptr;
    int menu;

    do
    {
        cout << "0. Esci" << endl;
        cout << "1. Inserisci un nuovo valore nell'albero." << endl;
        cout << "2. Cerca un valore nell'albero." << endl;
        cout << "3. Rimuovi un valore dall'albero." << endl;
        cout << "4. Stampa i valori dell'albero in ordine crescente per chiave." << endl;
        cout << "5. Serializza l'albero in un JSON." << endl;
        cout << "6. Serializza l'albero in una stringa con parentesi bilanciate." << endl;
        cout << "Seleziona un'opzione: ";
        cin >> menu;

        switch (menu)
        {
            case 0:
                break;
            case 1: {
                KeyType key;
                ValueType value;

                cout << "Inserisci una chiave per il nuovo nodo: ";
                read_key(key, cin);

                cout << "Inserisci il valore del nuovo nodo: ";
                read_value(value, cin);

                BinaryTreeNode* node = new_binary_tree_node(key, value);

                insert_node(bst, node);

                cout << "Nodo inserito nell'albero." << endl;

                break;
            }
            case 2: {
                KeyType key;

                cout << "Inserisci la chiave del nodo da cercare: ";
                read_key(key, cin);

                BinaryTreeNode* node = search_node(bst, key);

                if (node != nullptr)
                {
                    cout << "Nodo trovato con valore ";
                    print_value(get_value(node), cout);
                    cout << "." << endl;
                }
                else
                {
                    cout << "Nodo non trovato." << endl;
                }

                break;
            }
            case 3: {
                KeyType key;

                cout << "Inserisci la chiave del nodo da rimuovere: ";
                read_key(key, cin);

                BinaryTreeNode* node = search_node(bst, key);

                if (node != nullptr)
                {
                    remove_node(bst, node);

                    cout << "Nodo rimosso dall'albero." << endl;
                }
                else
                {
                    cout << "Nessun nodo trovato con chiave ";
                    print_key(key, cout);
                    cout << "." << endl;
                }

                break;
            }
            case 4:
                print_bst(bst, cout);

                break;
            case 5: 
                serialize_to_json(bst, cout);

                break;
            case 6:
                serialize(bst, cout);
                cout << endl;

                break;
        }
    } while(menu != 0);
    
    return 0;
}