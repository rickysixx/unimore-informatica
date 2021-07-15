/*******************************/
/* HEADER MODULO "carta" 	   */
/*******************************/
#ifndef CARTA_H
#define CARTA_H
const unsigned int NOME_COGNOME_LUNGHEZZA_MASSIMA = 40;

struct Carta
{
    char nome_cognome[NOME_COGNOME_LUNGHEZZA_MASSIMA];
    unsigned int totale_punti = 0;
};

typedef Carta tipo_inf;

int compare(tipo_inf, tipo_inf);
void copy(tipo_inf&, tipo_inf);
void print(tipo_inf);
#endif