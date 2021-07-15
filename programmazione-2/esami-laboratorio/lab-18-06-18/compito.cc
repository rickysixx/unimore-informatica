#include <iostream>
#include "carta.h"
#include "bst.h"

void leggi_riga(std::istream& stream, char* buffer, const unsigned int lunghezza_massima)
{
    // ignora eventuali \n presenti
    while (stream.peek() == '\n')
    {
        stream.get();
    }

    stream.getline(buffer, lunghezza_massima);
}

unsigned int totalePunti(const bst& tree, const tipo_key& inf, const tipo_key& sup)
{
    if (tree == nullptr)
    {
        return 0;
    }
    else if (get_key(tree) < inf)
    {
        return totalePunti(get_right(tree), inf, sup);
    }
    else if (get_key(tree) > sup)
    {
        return totalePunti(get_left(tree), inf, sup);
    }
    else
    {
        return get_value(tree).totale_punti + totalePunti(get_left(tree), inf, sup) + totalePunti(get_right(tree), inf, sup);
    }
}

bool aggiorna(bst& tree, const tipo_key& codice_carta, const unsigned int punti)
{
    bnode* nodo = bst_search(tree, codice_carta);

    if (nodo == nullptr)
    {
        std::cerr << "Errore! Nessuna carta trovata con codice ";
        print_key(codice_carta);
        std::cerr << std::endl;

        return false;
    }
    else
    {
        Carta nuova_carta;

        copy(nuova_carta, get_value(nodo));

        nuova_carta.totale_punti += punti;

        std::cout << "Carta aggiornata." << std::endl;

        bst_delete(tree, nodo);

        bnode* nuovo_nodo = bst_newNode(codice_carta, nuova_carta);
        bst_insert(tree, nuovo_nodo);

        return true;
    }
}

int main()
{
    bst tree = nullptr;
    unsigned int numero_carte;

    std::cout << "Benvenuto." << std::endl;
    std::cout << "Quante carte vuoi inserire? ";
    std::cin >> numero_carte;

    for (unsigned int i = 1; i <= numero_carte; i++)
    {
        int codice_carta;
        Carta carta;

        std::cout << "Inserisci il codice della carta nr. " << i << ": ";
        std::cin >> codice_carta;

        std::cout << "Inserisci il nominativo della carta nr. " << i << ": ";
        leggi_riga(std::cin, carta.nome_cognome, NOME_COGNOME_LUNGHEZZA_MASSIMA);

        std::cout << "Inserisci il saldo punti della carta nr. " << i << ": ";
        std::cin >> carta.totale_punti;

        bnode* node = bst_newNode(codice_carta, carta);

        bst_insert(tree, node);
    }

    std::cout << "Le carte da te inserite sono:" << std::endl;
    bst_print(tree);

    std::cout << "=== Calcolo totale punti ===" << std::endl;
    tipo_key codice_inf, codice_sup;
    
    std::cout << "Inserisci il codice della carta 'inf': ";
    std::cin >> codice_inf;

    std::cout << "Inserisci il codice della carta 'sup': ";
    std::cin >> codice_sup;

    std::cout << "Il totale dei punti è " << totalePunti(tree, codice_inf, codice_sup) << std::endl;

    std::cout << "=== Aggiornamento carta ===" << std::endl;
    char flag = '\0';
    bst tree_copy = nullptr;

    bst_copy(tree_copy, tree);
    
    do
    {
        tipo_key codice_carta;
        unsigned int punti;

        std::cout << "Inserisci il codice della carta da aggiornare: ";
        std::cin >> codice_carta;

        std::cout << "Inserisci i punti da aggiungere alla carta: ";
        std::cin >> punti;

        if (aggiorna(tree, codice_carta, punti))
        {
            bnode* nodo = bst_search(tree_copy, codice_carta);
            bst_delete(tree_copy, nodo);
        }

        std::cout << "Inserisci 'q' per terminare l'aggiornamento: ";
        std::cin >> flag;
    } while (flag != 'q');

    std::cout << "BST aggiornato:" << std::endl;
    bst_print(tree);

    std::cout << "Carte non aggiornate:" << std::endl;
    bst_print(tree_copy);
    
    return 0;
}