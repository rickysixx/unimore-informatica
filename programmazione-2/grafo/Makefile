# Riadattato da https://stackoverflow.com/a/52036564/9864539

# Flag g++ usati per compilare i file .cc
# -g: genera informazioni utili per il debug
# -Wall: attiva tutti i warning possibili
# -Werror: tutti i warning diventano errori
# -pedantic-errors: altro flag per incrementare la rigidità del compilatore
CXXFLAGS = -g -Wall -Werror -pedantic-errors

# SOURCES contiene tutti i file .cc presenti nella directory corrente
SOURCES = $(wildcard *.cc)

# OBJECTS contiene tutti i file .o presenti nella directory corrente
OBJECTS = $(patsubst %.cc, %.o, $(SOURCES))

# DEPENDS contiene tutti i file .d presenti nella directory corrente
DEPENDS = $(patsubst %.cc, %.d, $(SOURCES))

.PHONY: all clean

all: main.out

# Crea l'eseguibile
main.out: $(OBJECTS)
	g++ $(CXXFLAGS) $^ -o $@

clean:
	rm $(OBJECTS) $(DEPENDS) main.out

# Include in questo makefile il contenuto di tutti i file .d presenti nella directory corrente
-include $(DEPENDS)


# Rule che definisce come creare un file .o generico
# L'opzione -MMD serve per dire al g++ di generare un file .d (che avrà la stessa struttura del makefile) dove includere i file header da cui dipende il .cc compilato
# -MMD NON include nel file .d le dipendenze ad header di sistema: per farlo, usare l'opzione -MD
# -MP dice al g++ di aggiungere lo stesso le regole al file .d, anche quando sono vuote (lo scopo è evitare che make segnali poi degli errori perchè mancano delle regole) 
%.o: %.cc Makefile
	g++ $(CXXFLAGS) -MMD -MP -c $< -o $@

