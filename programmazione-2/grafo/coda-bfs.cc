#include <iostream>

using namespace std;

#include "grafo.h"
#include "coda-bfs.h"

/*******************************/
/* DEFINIZIONE MODULO "coda" */
/*******************************/

static elemBFS *new_elem(int n)
{
	elemBFS *p = new elemBFS;
	p->inf = n;
	p->pun = NULL;
	return p;
}

codaBFS enqueue(codaBFS c, int i)
{
	elemBFS *e = new_elem(i);
	if (c.tail != NULL)
		c.tail->pun = e;
	c.tail = e;
	if (c.head == NULL)
		c.head = c.tail;
	return c;
}

int dequeue(codaBFS &c)
{
	int ris = (c.head)->inf;
	c.head = (c.head)->pun;
	return ris;
}

int first(codaBFS c)
{
	return (c.head)->inf;
}

bool isEmpty(codaBFS c)
{
	if (c.head == NULL)
		return true;
	return false;
}

codaBFS newQueue()
{
	codaBFS c = {NULL, NULL};
	return c;
}
