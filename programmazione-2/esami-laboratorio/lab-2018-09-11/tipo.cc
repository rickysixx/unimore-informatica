/*
  Scrivere un programma per la gestione di liste doppie.
  Il programma presenta un menù all'utente che può
  - creare una lista di n valori (volendo ordinata)
  - cancellare tutti tutti gli elementi contenente un valore dato dalla lista
  - stampare la lista
  - cercare valori nella lista
  Se la lista è ordinata la ricerca deve richiamare ord_search() altrimenti search().
*/

#include <iostream>
#include <cstring>

using namespace std ;

#include "tipo.h"




/*******************************/
/* DEFINIZIONE MODULO "tipo" */
/*******************************/

int compare(tipo_inf s1,tipo_inf s2){
	return s1-s2;
}

void copy(tipo_inf& dest, tipo_inf source){
	dest=source;
}

void print(tipo_inf inf){
	cout<<inf;
}
