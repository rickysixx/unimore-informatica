/**
* HEADER MODULO "coda"
*/

/// Elem doc @author Federica Mandreoli
struct elem
{
	/// Doc di inf prima
       int inf;     /**< Doc di inf */
       float w;		/**< Peso */
       elem* pun ;	/**< Puntatore al successivo */
};

/** Elemento di tipo codap.
 *
 */
typedef elem* codap;

/** Accoda un elemento alla coda.
 *
 * Il metodo enqueue prende in ingresso un elemento di tipo ::codap, l'id dell'elemento e il peso.
 */
codap enqueue(codap, int,float);

/// Metodo dequeue
int dequeue(codap&);
int minQueue(codap);
codap Decrease_Priority(codap, int,float);
bool isEmpty(codap);
