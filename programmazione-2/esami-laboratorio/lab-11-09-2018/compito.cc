#include <iostream>
#include <fstream>
#include <cstring>
#include "parola.h"

const char* INVERTED_NOME_FILE = "inverted";

const unsigned int NOME_FILE_LUNGHEZZA_MASSIMA = 256;

bool contiene_parola(const parola* parole, const char* parola, const int numero_parole)
{
    bool trovata = false;

    for (int i = 0; i < numero_parole && !trovata; i++)
    {
        trovata = strcmp(parole[i].p, parola) == 0;
    }

    return trovata;
}

parola* cerca_parola(parola* parole, const char* str, const int numero_parole)
{
    parola* trovata = nullptr;

    for (int i = 0; i < numero_parole && trovata == nullptr; i++)
    {
        if (strcmp(parole[i].p, str) == 0)
        {
            trovata = &parole[i];
        }
    }

    return trovata;
}

void resize(parola*& parole, int& numero_parole)
{
    parola* resized = new parola[numero_parole + 1];

    for (int i = 0; i < numero_parole; i++)
    {
        resized[i] = parole[i];
    }

    delete[] parole;

    parole = resized;
    numero_parole += 1;
}

parola* load(int& dimensione)
{
    std::ifstream file(INVERTED_NOME_FILE);

    if (file)
    {
        file >> dimensione;

        parola* parole = new parola[dimensione];

        for (int i = 0; i < dimensione; i++)
        {
            file >> parole[i].p;
            file >> parole[i].n_doc;

            for (int j = 0; j < parole[i].n_doc; j++)
            {
                int id_documento;

                file >> id_documento;

                parole[i].l = ord_insert_elem(parole[i].l, new_elem(id_documento));
            }
        }

        return parole;
    }
    else
    {
        std::cerr << "Si è verificato un errore durante la lettura del file " << INVERTED_NOME_FILE << std::endl;

        return nullptr;
    }
}

void stampa(parola* parole, int numero_parole)
{
    for (int i = 0; i < numero_parole; i++)
    {
        std::cout << parole[i].p << std::endl;
        std::cout << parole[i].n_doc << " documenti" << std::endl;
        elem* iteratore = parole[i].l;

        while (iteratore != nullptr)
        {
            std::cout << head(iteratore);

            if (tail(iteratore) != nullptr)
            {
                std::cout << " ";
            }

            iteratore = tail(iteratore);
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

void update(parola*& ii, int& numero_parole, char* fileName)
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

                resize(ii, numero_parole);

                ii[numero_parole - 1] = *p;
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

int main()
{
    int numero_parole;
    parola* parole = load(numero_parole);
    char nome_file[NOME_FILE_LUNGHEZZA_MASSIMA];
    char parola_1[PAROLA_LUNGHEZZA_MASSIMA];
    char parola_2[PAROLA_LUNGHEZZA_MASSIMA];

    if (parole != nullptr)
    {
        stampa(parole, numero_parole);
    }

    std::cout << "Inserisci il nome del file con cui aggiornare l'inverted index: ";
    std::cin >> nome_file;

    update(parole, numero_parole, nome_file);
    stampa(parole, numero_parole);

    std::cout << "=== AND ===" << std::endl;
    std::cout << "Inserisci la prima parola: ";
    std::cin >> parola_1;

    std::cout << "Inserisci la seconda parola: ";
    std::cin >> parola_2;

    AND(parole, numero_parole, parola_1, parola_2);

    return 0;
}