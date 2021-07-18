/*******************************/
/* HEADER MODULO "liste" */
/*******************************/
#include "tipo.h"

struct elem
{
       tipo_inf inf;
       elem* pun ;
       elem* prev;
} ;

typedef elem* lista ;
	
lista tail(lista);
lista prev(lista);
lista insert_elem(lista, elem*);
lista delete_elem(lista, elem*);
lista ord_insert_elem(lista, elem*);

tipo_inf head(lista);
elem* ord_search(lista, tipo_inf);
elem* new_elem(tipo_inf);
elem* search(lista, tipo_inf);
