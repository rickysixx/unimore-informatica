#include <iostream>
#include <fstream>
#include <cstring>
#include "parola.h"

const char* INVERTED_NOME_FILE = "inverted";

const unsigned int NOME_FILE_LUNGHEZZA_MASSIMA = 256;

parola* cerca_parola(parola* ii, const char* p, const int numero_parole)
{
    parola* trovata = nullptr;

    for (int i = 0; i < numero_parole && trovata == nullptr; i++)
    {
        if (strcmp(ii[i].p, p) == 0)
        {
            trovata = &ii[i];
        }
    }

    return trovata;
}

void inserisci_nuova_parola(parola*& ii, unsigned int& numero_parole, const parola& nuova_parola)
{
    parola* resized = new parola[numero_parole + 1];

    for (unsigned int i = 0; i < numero_parole; i++)
    {
        resized[i] = ii[i];
    }

    delete[] ii;

    ii = resized;
    numero_parole += 1;
    ii[numero_parole - 1] = nuova_parola;
}

int cerca_id_massimo_documento(const parola* ii, const int numero_parole)
{
    int max = -1;

    for (int i = 0; i < numero_parole; i++)
    {
        for (elem* it = ii[i].l; it != nullptr; it = tail(it))
        {
            int id_documento = head(it);

            max = (id_documento > max) ? id_documento : max;
        }
    }

    return max;
}

parola* load(unsigned int& numero_parole_caricate)
{
    std::ifstream file(INVERTED_NOME_FILE);

    if (file)
    {
        file >> numero_parole_caricate;

        parola* ii = new parola[numero_parole_caricate];

        for (unsigned int i = 0; i < numero_parole_caricate; i++)
        {
            file >> ii[i].p;
            file >> ii[i].n_doc;

            for (int j = 0; j < ii[i].n_doc; j++)
            {
                int id_documento;

                file >> id_documento;

                ii[i].l = ord_insert_elem(ii[i].l, new_elem(id_documento));
            }
        }

        return ii;
    }
    else
    {
        std::cerr << "Si è verificato un errore durante la lettura del file " << INVERTED_NOME_FILE << std::endl;

        return nullptr;
    }
}

void stampa(parola* ii, int numero_parole)
{
    for (int i = 0; i < numero_parole; i++)
    {
        std::cout << ii[i].p << std::endl;
        std::cout << ii[i].n_doc << " documenti" << std::endl;

        for (elem* it = ii[i].l; it != nullptr; it = tail(it))
        {
            std::cout << head(it);

            if (tail(it) != nullptr)
            {
                std::cout << " ";
            }
        }

        std::cout << std::endl;
    }
}

void AND(parola* ii, const int numero_parole, const char* w1, const char* w2)
{
    parola* w1_p = cerca_parola(ii, w1, numero_parole);
    parola* w2_p = cerca_parola(ii, w2, numero_parole);

    if (w1_p == nullptr)
    {
        std::cerr << "La parola " << w1 << " non fa parte dell'inverted index." << std::endl;
    }
    else if (w2_p == nullptr)
    {
        std::cerr << "La parola " << w2 << " non fa parte dell'inverted index." << std::endl;
    }
    else
    {
        elem* it_w1 = w1_p->l;
        elem* it_w2 = w2_p->l;

        while (it_w1 != nullptr && it_w2 != nullptr)
        {
            if (head(it_w1) == head(it_w2))
            {
                std::cout << head(it_w1) << " ";

                it_w1 = tail(it_w1);
                it_w2 = tail(it_w2);
            }
            else if (head(it_w1) < head(it_w2))
            {
                it_w1 = tail(it_w1);
            }
            else
            {
                it_w2 = tail(it_w2);
            }
        }

        std::cout << std::endl;
    }
}

void update(parola*& ii, unsigned int& numero_parole, char* fileName)
{
    std::ifstream file(fileName);

    if (file)
    {
        int id_documento;
        char buffer[PAROLA_LUNGHEZZA_MASSIMA];

        file >> id_documento;

        while (file >> buffer)
        {
            parola* p = cerca_parola(ii, buffer, numero_parole);

            if (p == nullptr)
            {
                p = new parola;

                strcpy(p->p, buffer);
                p->n_doc = 1;
                p->l = new_elem(id_documento);

                inserisci_nuova_parola(ii, numero_parole, *p);
            }
            else
            {
                ord_insert_elem(p->l, new_elem(id_documento));
            }
        }

        std::cout << "Inverted index aggiornato con successo." << std::endl;
    }
    else
    {
        std::cerr << "Si è verificato un errore durante la lettura dal file " << fileName << std::endl;
    }
}

int* match(parola* ii, const int numero_parole_ii, char (*wl)[PAROLA_LUNGHEZZA_MASSIMA], const int numero_parole_wl, unsigned int& nr_match_trovati)
{
    unsigned int dimensione_array_occorrenze = cerca_id_massimo_documento(ii, numero_parole_ii) + 1;
    unsigned int* occorrenze = new unsigned int[dimensione_array_occorrenze];

    for (unsigned int i = 0; i < dimensione_array_occorrenze; i++)
    {
        occorrenze[i] = 0;
    }

    for (int i = 0; i < numero_parole_wl; i++)
    {
        parola* p = cerca_parola(ii, wl[i], numero_parole_ii);

        if (p != nullptr)
        {
            for (elem* it = p->l; it != nullptr; it = tail(it))
            {
                occorrenze[head(it)]++;
            }
        }
    }

    nr_match_trovati = 0;

    for (unsigned int i = 0; i < dimensione_array_occorrenze; i++)
    {
        if (occorrenze[i] != 0)
        {
            nr_match_trovati++;
        }
    }

    std::cout << "[DEBUG] nr_match_trovati: " << nr_match_trovati << std::endl;

    int* match_trovati = new int[nr_match_trovati];

    for (unsigned int i = 0; i < nr_match_trovati; i++)
    {
        unsigned int max = occorrenze[0];
        int id_documento_max = 0;

        for (unsigned int j = 1; j < dimensione_array_occorrenze; j++)
        {
            if (occorrenze[j] > max)
            {
                max = occorrenze[j];
                id_documento_max = j;
            }
        }

        match_trovati[i] = id_documento_max;
        occorrenze[id_documento_max] = 0;
    }

    delete[] occorrenze;

    return match_trovati;
}

int main()
{
    unsigned int numero_parole_ii;
    parola* ii = load(numero_parole_ii);
    char nome_file[NOME_FILE_LUNGHEZZA_MASSIMA];
    char parola_1[PAROLA_LUNGHEZZA_MASSIMA];
    char parola_2[PAROLA_LUNGHEZZA_MASSIMA];

    if (ii != nullptr)
    {
        stampa(ii, numero_parole_ii);
    }

    std::cout << "Inserisci il nome del file con cui aggiornare l'inverted index: ";
    std::cin >> nome_file;

    update(ii, numero_parole_ii, nome_file);
    stampa(ii, numero_parole_ii);

    std::cout << "=== AND ===" << std::endl;
    std::cout << "Inserisci la prima parola: ";
    std::cin >> parola_1;

    std::cout << "Inserisci la seconda parola: ";
    std::cin >> parola_2;

    AND(ii, numero_parole_ii, parola_1, parola_2);

    std::cout << "=== MATCH ===" << std::endl;
    unsigned int numero_parole_per_match = 0;

    std::cout << "Quante parole vuoi inserire? ";
    std::cin >> numero_parole_per_match;

    char (*wl)[PAROLA_LUNGHEZZA_MASSIMA] = new char[numero_parole_per_match][PAROLA_LUNGHEZZA_MASSIMA];

    for (unsigned int i = 0; i < numero_parole_per_match; i++)
    {
        std::cout << "Inserisci la parola " << (i + 1) << ": ";
        std::cin >> wl[i];
    }

    unsigned int nr_match_trovati;
    int* matches = match(ii, numero_parole_ii, wl, numero_parole_per_match, nr_match_trovati);
    
    for (unsigned int i = 0; i < nr_match_trovati; i++)
    {
        std::cout << matches[i] << " ";
    }

    std::cout << std::endl;

    return 0;
}