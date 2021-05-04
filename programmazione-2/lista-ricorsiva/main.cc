#include <iostream>

#include "tipo.h"
#include "lista.h"

using namespace std;

int main()
{
    Lista lista = nullptr;
    
    int scelta;

    do
    {
        cout << "0. Esci dal programma." << endl;
        cout << "1. Inserisci un valore all'inizio della lista." << endl;
        cout << "2. Inserisci un valore in fondo alla lista." << endl;
        cout << "3. Inserisci un valore in una determinata posizione." << endl;
        cout << "4. Rimuovi il primo valore della lista." << endl;
        cout << "5. Rimuovi l'ultimo valore della lista." << endl;
        cout << "6. Rimuovi un valore da una posizione data." << endl;
        cout << "7. Verifica se la lista contiene un determinato valore." << endl;
        cout << "8. Stampa la lista (da sinistra verso destra)." << endl;
        cout << "9. Stampa la lista (da destra verso sinistra)." << endl;
        cout << "10. Conta il numero di elementi della lista." << endl;
        cout << "Seleziona un'opzione: ";
        cin >> scelta;

        switch (scelta)
        {
            case 0:
                break;
            case 1:
            case 2: {
                tipo_t valore;
                void (*insert_function)(Lista&, const tipo_t&) = (scelta == 1) ? inserisci_in_testa : inserisci_in_coda;

                cout << "Valore da inserire nella lista: ";
                leggi(valore, cin);

                insert_function(lista, valore);

                cout << "Valore inserito nella lista." << endl;

                break;
            }
            case 3: {
                tipo_t valore;
                unsigned int posizione;

                cout << "Valore da inserire nella lista: ";
                leggi(valore, cin);

                cout << "Posizione in cui inserire il valore: ";
                cin >> posizione;

                bool inserito_con_successo = inserisci_in_posizione(lista, valore, posizione);

                if (inserito_con_successo)
                {
                    cout << "Valore inserito correttamente nella lista." << endl;
                }
                else
                {
                    cerr << "Non è possibile inserire il valore dato perchè la posizione sfora gli estremi della lista." << endl;
                }
                
                break;
            }
            case 4:
            case 5: {
                void (*remove_function)(Lista&) = (scelta == 3) ? rimuovi_dalla_testa : rimuovi_dalla_coda;

                remove_function(lista);

                cout << "Valore rimosso dalla lista." << endl;

                break;
            }
            case 6: {
                unsigned int posizione;

                cout << "Inserisci la posizione dell'elemento da eliminare: ";
                cin >> posizione;

                rimuovi_da_posizione(lista, posizione);

                cout << "Valore rimosso." << endl;

                break;
            }
            case 7: {
                tipo_t valore;

                cout << "Inserisci il valore da cercare: ";
                leggi(valore, cin);

                if (contiene(lista, valore))
                {
                    cout << "Valore trovato nella lista." << endl;
                }
                else
                {
                    cout << "Valore non trovato nella lista." << endl;
                }

                break;
            }
            case 8:
            case 9: {
                Direzione direzione = (scelta == 8) ? Direzione::LTR : Direzione::RTL;

                stampa_lista(lista, cout, direzione);

                break;
            }
            case 10:
                cout << "La lista contiene " << numero_elementi(lista) << " elementi." << endl;

                break;
        }

    } while (scelta != 0);
    
    return 0;
}