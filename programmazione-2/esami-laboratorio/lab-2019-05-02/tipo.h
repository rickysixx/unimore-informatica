/*******************************/
/* HEADER MODULO "tipo" */
/*******************************/
struct carta
{
	char seme;
	int valore;
};

typedef carta tipo_inf;

int compare(tipo_inf, tipo_inf);
void copy(tipo_inf &, tipo_inf);
void print(tipo_inf);
