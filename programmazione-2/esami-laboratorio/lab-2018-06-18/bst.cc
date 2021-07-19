/*
 * tree.cc
 *
 *  Created on: 14 mag 2018
 *      Author: federica
 */
#include <iostream>
using namespace std;

#include <cstring>

#include "carta.h"
#include "bst.h"

static tipo_key copy_key(tipo_key& s,tipo_key s1){
	s=s1;
	return s;
}

static tipo_key compare_key(tipo_key s,tipo_key s1){
		return s-s1;
}

void print_key(tipo_key k){
	cout<<k;
}
tipo_key get_key(bnode* n){
	return (n->key);
}

tipo_inf get_value(bnode* n){
	return (n->inf);
}

bst get_left(bst t){
	return (t->left);
}

bst get_right(bst t){
	return (t->right);
}

bnode* get_parent(bnode* n){
	return (n->parent);
}



bnode* bst_newNode(tipo_key k, tipo_inf i){
	bnode* n=new bnode;
	copy(n->inf,i);
	copy_key(n->key,k);
	n->right=n->left=n->parent=NULL;
	return n;
}

void bst_insert(bst& b, bnode* n){
	bnode* x;
	bnode* y=NULL;
	if(b==NULL){
		    	b=n;
		    }
	else{
	    x=b;
	    while (x != NULL) {
	      y=x;
	      if (compare_key(get_key(n),get_key(x))<0) {
		      x = get_left(x);
	      } else {
		      x = get_right(x);
	      }
	    }
	    n->parent = y;
	    if (compare_key(get_key(n), get_key(y))<0) {
	      y->left = n;
	    } else {
	      y->right = n;
	    }
}}

bnode* bst_search(bst b,tipo_key k){

	    while (b != NULL) {
	      if (compare_key(k,get_key(b))==0)
	    	  return b;
	      if (compare_key(k,get_key(b))<0) {
		      b = get_left(b);
	      } else {
		      b = get_right(b);
	      }
	    }
	    return NULL;
}

// Aggiorna il puntatore al figlio (sinistro o destro) del padre di p  al nuovo elemento q
void update_father(bnode* p, bnode* q)
{
	if (p == get_left(get_parent(p)))
				(p->parent)->left = q;
		else
				(p->parent)->right = q;
}


void bst_delete(bst& b, bnode* n){
	bnode* new_child; // variabile d'appoggio che individua il nodo da sostuire a n come figlio
	   if (get_left(n) == NULL) {
	                if (get_right(n) == NULL) //Nodo foglia
	                		new_child=NULL;
	                else 
	                       new_child=get_right(n);
	                
	    }
	    else if (get_right(n) == NULL)  //Solo figlio sinistro
	            new_child=get_left(n);

			 
			 else { //Entrambi i figli: cerco l'elemento più grande nel sottoalbero di sx
	            bnode* app = get_left(n);
	            while (get_right(app) != NULL) //cerco l'elemento più a destra nel sottoalbero di sx
	           		        	app = get_right(app);
	            if(get_left(app)==NULL){ //app è una foglia
					update_father(app, NULL);
		        } else {  //app ha il figlio sinistro
					(app->parent)->right = get_left(app);
					(app->left)->parent = get_parent(app);
		        }
			    // sostituisco app a n
			    app->left = get_left(n);
			    app->right = get_right(n);
			    if(get_left(app)!=NULL)
			    	(app->right)->parent = app;
			    if(get_left(app)!=NULL)
			    	(app->left)->parent = app;
			    new_child=app;

	        }
	   if(new_child!=NULL)
		   new_child->parent = get_parent(n);
	    if(n==b) // n è la radice
	    	b=new_child;
	    else
	    	update_father(n, new_child);
	  delete n;

}

void bst_print(const bst& tree)
{
	if (tree != nullptr)
	{
		if (get_left(tree) != nullptr)
		{
			bst_print(get_left(tree));
		}

		// stampa il nodo corrente
		print_key(get_key(tree));
		std::cout << " ";
		print(get_value(tree));
		std::cout << std::endl;

		if (get_right(tree) != nullptr)
		{
			bst_print(get_right(tree));
		}
	}
}

unsigned int bst_size(const bst& tree)
{
	if (tree == nullptr)
	{
		return 0;
	}
	else if (get_left(tree) == nullptr && get_right(tree) == nullptr)
	{
		return 1;
	}
	else
	{
		return 1 + bst_size(get_left(tree)) + bst_size(get_right(tree));
	}
}

void bst_copy(bst& dest, const bst& source)
{
	if (source != nullptr)
	{
		bnode* node = bst_newNode(get_key(source), get_value(source));

		bst_insert(dest, node);

		bst_copy(dest, get_left(source));
		bst_copy(dest, get_right(source));
	}
}