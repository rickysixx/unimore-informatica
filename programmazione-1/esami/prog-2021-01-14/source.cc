#include <iostream>
#include <fstream>

const char* NOME_FILE = "coda.txt";
const char UTENTE_NULLO = '\0';

using namespace std;

struct Coda
{
    char* array = nullptr; // l'array che contiene gli ID dei servizi per i quali gli utenti sono in coda
    unsigned int numero_elementi = 0;
    unsigned int capacita = 0;
    unsigned int indice_testa = 0;
};

void resetta_coda(Coda& coda)
{
    delete[] coda.array;

    coda.numero_elementi = 0;
    coda.capacita = 0;
    coda.indice_testa = 0;
    coda.array = nullptr;
}

bool coda_piena(const Coda& coda)
{
    return coda.numero_elementi == coda.capacita;
}

bool coda_vuota(const Coda& coda)
{
    return coda.numero_elementi == 0;
}

unsigned int calcola_indice_coda(const Coda& coda)
{
    return (coda_vuota(coda)) ? 0 : (coda.indice_testa + coda.numero_elementi - 1) % coda.capacita;
}

unsigned int incrementa_indice(const Coda& coda, const int indice)
{
    return (indice + 1) % coda.capacita;
}

unsigned int decrementa_indice(const Coda& coda, const int indice)
{
    return (indice == 0) ? coda.capacita - 1 : indice - 1;
}

bool inserisci_in_coda(Coda& coda, const char codice_servizio)
{
    if (coda_piena(coda))
    {
        return false;
    }
    else
    {
        int indice_coda;

        if (coda_vuota(coda))
        {
            indice_coda = calcola_indice_coda(coda);
            coda.indice_testa = indice_coda;
        }
        else
        {
            indice_coda = incrementa_indice(coda, calcola_indice_coda(coda));
        }

        coda.array[indice_coda] = codice_servizio;
        ++coda.numero_elementi;

        return true;
    }
}

char rimuovi_dalla_testa(Coda& coda)
{
    if (coda_vuota(coda))
    {
        return UTENTE_NULLO;
    }
    else
    {
        char codice_servizio = coda.array[coda.indice_testa];

        coda.indice_testa = incrementa_indice(coda, coda.indice_testa);
        --coda.numero_elementi;

        return codice_servizio;
    }
}

void inizializza_coda(Coda& coda, const unsigned int N)
{
    resetta_coda(coda);

    if (N > 0)
    {
        coda.capacita = N;
        coda.numero_elementi = 0;
        coda.indice_testa = 0;
        coda.array = new char[coda.capacita];
    }
}

bool accoda_utente(Coda& coda, const char codice_servizio)
{
    return inserisci_in_coda(coda, codice_servizio);
}

void stampa_coda(const Coda& coda)
{
    if (coda_vuota(coda))
    {
        cout << "La coda è vuota." << endl;
    }
    else
    {
        int indice = coda.indice_testa; // indice che uso per scorrere la coda

        cout << coda.array[indice];

        for (unsigned int i = 1; i < coda.numero_elementi; i++)
        {
            indice = incrementa_indice(coda, indice);

            cout << " " << coda.array[indice];
        }
        
        cout << endl;
    }
}

bool salva_coda(const Coda& coda)
{
    ofstream file(NOME_FILE);

    if (file)
    {
        file << coda.capacita << endl;
        file << coda.indice_testa << endl;
        file << coda.numero_elementi << endl;

        file.write(coda.array, coda.numero_elementi * sizeof(char));

        return true;
    }
    else
    {
        return false;
    }
}

bool carica_coda(Coda& coda)
{
    ifstream file(NOME_FILE);

    if (file)
    {
        resetta_coda(coda);

        file >> coda.capacita;
        file >> coda.indice_testa;
        file >> coda.numero_elementi;

        coda.array = new char[coda.capacita];

        while (file.peek() == '\n')
        {
            file.get(); // consuma eventuali '\n' presenti nel file dopo il numero di elementi della coda
        }

        file.read(coda.array, coda.numero_elementi * sizeof(char));

        return true;
    }
    else
    {
        return false;
    }
}

char servi_prossimo_utente(Coda& coda)
{
    return rimuovi_dalla_testa(coda);
}

void anticipa_servizio(Coda& coda, const char codice_servizio)
{
    if (!coda_vuota(coda))
    {
        unsigned int indice_fine_sottosequenza_ordinata = coda.indice_testa;
        unsigned int i = coda.indice_testa; // indice con cui scorrere la coda
        const unsigned int indice_coda = calcola_indice_coda(coda);

        while (i != indice_coda)
        {
            const unsigned int indice_prossimo_elemento = incrementa_indice(coda, i);

            if (coda.array[i] != coda.array[indice_prossimo_elemento] && coda.array[indice_prossimo_elemento] == codice_servizio)
            {
                unsigned int j = indice_prossimo_elemento;

                while (j != indice_fine_sottosequenza_ordinata)
                {
                    const unsigned int indice_elemento_precedente = decrementa_indice(coda, j);
                    char temp = coda.array[j];
                    
                    coda.array[j] = coda.array[indice_elemento_precedente];
                    coda.array[indice_elemento_precedente] = temp;

                    j = indice_elemento_precedente;
                }

                indice_fine_sottosequenza_ordinata = incrementa_indice(coda, indice_fine_sottosequenza_ordinata);
            }

            i = indice_prossimo_elemento;
        }
    }
}

int main()
{
    Coda coda;
	const char menu[] =
		"1. Reinizializza coda\n"
		"2. Accoda utente\n"
		"3. Stampa coda\n"
		"4. Salva coda\n"
		"5. Carica coda\n"
		"6. Servi prossimo utente\n"
		"7. Anticipa servizio\n"
		"8. Esci\n";

	while (true) {
		cout<<menu<<endl;
		int scelta;
		cin>>scelta;

		cout<<endl ; // per il corretto funzionamento del tester

		switch (scelta) {
		case 1:
			unsigned int capacita_coda;

            cout << "Inserisci la capacita della coda: ";
            cin >> capacita_coda;

            inizializza_coda(coda, capacita_coda);
            
            break;
		case 2:
            char codice_servizio;

            cout << "Inserisci il codice del servizio per cui accodare l'utente: ";
            cin >> codice_servizio;

            if (accoda_utente(coda, codice_servizio))
            {
                cout << "Utente accodato correttamente." << endl;
            }
            else
            {
                cerr << "Errore! La coda è piena. Non è possibile accodare nuovi utenti." << endl;
            }
            
			break;
		case 3:
            stampa_coda(coda);

			break;
		case 4:
            if (salva_coda(coda))
            {
                cout << "Coda salvata correttamente su file." << endl;
            }
            else
            {
                cerr << "Si è verificato un errore durante il salvataggio della coda su file." << endl;
            }
            
			break;
		case 5:
            if (carica_coda(coda))
            {
                cout << "Coda caricata correttamente dal file." << endl;
            }
            else
            {
                cerr << "Si è verificato un errore durante il caricamento della coda dal file." << endl;
            }
            
			break;
		case 6: {
            char codice_servizio = servi_prossimo_utente(coda);

            if (codice_servizio != UTENTE_NULLO)
            {
                cout << "Utente servito correttamente." << endl;
            }
            else
            {
                cerr << "Errore! La coda è vuota, non c'è nessun utente da servire." << endl;
            }
            
			break;
        }
		case 7: {
            char codice_servizio;

            cout << "Inserisci il codice del servizio da anticipare: ";
            cin >> codice_servizio;

            anticipa_servizio(coda, codice_servizio);

            cout << "Servizio anticipato." << endl;

			break;
        }
		case 8:
			return 0;
		default:
			cout<<"Scelta errata"<<endl;
		}
	}

	return 1;
}
