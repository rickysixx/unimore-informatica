#include <iostream>
#include <cstdlib>
#include "lista.h"

int main()
{
    Lista lista = nullptr;

    srand(time(nullptr));

    for (int i = 0; i < 70; i++)
    {
        inserisci_valore(lista, rand() % 100);
    }

    stampa(lista, std::cout);

    return 0;
}