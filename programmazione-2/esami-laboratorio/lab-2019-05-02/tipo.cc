#include <iostream>
#include "tipo.h"

static int confronta_semi(const tipo_inf& a, const tipo_inf& b)
{
    const unsigned int numero_semi = 4;
    char semi[numero_semi] = {'C', 'F', 'P', 'Q'};
    unsigned int indice_seme_a = '\0';
    unsigned int indice_seme_b = '\0';

    for (unsigned int i = 0; i < numero_semi && (indice_seme_a == '\0' || indice_seme_b == '\0'); i++)
    {
        if (semi[i] == a.seme)
        {
            indice_seme_a = i;
        }

        if (semi[i] == b.seme)
        {
            indice_seme_b = i;
        }
    }

    return indice_seme_a - indice_seme_b;
}

int compare(tipo_inf a, tipo_inf b)
{
    int confronto_semi = confronta_semi(a, b);

    if (confronto_semi == 0)
    {
        return a.valore - b.valore;
    }
    else
    {
        return confronto_semi;
    }
}

void copy(tipo_inf& dest, tipo_inf source)
{
    dest.seme = source.seme;
    dest.valore = source.valore;
}

void print(tipo_inf carta)
{
    std::cout << carta.valore << carta.seme;
}