CXXFLAGS = -g -Wall -error -pedantic-errors
SOURCES = $(wildcard *.cc)
OBJECTS = $(patsubst %.cc, %.o, $(SOURCES))
DEPENDS = $(patsubst %.cc, %.d, $(SOURCES))

.PHONY: all clean

all: main.out

# Crea l'eseguibile
main.out: $(OBJECTS)
	g++ $(CXXFLAGS) $^ -o $@

clean:
	rm $(OBJECTS) $(DEPENDS) main.out

# include in questo Makefile le dipendenze
-include $(DEPENDS)

# rule che definisce come creare un .o generico
# usa le opzioni -MMD e -MP per costruire il file delle dipendenze, che poi alla prossima invocazione di make verrà usato
# l'opzione -MMD dice al g++ di generare un file con tutte le dipendenze del .cc, tranne gli header di sistema
# il file delle dipendenze generato avrà un formato compatibile con il makefile: per questo viene incluso
%.o: %.cc Makefile
	g++ $(CXXFLAGS) -MMD -MP -c $< -o $@

