/*******************************/
/* HEADER MODULO "codaBFS" */
/*******************************/
struct elemBFS
{
       int inf;
       elemBFS *pun;
};

typedef elemBFS *lista;

struct codaBFS
{
       lista head;
       elemBFS *tail;
};

codaBFS enqueue(codaBFS, int);
int dequeue(codaBFS &);
int first(codaBFS);
bool isEmpty(codaBFS);
codaBFS newQueue();
