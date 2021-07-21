
#include <iostream>

using namespace std;

#include "codap.h"

static elem* new_elem(int inf, float w) {
	elem *p = new elem;
	p->inf = inf;
	p->w = w;
	p->pun = NULL;
	return p;

}

static codap tail(codap p) {
	return p->pun;
}

/*******************************/
/* DEFINIZIONE MODULO "codap" */
/*******************************/

codap enqueue(codap c, int i, float w) {
	elem *e = new_elem(i, w);
	if (c == NULL || e->w < c->w) {
		e->pun = c;
		return e;
	} else {
		codap c1 = c;
		while (tail(c1) != NULL && tail(c1)->w < e->w)
			c1 = tail(c1);
		e->pun = c1->pun;
		c1->pun = e;
		return c;
	}
}

int dequeue(codap &c) {
	int ris;	// Commento ris
	ris = c->inf;
	elem *app = c;
	c = c->pun;
	delete app;
	return ris;
}

int minQueue(codap c) {
	return c->inf;
}

bool isEmpty(codap c) {
	if (c == NULL)
		return true;
	return false;
}

codap Decrease_Priority(codap c, int i, float w) {
	codap capp = c;
	if (c==NULL)
		return c;
	if (c->inf == i) {
		c->w = w;  // era -=
		return c;
	}
	while (tail(capp) != NULL) {
		if (tail(capp)->inf == i) {
			tail(capp)->w = w; // era -=
			if (capp->w > tail(capp)->w) {
				elem *ele = tail(capp);
				capp->pun = tail(capp)->pun;
				c = enqueue(c, ele->inf, ele->w);
				delete ele;
				return c;
			}
		}
		capp = tail(capp);
	}
	return c;
}

