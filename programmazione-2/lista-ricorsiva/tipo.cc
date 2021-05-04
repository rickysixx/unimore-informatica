#include "tipo.h"
#include <iostream>

int compare(const int& a, const int& b)
{
    return a - b;
}

void stampa(const int& a, std::ostream& ostream)
{
    ostream << a;
}

void leggi(int& a, std::istream& istream)
{
    istream >> a;
}

void copia(int& target, const int& source)
{
    target = source;
}