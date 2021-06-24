#include <iostream>
#include <cstdlib>
#include "lista.h"

int main()
{
    Lista l1 = nullptr;
    Lista l2 = nullptr;

    srand(time(nullptr));

    for (int i = 0; i < 70; i++)
    {
        inserisci_valore(l1, rand() % 100);
        inserisci_valore(l2, rand() % 150);
    }

    std::cout << "l1:" << std::endl;
    stampa(l1, std::cout);

    std::cout << "l2:" << std::endl;
    stampa(l2, std::cout);

    std::cout << "diff:" << std::endl;
    diff(l1, l2, std::cout);

    return 0;
}