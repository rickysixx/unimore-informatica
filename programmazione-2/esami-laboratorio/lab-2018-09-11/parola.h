#include "liste.h"

const unsigned int PAROLA_LUNGHEZZA_MASSIMA = 80;

struct parola
{
    char p[PAROLA_LUNGHEZZA_MASSIMA]; //parola
    int n_doc;  //numero di documenti che contengono la parola
    lista l;    //lista dei documenti
};