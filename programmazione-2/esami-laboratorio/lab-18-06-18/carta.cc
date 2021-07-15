#include <iostream>
#include <cstring>
#include "carta.h"

int compare(tipo_inf a, tipo_inf b)
{
    int compare_punti = a.totale_punti - b.totale_punti;

    if (compare_punti == 0)
    {
        return strcmp(a.nome_cognome, b.nome_cognome);
    }
    else
    {
        return compare_punti;
    }
}

void copy(tipo_inf& dest, tipo_inf source)
{
    strcpy(dest.nome_cognome, source.nome_cognome);
    dest.totale_punti = source.totale_punti;
}

void print(tipo_inf carta)
{
    std::cout << carta.nome_cognome << " " << carta.totale_punti;
}
