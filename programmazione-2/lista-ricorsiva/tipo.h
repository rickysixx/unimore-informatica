#ifndef TIPO_H
#define TIPO_H 1

#include <iostream>

typedef int tipo_t;

int compare(const tipo_t& a, const tipo_t& b);

void stampa(const tipo_t& a, std::ostream& ostream);
void leggi(tipo_t&, std::istream&);

void copia(tipo_t& target, const tipo_t& source);

#endif