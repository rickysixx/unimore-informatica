#set par(leading: 0.55em, justify: true, linebreaks: "optimized")
#set text(font: "New Computer Modern", lang: "en")
#set heading(numbering: "1. ")
#show par: set block(spacing: 1em)
#show raw: set text(font: "Courier New", size: 11pt)
#show raw.where(block: false): box.with(
    fill: luma(240),
    inset: (x: 3pt, y: 0pt),
    outset: (y: 3pt),
    radius: 2pt
)

#show heading.where(level: 1): it => {
    pagebreak(weak: true)
    it
}

#outline(
    indent: auto
)

= Introduzione alle reti

== Definizione di rete

Una rete può essere definita come:

- due o più #strong[nodi] connessi tramite #strong[collegamenti];
- due o più #strong[reti] connesse tramite #strong[nodi] (definizione
  ricorsiva)

Componenti fondamentali di una rete:

- nodi (es. #strong[host], #strong[switch], #strong[router], ecc.);
- collegamenti (#strong[link])

== Protocolli

#table(
  columns: (1fr),
  [
    #strong[Definizione]: protocollo

    Insieme di regole seguite da entità che intendono comunicare tra loro.
  ]
)

Elementi di un protocollo:

- #strong[sintassi]: insieme e struttura dei comandi, formato dei
  messaggi, ecc.;
- #strong[semantica]: #strong[significato] dei comandi/azioni/risposte;
- #strong[temporizzazione]: specifica delle possibili sequenze temporali
  di emissione dei comandi;
- #strong[schema di naming]: per dare un #strong[nome] ai vari
  interlocutori

Un protocollo può avere diversi obiettivi:

- prestazioni (massima velocità possibile);
- affidabilità (resistenza ai guasti);
- sicurezza

L'obiettivo di un protocollo non è quello di far comunicare due host, ma
quello di far comunicare due #strong[applicazioni] su host diversi.

=== Stack di protocolli

I protocolli sono organizzati all'interno di uno #strong[stack]. Ogni
livello dello stack risolve un problema specifico e può offrire diversi
protocolli alternativi.

Ogni protocollo possiede due #strong[interfacce interne] ed
un'#strong[interfaccia esterna].

- le interfacce interne servono per comunicare con i protocolli di
  livello superiore ed inferiore #strong[sullo stesso nodo];

- l'interfaccia esterna serve per comunicare con il protocollo allo
  stesso livello #strong[su un altro nodo]

#figure([#image("images/ff359bd4a8f2c15bc8c7e2a739ddc365.png")],
  caption: [
    Interfacce di un protocollo
  ]
)

Dal punto di vista logico, la comunicazione avviene tra protocolli che
si trovano allo stesso livello.

#figure([#image("images/7cf4c83a44c667b830f3786f9cbaa4e3.png")],
  caption: [
    Comunicazione tra protocolli (livello logico)
  ]
)

In realtà, la comunicazione avviene allo stesso livello solo per il
livello più basso:

#figure([#image("images/54b4663cfbc31aeb67881d98199ce4c9.png")],
  caption: [
    Comunicazione tra protocolli (reale)
  ]
)

== Multiplexing e demultiplexing

#table(
  columns: (1fr),
  [#strong[Multiplexing]: tanti nodi inviano messaggi sullo stesso canale #strong[condiviso]],
  [#strong[Demultiplexing]: i messaggi inviati nello stesso canale condiviso vengono \"smistati\" in modo da arrivare solo all'effettivo destinatario.]
)

#figure(
  image("images/3aa93a38888db569feed7cac46c242d9.png", width: 40%),
  caption: [
    Multiplexing e demultiplexing
  ]
)

Multiplexing e demultiplexing sono fondamentali per ottimizzare
l'utilizzo delle risorse.

== Modalità di trasferimento dei dati

=== Circuit switching

Paradigma di comunicazione #strong[orientato alla connessione]:

- si instaura una connessione prima di inviare le informazioni;
- si chiude la connessione una volta terminata la comunicazione

È alla base dei protocolli analogici (es. telefonate).

#strong[Pro]: si riesce a sapere in anticipo se ci sono risorse
sufficienti per comunicare (lo si capisce nel momento in cui si crea la
connessione).

#strong[Contro]: non è possibile modulare l'utilizzo delle risorse in
base all'uso del circuito. Il canale occupa una quantità
#strong[costante] di risorse.

Nel circuit switching il multiplexing viene implementato dividendo la
banda disponibile in più canali (#strong[time division multiplexing]).

=== Packet switching

Paradigma di comunicazione #strong[orientato ai pacchetti], alla base
del funzionamento di Internet.

L'unità base della comunicazione è il #strong[pacchetto]. Ogni pacchetto
utilizza #strong[tutta] la capacità trasmissiva di un link.

L'accesso al mezzo non è temporizzato a priori: tutti i nodi possono
comunicare quando gli pare.

Nel packet switching si ha un #strong[multiplexing probabilistico]: non
c'è l'effettiva occupazione di un canale, ma l'uso delle risorse dipende
da quanti dati vengono inviati.

Problemi rilevanti nel packet switching:

- #strong[collisioni] nelle reti locali (due nodi all'interno della
  stessa rete locale inviano un pacchetto sullo stesso link nello stesso
  momento);
- #strong[congestioni] nelle reti (e.g. nei buffer dei router).

Collisioni e congestioni intaccano l'#strong[affidabilità] della
comunicazione, perché possono provocare #strong[perdite di pacchetti].

I protocolli di rete devono essere in grado di rilevare e affrontare
questi problemi.

=== Circuit switching vs packet switching


#table(
  columns: (1fr),
  [
    *Bandwidth*: quantità di dati trasmessa per unità di tempo. Si misura in bit per secondo.
  ]
)


Esempio:
- link a 1 Mbps;
- ciascun utente richiede 0.1 Mbps quando trasmette ed è attivo il 10%
  del tempo

Con circuit switching:
$ "nr. utenti massimo" = frac("1 Mbps totali", "0.1 Mbps per utente") = "10 utenti" $

Con packet switching invece si possono supportare fino a 35 utenti con
un rischio di collisione bassissimo.

Se i protocolli sono in grado di gestire collisioni e congestioni, una
piccola probabilità che questi eventi si verifichino non dà problemi.

== Implementazione dello stack per Internet

Internet si basa su uno #strong[stack di protocolli] e sul paradigma
#strong[packet switching].

Ogni pacchetto è costituito da #strong[header] e #strong[payload]:

- l'header (o PCI \= Protocol Control Information) contiene
  #strong[metadati] necessari per il funzionamento del protocollo;
- il payload (o SDU \= Service Data Unit) contiene i dati effettivi

$ upright("PCI") plus upright("SDU") eq upright("PDU (Protocol Data Unit)") $
La comunicazione avviene in questo modo:

+ il mittente crea il pacchetto al livello più alto dello stack;

+ il pacchetto attraversa #underline[dall'alto verso il basso] lo stack
  del mittente. Ad ogni livello dello stack viene creato un nuovo
  pacchetto che #strong[incapsula] quello del livello superiore;

+ il pacchetto raggiunge il mezzo di comunicazione fisico e viene
  inviato al destinatario;

+ il pacchetto attraversa #underline[dal basso verso l'alto] tutto lo
  stack del destinatario. Ad ogni livello il pacchetto viene
  \"spacchettato\": viene letto l'header relativo a quel livello e il
  contenuto viene inoltrato al livello superiore;

+ il pacchetto raggiunge il livello più alto dello stack del nodo
  destinazione. A questo punto viene letto il payload contenuto nel
  pacchetto

#figure([
    #image("images/83de2cbf0e72c98ea4f942f14bc377f3.png")
    #image("images/a947a4376e73e9a221fe470f03a1889e.png")
    #image("images/486e6f9bc08c4e987d776e9ba2af7c8e.png")
  ],
  caption: [
    Comunicazione in Internet
  ]
)

== Standard per la comunicazione

Standard principali

- ISO/OSI (de iure)

- TCP/IP (de facto)

=== Modello ISO/OSI

Il modello ISO/OSI prevede due tipi di protocolli:

- protocolli di comunicazione (network level): permettono la
  comunicazione tra nodi e nascondono le caratteristiche dei mezzi
  fisici utilizzati;
- protocolli di elaborazione (application level): permettono il
  controllo delle applicazioni

#figure(
  table(
    columns: (auto, 1fr),
    align: (center + horizon, left + horizon),
    [fisico], [gestisce la trasmissione sul mezzo fisico],
    [data link], [gestisce l'#strong[accesso al mezzo] e trasforma i segnali elettrici in #strong[frame privi di errori]],
    [rete], [fornisce le funzionalità per l'#strong[instradamento] dei pacchetti],
    [trasporto], [effettua il controllo #strong[end-to-end] della sessione di comunicazione e garantisce l'#strong[affidabilità] del trasporto],
    [sessione], [consente di stabilire delle #strong[sessioni], implementando funzioni di coordinamento, sincronizzazione e mantenimento dello stato],
    [presentazione], [risolve differenze di formato che possono rappresentarsi tra i diversi nodi della rete (es. conversione ASCII, Unicode, ecc.). Gestisce anche #strong[compressione], #strong[sicurezza] ed #strong[autenticità] dei messaggi attraverso tecniche di crittografia],
    [applicativo], [fornisce un'interfaccia per i programmi applicativi che utilizzano la rete]
  ),
  caption: [Livelli del modello ISO/OSI]
)

Il modello ISO/OSI non è riuscito ad affermarsi per questioni di
tempismo: le implementazioni funzionanti delle specifiche ISO/OSI sono
arrivate molto in ritardo rispetto a quelle di TCP/IP.

=== Stack TCP/IP

Lo stack TCP/IP è composto da soli 4 livelli:

#figure(
  image("images/2538727a8c93afe05b1c41629ca91869.png", height: 20%),
  caption: [
    Stack TCP/IP
  ]
)

+ livello fisico: gestisce la trasmissione dei bit sul mezzo fisico;

+ livello data link: gestisce la comunicazione tra nodi
  #strong[confinanti];

+ livello rete: trasferisce i pacchetti dal mittente al destinatario;

+ livello trasporto: trasferisce i pacchetti da un host all'altro;

+ livello applicativo: fornisce un'interfaccia per le applicazioni di
  rete

I livelli 1 e 2 sono strettamente legati tra loro, quindi spesso si
considerano come un unico livello chiamato #strong[host-to-network].

Il livello 3 è #strong[privo di connessione]. Ogni pacchetto viene
trattato in modo #strong[indipendente] dagli altri.

Il livello 3 non garantisce affidabilità, ma adotta un approccio
#strong[best effort].

Il livello 4 estende la logica di comunicazione nodo sorgente $arrow.r$
nodo destinazione applicandola ai #strong[processi applicativi] in
esecuzione sugli host. La comunicazione è quindi processo sorgente
$arrow.r$ processo destinazione.

Il livello applicativo utilizza il livello di 4 per realizzare
applicazioni di rete.

Dispositivi di rete diversi implementano livelli diversi dello stack
TCP/IP:

- gli host implementano tutti i livelli;

- gli switch implementano i primi 2 livelli (salvo eccezioni es. switch
  di livello 3);

- i router implementano i primi 3 livelli

= Livello host-to-network (h2n)

Problematiche affrontate:

- #strong[interconnessione] tra due o più host;

- #strong[trasmissione dati] tra host connessi #strong[direttamente];

- #strong[connessione] di un host ad Internet;

Esempi di protocolli di livello 2:

- Ethernet (su LAN wired);

- 802.11a, 802.11b, ecc. (LAN wireless);

- Bluetooth (PAN);

- GSM e LTE per WAN wireless

Protocolli diversi offrono servizi diversi. Non tutti, ad esempio,
garantiscono l'#strong[affidabilità] nella consegna del pacchetto. Il
livello superiore dev'essere in grado di compiere il suo lavoro in
presenza di protocolli diversi a livello h2n.

Il livello h2n ragiona con 2 dispositvi di rete connessi
#strong[direttamente].

L'unità base della comunicazione a questo livello è il #strong[frame].

La comunicazione a questo livello può essere:

- unicast;

- multicast (1 mittente ed un gruppo di destinatari);

- anycast (1 mittente e almeno 1 destinatario all'interno di un gruppo);

- broadcast

I collegamenti tra i nodi possono essere:

- broadcast/condivisi: molti host connessi allo #strong[stesso canale di
  comunicazione]. Tipico delle reti LAN.

  - è necessario un #strong[protocollo di accesso al mezzo] per regolare
    la comunicazione (chi può trasmettere, quando e per quanto tempo) ed
    evitare #strong[collisioni];

- punto-punto: 1 trasmittente ad un'estremità ed 1 ricevente all'altra
  estremità. Tipico collegamento fra un modem d'accesso residenziale e
  il router dell'ISP (Internet Service Provider). \
  I collegamenti punto-punto possono essere a loro volta:

  - half-duplex: si parla uno alla volta. Quasi sempre inteso anche come
    #underline[unidirezionalità] (cioè a parlare è solo 1).

  - full-duplex: entrambi i partecipanti possono comunicare
    contemporaneamente in modo indipendente l'uno dall'altro.

Un protocollo h2n può prevedere più modalità di trasmissione anche se è
stato progettato per un particolare mezzo trasmissivo che è
intrinsecamente broadcast o unicast.

== Tecnologie per interconnessioni

La trasmissione dei dati può essere analogica o digitale.

Mezzi fisici:

- doppino intrecciato: consiste in due fili di rame avvolti a spirale
  regolare. Utilizzato per più di 100 anni in quanto è il mezzo più
  economico;

- cavo di rete: coppie di cavi isolati elettricamente. Consente la
  trasmissione digitale;

- cavo coassiale: utilizzato per avere trasmissioni elettriche di alta
  qualità;

- fibra ottica: trasporta i dati sottoforma di impulsi di luce. Molto
  resistente alle interferenze elettromagnetiche, ma anche molto
  costosa;

I mezzi usati per trasmettere possono essere anche wireless.

== LAN

Una LAN (Local Area Network) è una rete in cui i nodi possono comunicare
tra di loro tramite protocollo di livello h2n.

Una LAN è limitata da 2 fattori:

- #strong[distanza] tra i nodi;

- #strong[numero] di nodi

Questi limiti sono il motivo per cui Internet non è un'unica grande LAN.

Il protocollo h2n è implementato all'interno della #strong[network
interface card] (NIC). Tutti i nodi che fanno parte di una LAN devono
essere dotati di un'interfaccia di rete.

Ethernet è lo standard de-facto per le LAN wired.

=== Topologie di rete

==== Topologia a bus

#figure([#image("images/77950e70c57ad16e17fead51a7c112b3.png")],
  caption: [
    Topologia a bus
  ]
)

Tutti gli host sono collegati tra loro tramite un #strong[singolo cavo]
(detto anche #strong[dorsale]).

I messaggi vengono inviati a tutti gli host, ma vengono accettati solo
dal NIC il cui #strong[MAC address] corrisponde all'indirizzo di
destinazione del messaggio.

Per evitare rimbalzi del segnale elettrico da un capo all'altro del cavo
si applica un #strong[terminatore] a ciascun estremo del cavo.

Se un cavo di collegamento viene tagliato, oppure se si rompe uno dei
terminatori, i dati rimbalzeranno continuamente nella rete rendendola di
fatto inutilizzabile.

==== Topologia ad anello

#figure([#image("images/a8ce85842c75ff2d30e5adcde431f4c3.png")],
  caption: [
    Topologia ad anello
  ]
)

Tutti gli host sono collegati ad un unico cavo circolare.

Anche in questa topologia il segnale elettrico rimbalza all'infinito. Il
terminatore in questo caso è il mittente del messaggio, che si occuperà
di riassorbirlo per liberare la rete.

==== Topologia a stella

#figure([#image("images/0fe8a25fcd900da9bf9f02d36cdad1a9.png")],
  caption: [
    Topologia a stella
  ]
)

Gli host sono connessi da un dispositivo di rete centrale che ha il
compito di inoltrare i messaggi e di evitare i rimbalzi di segnale.

La quasi totalità delle reti Ethernet è ad oggi realizzata con questa
topologia.

Una rete con topologia a stella non ha un #strong[single point of
failure] a livello di rete (se si rompe un cavo che va da un host al
dispositivo centrale, solo quell'host resterà isolato), ma ce l'ha a
livello di dispositivo centrale (se si rompe lui, tutta la rete diventa
inutilizzabile).

Il dispositivo centrale dev'essere opportunamente dimensionato per
gestire il traffico.

== Ethernet

Protocollo h2n nato a metà degli anni '70.

Pensato originariamente per reti con topologia a bus e velocità da 1-10
Mbps. \
Attualmente le reti in cui è utilizzato sono quasi sempre con topologia
a stella e supporta anche diverse velocità, in base all'hardware
utilizzato.

Il supporto di Ethernet a diverse velocità dipende sia dalle interfacce
di rete che dal tipo di collegamenti.

I cavi Ethernet sono raggruppati in diverse categorie. Ad ogni categoria
è associata ad una certa #strong[velocità nominale]. La #strong[velocità
effettiva], oltre che dal cavo, dipende anche dal dispositivo di rete
centrale.

Nelle reti locali #strong[cablate], se progettate con criterio, la
velocità effettiva coincide con quella nominale. Ciò invece non avviene
quasi mai nelle reti wireless.

Ethernet è diventato lo standard de facto per le reti locali per diversi
motivi:

- pensato per reti semplici e poco costose;
- alta flessibilità (si adatta a diverse tipologie e a diversi tipi di
  collegamento);
- si è diffuso talmente tanto e talmente velocemente che i successivi
  \"concorrenti\" hanno avuto molta difficoltà ad affermarsi;
- si integra molto bene con i protocolli IP e TCP

Ethernet utilizza un canale #strong[broadcast]: lo stesso canale è
utilizzato da molti host. Quando un host trasmette un messaggio, tutte
le altre interfacce di rete lo ricevono.

Nonostante il canale sia broadcast, Ethernet permette anche
comunicazioni #strong[unicast]. In generale, i messaggi broadcast sono
riservati a messaggi \"speciali\" (es. ARP).

=== Indirizzi MAC

Ogni interfaccia di rete è identificata univocamente tramite il suo
#strong[MAC address]. Si tratta di un indirizzo incorporato nella ROM
dell'interfaccia di rete.

Il MAC address ha dimensione di #strong[48 bit].

All'interno della stessa rete locale non possono esserci più NIC con lo
stesso MAC address.

L'indirizzo MAC viene detto #strong[flat], perché ogni bit ha lo stesso
peso, indipendentemente dalla sua posizione.

I produttori di schede di rete si registrano alla IEEE e ricevono i
primi 3 byte dell'indirizzo MAC (che identificano quel produttore).

Gli amministratori di sistema possono cambiare il MAC address delle
proprie schede di rete. Il MAC address però non viene cambiato nella ROM
della NIC, ma solo a livello di sistema operativo.

Il protocollo Ethernet non dà nessuna garanzia sul fatto che gli indizzi
MAC non siano stati modificati, nè che siano effettivamente univoci
all'interno della stessa rete.

L'indirizzo MAC `FF:FF:FF:FF:FF:FF` è l'indirizzo di broadcast. Non è
possibile configurare questo indirizzo come MAC address della propria
interfaccia di rete.

Quando un host A vuole comunicare con un host B, entrambi nella stessa
rete locale, A inserirà nel frame Ethernet:

- il suo MAC address come indirizzo sorgente;

- il MAC address di B come indirizzo di destinazione

Questo frame viene poi inviato a #strong[tutti] gli host presenti sulla
rete, ma sarà scartato da tutte le interfacce di rete il cui MAC address
è diverso dal MAC address destinazione riportato sul frame.

Il frame NON viene scartato solo se:

- il MAC address destinazione riportato è quello di broadacst;

- l'interfaccia di rete che riceve il pacchetto è in #strong[modalità
  promiscua], cioè accetta tutti i pacchetti indipendentemente da MAC
  address destinazione (es. se è in esecuzione `tcpdump`)

==== Perché serve il MAC address

Se le schede di rete utilizzassero indirizzi IP:

- non sarebbero in grado di supportare protocolli diversi da IP;

- dovrebbero essere ri-configurate tutte le volte che l'host viene
  spostato, in modo che l'IP sia sempre salvato nella ROM della NIC

Allo stesso tempo, i NIC non possono non avere un indirizzo proprio
perché altrimenti il sistema operativo verrebbe continuamente interrotto
da ogni pacchetto in transito nella LAN, anche se non diretto a loro.

=== Struttura del frame Ethernet

#figure([#image("images/048b2039b2c8ea71f8c7880b8192945c.png")],
  caption: [
    Frame Ethernet
  ]
)

==== Preamble e SFD - 8 byte

Informazioni necessarie per far funzionare correttamente le interfacce
di rete.

I primi 7 byte sono sempre `10101010`, mentre gli ultimi 2 byte sono
identici ma terminano entrambi per `11`.

L'interfaccia di rete utilizza il preambolo per #strong[sincronizzarsi]:

- i primi 7 byte \"svegliano\" l'interfaccia di rete

- gli ultimi due bit `11` indicano alla scheda che la sincronizzazione è
  terminata e che sta arrivando il contenuto del frame

Di solito il preambolo non viene comunicato al sistema operativo, perché
si tratta di informazioni che hanno senso solo a livello fisico.

Il preambolo, assieme al CRC, serve per il #strong[framing] di Ethernet.
Il framing serve per capire dove comincia e dove finisce un singolo
frame Ethernet.

==== Indirizzo MAC destinazione e sorgente - 6 byte a testa

L'indirizzo del destinatario compare prima rispetto a quello sorgente
perché è il primo indirizzo ad essere controllato dalle schede di rete.

L'indirizzo sorgente ha poca utilità a livello h2n (Ethernet utilizza un
canale broadcast), ma può essere utile a protocolli di livello superiore
per capire a chi rispondere.

==== Tipo - 2 byte

Serve per implementare il #strong[multiplexing], nel senso che si
possono inserire contenuti diversi nel payload ed il destinatario sarà
in grado di interpretarli in base al loro tipo.

==== Payload - da 46 a 1.500 byte

Informazioni che non vengono gestite dal protocollo Ethernet, ma vengono
semplicemente passate ai livelli superiori dello stack.

=== CRC - controllo di ridondanza ciclico - 4 byte

Utilizzato, assieme al preambolo, per il #strong[framing] di Ethernet.

Il protocollo Ethernet è l'unico che aggiunge un \"header\" in coda al
pacchetto.

Il CRC è un'informazione che serve per il #strong[controllo d'integrità]
del pacchetto.

Il CRC viene calcolato sulla base di #strong[tutte] le informazioni del
pacchetto (sia header che dati), ad eccezione del preambolo e del campo
CRC stesso.

Anche il CRC di solito non viene inviato al sistema operativo.

Il CRC è molto facile da calcolare a livello hardware (è la scheda di
rete che implementa l'algoritmo). Questo è il motivo per cui si è scelto
quest'algoritmo invece di altri (es. hashing) per il controllo
dell'integrità.

=== Dimensioni del frame Ethernet

Dimensione minima: 46 byte. Se il frame è più piccolo, esiste una logica
di #strong[stuffing] che va ad inserire informazioni fittizie
all'interno del frame fino a raggiungere la dimensione minima.

Dimensione #strong[massima] (#strong[MTU], Maximum Transfer Unit): 1.500
byte. La dimensione massima è definita dall'interfaccia di rete.

L'amministratore di sistema può cambiare l'MTU della propria interfaccia
di rete, ma non può cambiare la dimensione minima del frame.

Tutte le interfacce di rete collegate alla stessa rete devono avere lo
stesso MTU.

=== Protocollo ARP

Problema: come fa il mittente a conoscere il MAC address della scheda di
rete con cui vuole comunicare?

Risposta: protocollo ARP.

L'#strong[Address Resolution Protocol] (ARP) si occupa di individuare il
MAC address di un host sulla stessa LAN conoscendo il suo indirizzo IP.

Il protocollo ARP utilizza 2 tipi di messaggio:

- #strong[richiesta]: contiene l'indirizzo IP del destinatario;

- #strong[risposta]: contiene il MAC address corrispondente a
  quell'indirizzo IP

La richiesta è broadcast, mentre la risposta è unicast.

Il fatto che Ethernet si basi su ARP, che invia messaggi broadcast,
rende Ethernet #strong[poco scalabile].

Per migliorare le prestazioni di ARP, ogni host conserva una
#strong[cache ARP]. Ogni entry di questa cache è associata ad un TTL.

La cache ARP è gestita dal sistema operativo e può essere manipolata
dall'amministratore, ad esempio per inserire entry permanenti (i.e. con
TTL infinito).

=== Protocollo RARP

È l'opposto di ARP: da un indirizzo MAC restituisce l'indirizzo IP.

Il protocollo RARP è ormai deprecato (in generale è stato utilizzato
pochissimo) in favore di #strong[DHCP].

=== Protocollo CSMA/CD

Legato alla #strong[trasmissione fisica] dei frame Ethernet sulla rete.

Serve per #strong[rilevare le collisioni] all'interno di una rete
Ethernet.

È un #strong[protocollo di accesso al mezzo], cioè regola come i vari
host possono accedere ed utilizzare il canale di comunicazione condiviso
che Ethernet mette a disposizione.

Il protocollo WiFi, a differenza di Ethernet, non deve solo rilevare le
collisioni ma deve cercare di #strong[evitarle] proprio. Questo perché
le collisioni su rete cablata non sono molto frequenti, e se capitano
non hanno conseguenze gravi, mentre nelle reti wireless la situazione è
diversa.

Quando un host deve trasmettere un frame, l'interfaccia di rete
#strong[ascolta] e cerca di capire se c'è qualcun altro che sta
trasmettendo in quel momento. Se la rete è libera, allora l'interfaccia
provvederà ad inviare il frame #strong[alla massima velocità possibile].

Il tempo durante il quale l'interfaccia di rete \"ascolta\" prima di
inviare un frame è detto #strong[Inter Frame Gap] (IFG). Due frame
consecutivi vengono sempre distanziati da questo IFG.

Anche con questo meccanismo di \"ascolto\" possono esserci comunque
delle collisioni, es. a causa della latenza del mezzo fisico.

L'interfaccia di rete non \"ascolta\" solo prima di trasmettere il
messaggio, ma anche #strong[durante e dopo] averlo trasmesso (concetto
di #strong[listen while talking]). Se, dopo aver inviato il messaggio,
l'interfaccia di rete non rileva il segnale che si aspetta, allora
assume che ci sia stata una collisione.

Quando viene rilevata una collisione:

- ogni host #strong[smette di trasmettere] e segnala a tutti gli altri
  che c'è una collisione, inviando un messaggio di #strong[jamming];

- tutti gli host che ricevono un messaggio di jamming si mettono \"in
  pausa\";

- gli host riprendono a trasmettere, ciascuno con un #strong[ritardo
  pseudo-casuale], in modo da non ritrovarsi nuovamente a trasmettere i
  dati tutti nello stesso istante

Il ritardo dopo il quale gli host cominciano a ritrasmettere è calcolato
tramite un algoritmo di #strong[exponential back-off]:
l'#strong[ampiezza dell'intervallo] dal quale si sceglie il ritardo
aumenta esponenzialmente all'aumentare del numero di collisioni
rilevate.

Se dopo 16 tentativi si continua a rilevare una collisione, allora si
smette di trasmettere in quanto si suppone che nella rete ci sia un
problema più grave.

=== Dispositivi di rete

==== Hub

#strong[Ripetitore di segnale]: ripete il segnale ricevuto in ingresso
su una porta su tutte le altre porte.

È un dispositivo di livello 1 perché ragiona solo a livello di segnale
elettrico. Non fa nessun ragionamento sul frame Ethernet, sui pacchetti,
ecc.

Gli hub consentono in un certo senso di #strong[aumentare la distanza]
tra due host: se un filo host $arrow.l.r$ host è troppo lungo, si può
mettere un hub in mezzo ed usare due fili lunghi la metà tra host e hub.

Dal punto di vista del traffico, una LAN collegata mediante un hub è
equivalente ad una topologia a bus, con l'eccezione che guasti su una
singola porta dell'hub non si riflettono sulle altre porte.

Come nelle reti con topologia a bus, gli hub ripetono anche le
collisioni (si dice che non hanno un #strong[dominio di collisione]
differente per ogni porta). In generale, gli hub non sono nemmeno in
grado di rilevare le collisioni.

==== Switch

Dispositivo di livello 2 che implementa funzionalità di #strong[inoltro
selettivo] dei frame: anziché essere dei meri ripetitori come gli hub,
gli switch inoltrano il frame solo all'effettivo destinatario.

Lo switch utilizza il protocollo CSMA/CD per trasmettere i frame sulla
LAN.

Gli switch #underline[isolano i domini di collisione], permettendo di
avere più traffico gestibile all'interno della stessa rete.

Gli switch sono dispositivi #strong[store and forward]:

+ salvano il frame in entrata;

+ lo analizzano;

+ lo inoltrano al destinatario

==== Logica di inoltro selettivo

Lo switch è un dispositivo che #strong[autoapprende] la configurazione
della rete, #strong[analizzando il traffico].

Lo switch costruisce una #strong[tabella di inoltro] che mappa
l'indirizzo MAC con la porta dello switch a cui quel MAC address è
collegato.

Ogni riga di questa tabella contiene anche un TTL. Se lo switch non
riceve più messaggi da un host dopo il relativo TTL, quell'host viene
rimosso dalla tabella.

La tabella di inoltro viene riempita leggendo il MAC address
#strong[sorgente].

Se uno switch riceve un frame Ethernet destinato ad un indirizzo che non
è nella tabella, lo switch inoltra quel frame #strong[in broadcast].

Se la tabella è piena è il MAC destinazione non è nella tabella, lo
switch inoltrerà il frame in broadcast.

Lo switch è un dispositivo #strong[trasparente] agli host a lui
collegati: anche se è lo switch ad instradare i pacchetti nella LAN, gli
host devono implementare il protocollo ARP.

Oltre all'inoltro, lo switch si occupa anche di #strong[filtrare] i
pacchetti, in particolare:

- elimina i frame che non sono destinati alla stessa LAN;

- elimina i frame con CRC non valido

==== Switch cut through

Gli switch cut through iniziano a leggere il frame nel momento in cui
gli arriva e procedono con l'inoltro appena finiscono di leggere il MAC
address di destinazione.

Sono utilizzati in reti ad altissime prestazioni.

Il fatto di non leggere tutto il frame comporta degli svantaggi, ad
esempio non possono fare il controllo del CRC.

=== Bridge

Simile allo switch (funziona con logica di inoltro selettivo), ma può
supportare più mezzi fisici, anche diversi tra loro, e protocolli
diversi.

Un bridge è #strong[trasparente] se mette in comunicazione 2 dispositivi
che usano dei protocolli h2n differenti ma che impiegano lo stesso
sistema di indirizzamento di livello 2 (esempio Ethernet e WiFi,
entrambi utilizzano il MAC address come sistema di indirizzamento).

Lo switch può essere visto come un bridge trasparente.

Esistono anche bridge #strong[non trasparenti] quando eseguono delle
trasformazioni sui frame per \"tradurli\" da un protocollo all'altro.

=== Interconnessione di LAN

Una LAN Ethernet è limitata:

- geograficamente: la lunghezza massima del cavo Ethernet (e quindi la
  distanza massima tra due host) è definita dallo standard 802.3;

- nel numero massimo di host collegabili: per il funzionamento di ARP,
  all'aumentare del numero di nodi le prestazioni della rete calano
  drasticamente a causa del traffico generato dai messaggi broadcast

Connettendo più switch tra loro si possono formare delle #strong[reti
gerarchiche] e geograficamente più estese.

Per aumentare l'affidabilità della rete, è necessario avere della
#strong[ridondanza], ovvero dei #strong[cammini alternativi] tra
sorgente e destinazione.

#figure([#image("images/a8f566c3fed7b37dbd3099e4d7c16214.png")],
  caption: [
    Collegamenti ridondanti
  ]
)

Problema: se ci sono dei #strong[cicli] all'interno della rete, i
messaggi di broadcast vengono inoltrati all'infinito.

Ethernet non gestisce la presenza di cicli all'interno della rete.

È necessario inserire delle logiche aggiuntive per fare in modo che i
percorsi ridondanti siano disabilitati #strong[selettivamente] (cioè
vengono attivati solo quando servono). Per fare ciò si usa lo
#strong[spanning tree protocol].

Lo spanning tree protocol permette agli switch di rilevare
#strong[automaticamente] e #strong[dinamicamente] i link ridondanti.

Per funzionare, lo spanning tree protocol dev'essere attivo su tutti gli
switch della rete interessata.

Quando l'STP viene abilitato, gli switch generano traffico broadcast per
rilevare i link ridondanti.

I percorsi ridondanti quindi non si possono usare per aumentare le
performance, perché l'STP li va a disabilitare.

L'STP è in grado di attivare e disattivare i link ridondanti in modo
#strong[dinamico].

=== VLAN

Una LAN normale permette soltanto di raggruppare gli host
#strong[fisicamente].

Una VLAN invece permette di raggruppare gli host #strong[logicamente],
lasciando invariata la topologia fisica della rete.

La comunicazione a livello H2N è impedita tra VLAN diverse.

Il traffico broadcast è limitato agli host della stessa VLAN. Creare una
nuova VLAN equivale quindi a creare un nuovo dominio di broadcast.

Su un #strong[bridge VLAN-aware] possono essere configurate delle
#strong[access list] che definiscono quali porte possono
inviare/ricevere frame da/verso le varie VLAN.

I collegamenti degli host al bridge possono essere di 3 tipi:

- #strong[access link]: usato da dispositivi VLAN-unaware. Tagging e
  untagging vengono eseguiti trasparentemente dal bridge;

- #strong[trunk link]: usato da dispositivi VLAN-aware. Il bridge non
  gestisce più il tagging, è compito degli host;

- #strong[hybrid link]: collegamento con il quale possono essere
  connessi entrambi i tipi di dispositivi

Le VLAN sono definite nello standard #strong[IEEE 802.1q]. Questo
protocollo non incapsula il frame Ethernet, ma aggiunge ad esso un nuovo
campo di 12 bit in cui si trova il VLAN ID.

Il campo #strong[type] del frame Ethernet, nel caso di frame 802.1q,
viene impostato al valore `0x8100` per distinguerlo da un normale frame
Ethernet.

== Cablaggio strutturato

Insieme di normative che definiscono come organizzare fisicamente i link
di una rete (i.e. come mettere i cavi).

== Interconnessioni di reti ed accesso ad Internet

L'obiettivo di Internet è quello di connettere tra loro reti
#strong[indipendenti] ed #strong[eterogenee].

Internet dev'essere gestito in maniera #strong[decentralizzata].

Internet è organizzato in maniera #strong[gerarchica]:

+ gli utenti finali sono collegati ad ISP #strong[locali];

+ gli ISP locali sono collegati ad ISP #strong[regionali] (o nazionali);

+ gli ISP regionali sono collegati ad ISP #strong[internazionali], detti
  anche National Backbone Provider (NBP) o National Service Provider
  (NSP)

Gli utenti si collegano agli ISP locali tramite dei #strong[points of
presence] (POP) messi a disposizione dall'ISP stesso.

Gli ISP locali si connettono agli ISP regionali tramite i
#strong[network access points], messi a disposizione dagli ISP
regionali.

A loro volta, gli ISP regionali noleggiano accesso ai provider
intercontinentali.

Un #strong[autonomous system] (AS) è un'#strong[entità legale] che
gestisce una \"fetta\" di Internet, ovvero un insieme di:

- reti;

- indirizzi IP;

- router

Dal punto di vista organizzativo, Internet è un insieme di autonomous
system.

Gli autonomous system sono entità #strong[indipendenti] l'una
dall'altra. Non c'è un AS in particolare che \"prevale\" sugli altri
(anzi, tipicamente un AS arriva a controllare non più del 5% di tutta la
rete Internet).

Un esempio di autonomous system in Italia è il #strong[GARR], un AS che
collega tra loro varie università (tra cui Unimore) e centri di ricerca
con lo scopo di agevolare la condivisione di informazioni.

Ogni ISP locale possiede:

- dei nodi #strong[permanentemente connessi] ad Internet;

- delle centraline, sparse per tutto il territorio, per il
  #strong[collegamento dell'ultimo miglio] (dall'ISP all'utente finale)

Ogni utenza di un ISP possiede:

- un dispositivo di rete (router, moden) che permette di collegarsi
  #strong[a livello h2n] alla centralina dell'ISP;

- uno (o pochi) indirizzi IP #strong[pubblici] per l'accesso ad Internet

Il collegamento tra utente ed ISP locale può essere analogico o
digitale. Il #strong[modem] è il dispositivo che si occupa di
trasformare il segnale da digitale ad analogico e viceversa.

Gli accessi residenziali cablati sono prevalentemente di tipo
#strong[point-to-point].

Esistono diverse modalità di collegamento tra utente ed ISP:

- xDSL (analogico);

- fibra ottica (digitale);

- tecnologie cellulari o satellitari

Il collegamento tra utente ed ISP viene gestito con il
#strong[point-to-point protocol] (PPP).

=== Point-to-point protocol (PPP)

Il PPP gestisce #strong[collegamenti punto-punto].

Il PPP non necessita di:

- media access control, perché il canale non è condiviso;

- indirizzi MAC, peché ci sono soltanto 2 interlocutori (quindi è
  immediato capire chi è l'altro)

Funzionalità di PPP:

- supporto a protocolli diversi tramite tecniche di
  #strong[incapsulamento];

- supporto all'#strong[autenticazione];

- supporto alla #strong[rilevazione] degli errori (ma non alla
  correzione);

- supporto all'assegnazione #strong[dinamica] degli indirizzi IP da
  parte dell'ISP

Prevede due sotto-protocolli:

- #strong[LCP] (link control protocol): protocollo che serve per
  stabilire, configurare e monitorare la connessione PPP;

- #strong[NCP] (network control protocol): configurazione dei diversi
  protocolli a livello 3

Uno dei principi del PPP è la #strong[connection liveliness]: PPP riesce
a rilevare il corretto funzionamento delle comunicazioni e può segnalare
errori in merito.

Opzionalmente, il PPP può prevedere anche funzionalità per la
#strong[cifratura] dei dati e di #strong[correzione] degli errori
(eventualmente tramite #strong[ritrasmissione automatica]).

PPP è #strong[orientato alla connessione].

5 fasi di PPP:

+ definizione della connessione (negoziazione della #strong[velocità]
  della connessione, definizione della modalità di connessione, ecc.);

+ #strong[autenticazione] (opzionale a seconda dei contesti);

+ configurazione del protocollo di rete utilizzato (es. IP);

+ comunicazione;

+ #strong[chiusura] della connessione, con relativo scambio di messaggi

PPP è pensato per funzionare su mezzi full-duplex. Per questo non si
preoccupa di eventuali conflitti. \
Volendo si può usare PPP anche su mezzi half-duplex.

=== Struttura del frame PPP

#figure([#image("images/535207b7d63e840f93217589ab43e088.png")],
  caption: [
    Frame PPP
  ]
)

- il campo #strong[flag] delimita il frame;

- il campo #strong[protocol] contiene il protocollo utilizzato a livello
  3;

- il campo #strong[info] contiene il payload;

==== Byte stuffing

Concetto che permette di implementare il #strong[framing] di PPP e di
\"escapare\" sequenze di bit che altrimenti verrebbero interpretate come
delimitatori di frame.

- il mittente aggiunge un byte extra `01111110` prima di ogni byte
  `01111110` all'interno del campo `info`;

- il destinatario, se trova due byte `01111110` consecutivi scarta il 1°
  e considera il 2° come dato, continuando la lettura del frame. Se
  invece trova un solo byte `01111110` lo considera come terminatore del
  frame

= Livello network

Il livello rete è quello che definisce la rete Internet stessa.

Il protocollo IP è stato pubblicato dalla IETF nel 1981. Inizialmente è
stato pensato per reti con 4 dispositivi, ad oggi siamo a più di 5
miliardi di dispositivi connessi.

Il protocollo IP è stato pensato proprio per essere molto
#strong[scalabile].

La parte legata all'#strong[indirizzamento] e
all'#strong[identificazione] di questi dispositivi è fondamentale nel
livello 3.

== Definizione di Internet

Ci sono più definizioni, a seconda dei punti di vista:

- per le applicazioni di rete, Internet è un'entità #strong[trasparente]
  che permette a due applicazioni di comunicare tra loro;

- dal punto di vista fisico, Internet è un insimeme di componenti (host,
  link, router) in cui ciascun nodo è identificato da un
  #strong[indirizzo IP];

- dal punto di vista funzionale, Internet è una rete operante mediante
  #strong[packet switching], con intelligenza sugli end point e non sui
  nodi intermedi;

- dal punto di vista organizzativo:

  - per i router è un insieme di #strong[autonomous system];

  - per gli host è un insieme di #strong[nomi e domini] (DNS)

== Principi base di Internet

- #strong[survivability]: la comunicazione deve funzionare finché c'è un
  collegamento funzionante tra mittente e destinatario. A differenza di
  Ethernet (vedi spanning tree protocol), a livello 3 si cerca di far
  funzionare #strong[tutti] i link;

- struttura #strong[a clessidra], in modo da poter funzionare per tutti
  i tipi di applicazioni di rete;

- #strong[stateless]: i router non memorizzano alcuno stato,
  l'intelligenza sta ai bordi della rete;

- #strong[net neutrality]: ogni pacchetto è trattato allo stesso modo,
  indipendentemente da chi siano mittente e destinatario;

- ogni rete è potenzialmente gestita da un ente diverso (autonomous
  system)

== Funzioni del livello network

- si garantisce l'#strong[indirizzamento univoco] degli host. Tutti gli
  host connessi ad Internet devono essere identificati in modo univoco
  tramite un #strong[indirizzo IP];

- si definisce l'unità di trasferimento dei dati (#strong[datagram IP]);

- si definisce l'architettura di Internet (router e autonomous system);

- si illustrano le diverse funzioni di routing

IP adotta una logica di tipo #strong[best-effort]. Non è un protocollo
affidabile:

- non garantisce la consegna del datagram;

- in caso di mancata consegna, non garantisce nemmeno che ci sia un
  qualche feedback

== Router

I router sono fondamentali per il funzionamento del protocollo IP. Si
occupano di #strong[instradare] i pacchetti IP nella rete sulla base
dell'indirizzo IP di #strong[destinazione].

L'instradamento dei pacchetti avviene #strong[hop-by-hop].

- il 1° router viene chiamato #strong[source router] (o first hop
  router);

- l'ultimo router viene chiamato #strong[destination router]

Il protocollo usato a livello 2 potrebbe cambiare ad ogni hop, ma il
protocollo IP resta sempre lo stesso.

Un router può decidere di scartare un pacchetto se:

- il router è sovraccarico e non può gestire altri pacchetti
  (congestione nella rete);

- scade il TTL;

- ci sono errori logici (es. cicli nella rete, errori di routing, ecc.)

Un router accetta pacchetti IP anche se l'IP di destinazione non è il
suo. Si tratta di una caratteristica fondamentale che distingue un
router da un host.

=== Routing

Quando un router riceve un pacchetto IP:

- determina il #strong[net ID] leggendo l'IP destinazione;

- se il net ID corrisponde ad una rete collegata direttamente al router
  (caso in cui il router è il #strong[destination router]), si procede
  con l'inoltro del pacchetto via Ethernet all'host di destinazione,
  altrimenti:

  - se nella #strong[tabella di routing] esiste un router per quel net
    ID, si procede con l'inoltro del pacchetto a quel router, altrimenti

  - se esiste un router di default, il pacchetto viene inoltrato al
    router di default;

  - se non esiste nemmeno un router di default, viene generato un errore
    di routing e il pacchetto viene scartato

Il problema del routing viene scomposto in 2 sotto-problemi:

- #strong[IP forwarding]: determinare il next hop router a partire dal
  net ID;

- mantenere le #strong[tabelle di routing], indispensabili per far
  funzionare l'IP forwarding

#block[
I protocolli di routing servono per mantenere le tabelle di routing.

È l'IP forwarding che decide poi come inoltrare i pacchetti nella rete,
non i protocolli di routing.

]
Affinché il routing funzioni, la tabella di routing deve contenere tutte
le informazioni necessarie per poter raggiungere #strong[qualsiasi]
destinatario.

Le tabelle di routing esistono anche sugli host. Si tratta quindi di
tabelle gestite in modo autonomo da qualunque dispositivo che vuole
comunicare a livello IP.

I protocolli di routing vengono eseguiti #strong[continuativamente] per
capire se la tabella di routing è ancora valida (cioè se è ancora la
migliore) o se è necessario aggiustarla perché sono cambiate le
condizioni della rete (es. è saltato un collegamento).

==== Tabella di routing

La tabella di routing può essere popolata:

- #strong[staticamente] dall'amministratore di rete o da vari protocolli
  di configurazione (es. DHCP); caso più comune nel caso di router e
  host in reti locali molto semplici;

- #strong[dinamicamente] tramite protocolli di routing (es. RIP, OSPF,
  BGP)

=== Architettura di un router

#figure([#image("images/cd8f2cb1c236f94eccb4cda2f0140128.png")],
  caption: [
    Architettura di un router
  ]
)

- le interfacce d'ingresso (#strong[input port]) e di uscita
  (#strong[output port]) sono a loro volta composte da:

  - parte fisica (livello 1);

  - parte rete (livello 2);

  - parte IP (livello 3)

- #strong[switching]: architettura hardware che collega le porte
  d'ingresso con quelle di uscita;

- #strong[routing processor]: conserva la tabella di routing e
  implementa l'IP forwarding

Ogni porta d'ingresso e di uscita gestisce un #strong[buffer] di
pacchetti. La congestione in un router avviene quando uno di questi
buffer è pieno.

La logica di switching si occupa di copiare i pacchetti dalla coda
d'ingresso alla coda d'uscita.

== Struttura di un indirizzo IP

Dimensione:

- #strong[4 byte] per IPv4;

- #strong[16 byte] per IPv6

Gli indirizzi IP hanno una struttura gerarchica (non sono flat come i
MAC address). Ogni indirizzo IP è composto da #strong[net ID] ed
#strong[host ID].

La dimensione dei due campi dipende dalla #strong[classe] dell'indirizzo
IP.

#align(center)[#table(
  columns: 3,
  align: (col, row) => (center,center,center,).at(col),
  inset: 6pt,
  [classe], [range IP], [net ID - host ID],
  [A],
  [0.1.0.0 - 127.255.255.255],
  [8 - 24],
  [B],
  [128.0.0.0 - 191.255.255.255],
  [16 - 16],
  [C],
  [192.0.0.0 - 223.255.255.255],
  [24 - 8],
  [D],
  [224.0.0.0 - 239.255.255.255],
  [N/A],
  [E],
  [240.0.0.0 - 255.255.255.254],
  [N/A],
)
#align(center, [Classi IP di default])
]

L'approccio moderno è quello #strong[classless], che permette una
maggiore flessibilità. La classe a cui l'indirizzo appartiene non è più
auto-dichiarata dall'indirizzo stesso, ma è definita dalla
#strong[netmask].

La #strong[notazione CIDR] permette di esprimere in maniera compatta
indirizzo IP e netmask (es. `192.168.1.5/24`).

La principale scomodita dell'approccio classful è che si passa da reti
molto grandi a reti molto piccole, senza vie di mezzo (es. da una rete
con classe A da 16.777.214 host ad una rete di classe B con 65.534
host).

Tuttavia l'approccio classful è molto efficiente per la consultazione
delle tabelle di routing (perché non c'è da gestire una netmask). Si è
però preferito puntare alla flessibilità e quindi è stato scelto un
approccio classless.

=== Indirizzi IP riservati

- 0.0.0.0;

- 127.0.0.0/8 (127.0.0.0 - 127.255.255.255), usato da applicazioni
  locali agli host;

- 224.0.0.0/3 (tutti quelli delle classi D ed E);

- 255.255.255.255 (broadcast address)

=== Indirizzi IP privati

Chiamati anche #strong[non routable IP addresses] perché i router
scartano tutti i pacchetti che contengono uno di questi IP come IP
destinazione.

- 10.0.0.0/8;

- 172.16.0.0/12;

- 192.168.0.0/16;

== Gestione degli indirizzi IP

La #strong[IANA] (Internet Assigned Number Authority) si occupa di
gestire gli indirizzi IP.

La IANA fa parte dell'associazione #strong[ICANN] (Internet Corporation
for Assigned Names and Numbers).

La gestione degli indirizzi IP è gerarchica:

- la IANA assegna dei blocchi di indirizzi IP ai #strong[RIR] (Regional
  Internet Registry), che li gestiscono a livello
  regionale/continentale;

- i RIR assegnano dei sotto-blocchi di indirizzi IP ai #strong[LIR]
  (Local Internet Registry), che li gestiscono a livello locale;

- infine gli ISP (istanza di LIR) assegnano un indirizzo IP a noi utenti
  finali

Per risalire all'area geografica di appartenenza di un indirizzo IP è
sufficiente controllare qual è il LIR/RIR che lo gestisce.

L'#strong[IETF] (Internet Engineering Task Force) si occupa valutare gli
#strong[RFC] (Request For Comment) per definire gli standard di
Internet.

Gli #strong[RFC] sono dei documenti che definiscono gli \"standard di
Internet\". Si chiamano in questo modo perché venivano creati dai
pionieri di Internet per chiedere feedback ai loro colleghi.

== Subnetting e supernetting

- subnetting: da una rete grande se ne creano tante più piccole;

- supernetting: si \"uniscono\" tante reti piccole in un'unica rete più
  grande

Il subnetting viene fatto per #strong[segmentare] logicamente una rete
più grande.

Il supernetting viene fatto per ridurre il numero di regole di routing e
può essere fatto solo se le reti sono #strong[adiacenti in senso
binario].

In entrambi i casi si lavora sulla #strong[netmask].

== Datagram IP (aka pacchetto IP)

#figure([#image("images/fb5b797fe103c38be91a86f9ec66daf3.png")],
  caption: [
    Datagram IP
  ]
)

La dimensione massima del pacchetto IP è di #strong[64 KB].

=== VERS

Versione del protocollo IP usata dal pacchetto (v4 o v6).

=== HLEN

Dimensione dell'header del pacchetto.

Questo campo serve perché in IPv4 la dimensione dell'header è
#strong[variabile]. In particolare è variabile il numero di estensioni
inserite nel campo IP OPTIONS.

La dimensione dell'header viene indicata in #strong[WORD], ovvero in
blocchi da 4 byte (guardando la figura, un blocco di 4 byte corrisponde
ad 1 riga)-

Se il campo IP OPTIONS è vuoto, HLEN vale 5.

=== TYPE OF SERVICE (TOS)

Originariamente conteneva informazioni sulle prestazioni richieste dal
pacchetto (es. bassa latenza).

Oggi la struttura del campo è cambiata ed è diviso in 2 sotto-campi:

- #strong[DSCP]: identifica delle #strong[classi di traffico] del
  pacchetto (campo usato da protocolli real-time es. VoIP);

- #strong[ECN]: utilizzato dai router per segnalare informazioni
  riguardo al proprio stato di congestione

=== TOTAL LENGTH

Dimensione totale (header + dati) del pacchetto.

=== IDENTIFICATION, FLAGS e FRAGMENT OFFSET

Campi per gestire la #strong[frammentazione] di IP:

- il campo #strong[IDENTIFICATION] marca tutti i frammenti che fanno
  parte dello stesso pacchetto;

- il campo #strong[FLAGS] è una bitmask che indica, tra le altre cose,
  se il pacchetto è stato frammentato;

La frammentazione serve per poter inviare pacchetti IP grandi fino a 64
KB tramite interfacce di rete che hanno una MTU molto più piccola
(massimo 1.500 byte).

La gestione della frammentazione in IP è piuttosto complessa. Il
pacchetto può essere frammentato più volte ed in punti diversi. \
A causa di questa complessità, il protocollo TCP cerca di implementare
lui la frammentazione a livello 4 in modo da non doverla gestire a
livello 3.

==== Note sulla frammentazione dei pacchetti

Nel caso più semplice, è il livello 3 di un host a chiedere al livello 2
il suo MTU per decidere se e come frammentare il pacchetto.

Non sempre però si ha questa situazione: il pacchetto potrebbe essere
frammentato durante il suo percorso (anche più di una volta), perché
potrebbe attraversare reti con MTU differente.

Gestire la frammentazione sui router ne peggiora le prestazioni. Per
questo motivo negli ultimi tempi si è deciso di scartare i pacchetti
piuttosto che frammentarli. La frammentazione quindi deve essere gestita
dagli host.

Se un router scarta un pacchetto perché la sua dimensione è maggiore
dell'MTU dell'interfaccia di rete verso cui inoltrarlo, esso è tenuto da
inviare un messaggio ICMP al mittente per informarlo. \
Sarà poi compito del mittente ri-trasmettere il pacchetto, avendo cura
di frammentarlo opportunamente.

Siccome il pacchetto può attraversare diversi router prima di arrivare a
destinazione, può capitare anche che venga scartato più di una volta da
router diversi, e quindi dev'essere continuamente ri-trasmesso dal
mittente in frammenti sempre più piccoli.

Questa logica con cui si scopre l'MTU delle reti tramite questi messaggi
d'errore inviati dai router si chiama #strong[path MTU discovery].

=== TIME TO LIVE (TTL)

#strong[Contatore] del numero di hop che il pacchetto può ancora
attraversare prima di dover essere scartato.

Ogni volta che il pacchetto attraversa un router, questi prima di
processarlo diminuisce di 1 il valore del suo TTL.

- se il TTL è ancora $gt.eq$ 1, il router procederà con l'IP forwarding;

- se il TTL è $eq$ 0, il router scarterà il pacchetto

Il TTL serve per evitare che un pacchetto possa circolare all'infinito
nella rete.

Il TTL viene impostato dal sistema operativo. SO diversi potrebbero
impostare TTL diversi.

Generalmente il valore iniziale del TTL non è mai molto grande, perché
se la rete è configurata opportunamente il numero di hop è piuttosto
basso.

=== PROTOCOL

Informazioni sul protocollo contenuto a livello dati (es. ICMP, TCP,
UDP, ecc.).

=== HEADER CHECKSUM

Campo usato per il controllo di integrità.

A differenza di Ethernet, in IP il controllo d'integrità è fatto
#strong[solo sugli header] (ad eccezione del TTL, perché se si
includesse bisognerebbe ricalcolare il checksum ad ogni hop).

== Autonomous system

Ogni AS:

- gestisce in modo #strong[autonomo ed esclusivo] uno o più blochi di
  indirizzi IP;

- riesce a mettere in comunicazione due dispositivi connessi a reti
  sotto il proprio controllo senza dover passare per altri AS

Ogni AS è identificato da un #strong[numero intero univoco] che gli
viene assegnato dalla IANA.

L'organizzazione di Internet si può considerare a 2 livelli:

- livello di gestione #strong[interno] ad ogni autonomous system;

- livello di gestione tra autonomous system #strong[differenti]

Si parla di #strong[interior routing] quando il routing coinvolge
#strong[un solo AS], altrimenti si parla di #strong[exterior routing].

Nessun AS può gestire più del #strong[5%] del traffico. Nella pratica,
la stragrande maggioranza degli AS gestisce molto meno dell'#strong[1%]
di tutto il traffico di Internet.

=== Interconnessioni tra autonomous system

Due AS possono essere collegati tra loro in 2 modi:

- peering point: collegamento #underline[il più semplice possibile] tra
  due AS. Viene fatto a seguito di un #strong[accordo privato] tra i due
  AS;

- Internet Exchange point: infrastruttura più complessa che viene
  gestita da un'#strong[entità terza]

Utilizzando un IXP è possibile applicare delle regole particolari per la
gestione e/o il monitoraggio del traffico.

La gestione del traffico di Internet è un #strong[costo] per gli AS. Un
AS può decidere di farsi pagare il \"pedaggio\" da un altro AS se questi
vuole inoltrare traffico attraverso la propria rete.

Dal punto di vista tecnico, un AS \"finisce\" in presenza di un peering
point o di un IXP.

Gli IXP di solito sono posti agli estremi di AS che gestiscono
#strong[reti molto grandi] (es. nazionali). I collegamenti tra AS più
piccoli invece sono realizzati tramite peering point.

=== Tipologie di AS

- #strong[stub]: AS che ha #strong[una sola connessione] verso un altro
  AS. Caso tipico degli ISP locali. Per questi AS non c'è bisogno di un
  vero e proprio algoritmo di routing (non c'è molta scelta sulla strada
  verso la quale inoltrare i pacchetti);

- #strong[multi-homed]: molto simile allo stub, ma può essere collegato
  a più di un AS. Questo tipo di AS #strong[non permette] a traffico non
  generato da lui di transitare sulla propria rete;

- #strong[transit]: sono collegati ad altri AS e permettono il transito
  al traffico che non è diretto a loro o che non è stato generato da
  loro

La differenza tra multi-homed e transit è soltanto \"politica\": è il
singolo AS che decide se permettere o meno il transito di traffico non
suo nella propria rete. Non esistono vincoli tecnici che impediscono o
obbligano un AS a peremttere il transito a traffico non suo.

== Protocolli di routing

I protocolli di routing devono tenere in considerazione:

- #strong[scalabilità]

- #strong[autonomonia amministrativa]: ogni AS deve poter essere
  autonomo nella gestione della propria rete

- #strong[Border Gateway Protocol] (BGP): regola il traffico tra AS
  differenti;

- #strong[Interior Gateway Protocol] (IGP): famiglia di protocolli che
  regolano il traffico nella rete interna di un AS (esempi: RIP, OSPF).

Gli algoritmi di routing cercano di risolvere il problema
dell'instradamento andando ad individuare dei #strong[percorsi ottimi]
all'interno di un #strong[grafo].

Il costo dell'inoltro di un pacchetto è dato da diversi fattori:

- statici: topologia della rete, numero di link da percorrere per
  arrivare a destinazione, ecc.;

- dinamici: guasti, congestioni, ecc.;

- economici: \"pedaggio\" da pagare ad un altro AS per poter utilizzare
  la sua rete;

Il #strong[tipo di traffico] invece #strong[non dev'essere considerato]
nei costi, sarebbe una violazione della #strong[net neutrality].

Un algoritmo di routing può essere #strong[globale] o #strong[locale]
(detto anche #strong[distribuito]):

- in un algoritmo di routing globale, ogni nodo ha una #strong[visione
  globale] della rete (conosce tutti gli altri nodi e tutti i
  collegamenti). Esempio: algoritmi di tipo #strong[link state
  protocol];

- in un algoritmo di routing locale, i nodi non hanno una visione
  globale della rete (per lo meno non nello stesso istante di tempo), ma
  ne hanno una soltanto locale (es. conoscono i nodi e i collegamenti
  più vicini a loro). Esempio: #strong[distance vector protocol].

In entrambe le tipologie di algoritmi, ogni nodo comunica sempre agli
altri delle informazioni sullo stato della rete. Gli algoritmi di
routing locali però non hanno uno \"snapshot\" dell'intera rete.

=== Algoritmi di tipo link state

Famiglia di algoritmi di routing #strong[globali] che usano
l'#strong[algoritmo di Dijkstra] per calcolare il percorso ottimo.

In questi algoritmi ciascun nodo comunica periodicamente a tutti gli
altri nodi della rete informazioni riguardo al costo dei suoi
collegamenti. Questi messaggi vengono chiamati #strong[link state
broadcast].

Con queste informazioni, ogni nodo riesce a costruirsi internamente lo
stato della rete e a calcolare il percorso migliore utilizzando
l'algoritmo di Dijkstra.

Tutti i nodi hanno una visione #strong[completa ed identica] dello stato
della rete.

Problematiche da gestire:

- tutti i nodi devono conoscersi, altrimenti non sono in grado di
  comunicare in broadcast. Dev'esserci quindi un #strong[database
  centrale] autoritativo che contiene tutti i nodi della rete, con il
  quale ogni router dev'essere in grado di interfacciarsi;

- potrebbero esserci degli errori di sincronizzazione tra i nodi (es. i
  link state broadcast non arrivano a tutti, ad alcuni arrivano in
  ritardo, ecc.);

- il fatto di generare molto traffico broadcast rende questi algoritmi
  poco scalabili su reti molto grandi

Periodicamente ogni nodo invia in broadcast dei pacchetti #strong[LSP]
contenenti:

- l'ID del nodo;

- la #strong[lista dei vicini] e il costo dei rispettivi link;

- un numero di sequenza (per accorgersi di delivery-out-of-order dei
  pacchetti);

- un TTL (per evitare di usare informazioni vecchie)

I pacchetti LSP vengono inviati dai router con una logica di
#strong[flooding]: quando un router riceve un pacchetto LSP con un TTL
valido:

+ aggiorna la propria tabella di routing, sulla base delle informazioni
  contenute nel pacchetto;

+ inoltra una copia del pacchetto LSP a tutti i suoi link, ad eccezione
  di quello da cui proveniva il pacchetto

=== Algoritmi di tipo distance vector

Algoritmi #strong[locali] legati al concetto di #strong[vettori di
distanze].

Sono algoritmi #strong[asincroni] perché non tutti i nodi sono
sincronizzati tra loro.

Informazioni che ogni router memorizza:

- costo delle varie destinazioni (parte \"distance\");

- #strong[direzione] da prendere per ogni destinazione (parte
  \"vector\"), ovvero il next hop;

Questi algoritmi utilizzano l'#strong[algoritmo di Bellman-Ford] per
calcolare il percorso ottimo.

Ad ogni iterazione dell'algoritmo, un nodo comunica ai suoi vicini
soltanto un #strong[vettore] che contiene tutte le destinazioni a lui
conosciute e il rispettivo costo.

Gli algoritmi di tipo distance vector sono molto più #strong[scalabili]
rispetto a quelli di tipo link state, perché non ci sono messaggi
broadcast (ogni nodo comunica solo con i propri vicini).

Di contro, questi algoritmi hanno problemi di #strong[convergenza] in
caso di cambiamenti nella rete:

- in caso di guasto di un nodo, gli algoritmi di tipo distance vector
  impiegano diverse iterazioni per aggiornare i costi su tutti i nodi;

- gli algoritmi di tipo link state invece impiegano una sola iterazione
  in questo caso

==== Effetto rimbalzo

Problema notevole negli algoritmi di routing di tipo distance vector.

#figure([#image("images/7fcfb912212000ba1bb21992f9fdf446.png")],
  caption: [
    Effetto rimbalzo: scenario iniziale
  ]
)

Il collegamento tra A e B ha un problema:

#figure(
  image("images/57dd139d524e6aa9d1af0e632c2c4e3c.png", height: 28%),
  caption: [
    Effetto rimbalzo: un link ha un problema
  ]
)

B aggiorna la distanza per A e decide di passare per C per raggiungerlo:

#align(center)[#table(
  columns: 3,
  align: (col, row) => (center,center,center,).at(col),
  inset: 6pt,
  [destinazione], [costo], [predecessore],
  [A],
  [3],
  [C],
  [C],
  [1],
  [B],
)
#align(center, [1° iterazione: tabella delle distanze di B])
]

Problema: la distanza che B ha ricevuto da C per raggiungere A prevedeva
il passaggio per B stesso. Anche C quindi deve aggiornare la sua
distanza per raggiungere A, perché è cambiata la distanza B $arrow.r$ A
su cui C si basava:

#align(center)[#table(
  columns: 3,
  align: (col, row) => (center,center,center,).at(col),
  inset: 6pt,
  [destinazione], [costo], [predecessore],
  [A],
  [4],
  [B],
  [B],
  [1],
  [C],
)
#align(center, [2° iterazione: tabella delle distanze di C])
]

Di nuovo, B è costretto ad aggiornare la propria distanza per
raggiungere A, perché è cambiata la distanza C $arrow.r$ A su cui B si
basava.

Questo loop continua finché C non si accorge che è più conveniente usare
il link diretto C $arrow.r$ A con costo 25.

Eventuali pacchetti da inoltrare che arrivano a B o a C mentre è in
esecuzione questo loop continueranno a rimbalzare tra questi due nodi
finché il loop non termina (o finché non scade il TTL del pacchetto).

Possibili mitigazioni al problema (non lo risolvono, ma riducono i
danni):

- si definisce un #strong[numero massimo di hop] (es. 16) per
  \"rappresentare l'infinito\" (se un nodo è distante 16 hop si
  considera irraggiungibile);

- approccio #strong[split horizon]: approccio selettivo dove si evita
  che B mandi a C percorsi che prevedono il passaggio per C stesso

Una reale soluzione all'effetto rimbalzo è l'algoritmo #strong[path
vector], estensione del distance vector. Nel path vector i nodi non si
scambiano solo i costi per raggiungere la destinazione finale, ma anche
l'#strong[intero percorso] per raggiungerla. In questo modo ogni nodo
può scartare le informazioni che riguardano percorsi che passano per il
nodo stesso.

=== Routing Information Protocol (RIP)

Protocollo molto semplice basato su algoritmo di tipo #strong[distance
vector].

I costi sono misurati in termini di #strong[numero di hop].

Ogni nodo iniva informazioni ogni #strong[30 secondi] agli altri nodi.

Un nodo può anche fare una #strong[richiesta attiva] (RIP request) ai
nodi a lui vicini per richiedere le informazioni, senza quindi dover
aspettare 30 secondi.

Se un router non riceve informazioni per #strong[180 secondi], viene
considerato irraggiungibile e si considerano guasti i link che portano
verso di lui.

Ha gli stessi svantaggi degli algoritmi di tipo distance vector:

- non adatto a reti dove i costi sono molto dinamici (es. frequenti
  congestioni, ecc.);

- rischio di effetto rimbalzo

=== Open Short Path First (OSPF)

Protocollo di tipo link state intra-AS.

Diversamente da RIP, OSPF si adatta anche a reti in cui le condizioni
possono cambiare molto velocemente.

Può essere usato in maniera ibrida con RIP.

Il #strong[link state database] viene inviato ogni #strong[30 minuti] a
tutti i nodi che stanno nella rete.

=== Border Gateway Protocol (BGP)

Protocollo usato per regolae il traffico inter-AS.

Utilizza un algoritmo di tipo #strong[path vector].

BGP utilizza il #strong[protocollo TCP] per instaurare una connessione
tra i router vicini (che nel contesto del protocollo vengono chiamati
#strong[peer]).

Vantaggi di BGP:

- garantisce che non ci siano cicli nel percorso (grazie all'uso
  dell'algoritmo path vector);

- non ci sono dei refresh periodici (come nel caso degli algoritmi di
  tipo link state o distance vector): un percorso è considerato valido
  finché non viene sovrascritto da un percorso migliore o finché non si
  perde la connessione con il peer;

- gli aggiornamenti sono #strong[incrementali];

- le metriche di un AS non sono esposte agli altri AS

Una #strong[sessione BGP] è una connessione semi-permanente tra due
peer, instaurata tramite il protocollo TCP.

Una sessione BGP può essere:

- #strong[interna] (I-BGP) se coinvolge router dello stesso AS;

- #strong[esterna] (E-BGP) se coinvolge router di AS diversi

Il protocollo BGP è quello che di fatto implementa la logica
#strong[hop-by-hop] di Internet: ogni router informa i vicini soltanto
dei percorsi che utilizza.

Funzionalità principali di BGP:

- scambiare informazioni di raggiungibilità tra #strong[AS confinanti],
  detti #strong[peer], configurando #strong[manualmente] i router;

- propagare le informazioni di raggiungibilità all'interno di un AS con
  un meccanismo #strong[distribuito] basato sull'algoritmo #strong[path
  vector];

- determinare i percorsi miglior in base a informazioni di
  raggiungibilità e policy di routing

Le destinazioni sono indicate con #strong[prefissi] che rappresentano
una o più sottoreti. Si fa ampio uso di #strong[aggregazione CIDR] di
indirizzi per ridurre drasticamente il numero di entry nelle tabelle di
routing.

Il BGP non è necessario se uno dei due AS è uno #strong[stub].

Il protocollo BGP distingue due tipologie di router:

- #strong[transit router]: gestiscono il traffico I-BGP (interno
  all'AS). Questi router devono essere peer di tutti gli altri;

- #strong[border router] (o edge router): gestiscono il traffico E-BGP
  (tra AS diversi). Non devono necessariamente essere peer di tutti gli
  altri.

La scelta del percorso si basa sia sulla policy dell'AS, sia su alcuni
#strong[path attributes], ovvero caratteristiche del percorso, ad
esempio:

- hop count;

- presenza o assenza di certi AS;

- dinamica dei link (stabili/instabili)

BGP può essere configurato per adottare diverse #strong[politiche]. Le
politiche sono implementate in 2 modi:

- scegliendo percorsi tra diverse alternative;

- controllando l'invio di #strong[advertisement] ad altri AS

Esempi di politiche:

- un AS multi-homed rifiuta di agire come transit per altri AS (limita
  il path advertisement);

- un AS multi-homed decide di agire come transit per altri AS (effettua
  il path advertisement per quegli AS);

- un AS può favorire o penalizzare per il traffico transit che viene
  originato da lui

Il #strong[prefix advertisement] è l'azione con cui i router si
scambiano informazioni sui #strong[prefissi] contenuti nelle loro
tabelle di routing. Questi annunci possono contenere anche dei path
attributes.

Quando un router viene a conoscenza di un nuovo prefisso, aggiunge una
riga alla propria tabella di routing.

Un router può venire a conoscenza di più percorsi per raggiungere lo
stesso prefisso. Per selezionarne uno tra questi ci sono diverse regole:

- policy locale;

- AS-PATH più breve (cioè quali AS deve attraversare il pacchetto per
  arrivare a destinazione);

- router di NEXT-HOP più vicino;

- altri criteri, inclusi quelli economici

==== Gestione dei guasti in BGP

Guasti E-BGP ed I-BGP sono gestiti in maniera diversa:

- se si rompe un link E-BGP, tutti i percorsi che utilizzano quel link
  vengono eliminati dalle tabelle di routing;

- se si rompe un link I-BGP, i router potrebbero essere comunque in
  grado di comunicare tramite percorsi indiretti

== Protocollo ICMP

Protocollo di livello 3 usato come supporto ad IP.

Usato dai router per segnalare malfunzionamenti all'interno della rete e
come strumento per il debug di una rete.

=== Struttura di un pacchetto ICMP

Si tratta di un pacchetto IP in cui il campo #strong[protocollo] è
settato ad #strong[1].

Nel payload può contenere informazioni riguardanti livelli superiori
dello stack TCP/IP (es. #strong[port unreachable]).

Il campo #strong[type] definisce la tipologia di pacchetto.

#align(center)[#table(
  columns: 2,
  align: (col, row) => (center,left,).at(col),
  inset: 6pt,
  [type], [message],
  [0],
  [echo reply],
  [3],
  [destination unreachable],
  [5],
  [redirect],
  [8],
  [echo request],
  [11],
  [time exceeded],
)
#align(center, [Tipologie di pacchetto ICMP])
]

I dati inseriti in un messaggio di tipo #strong[echo request] devono
essere re-inviati al mittente, così come li ha mandati, in un nuovo
messaggio ICMP di tipo #strong[echo reply]. \
Echo request ed echo reply sono usati dal comando `ping` e sono stati
pensati appositamente per testare #strong[attivamente] la connettività
di rete.

I messaggi di tipo #strong[destination unreachable] contengono degli
ulteriori sotto-tipi:

- code 0: network unreachable;

- code 1: host unreachable;

- code 3: port unreachable;

- code 4: packet too big. Inviato dai router quando il pacchetto che
  ricevono non può essere inoltrato sulla loro rete a causa dell'MTU
  inferiore alla dimensione del pacchetto.

Il messaggio di tipo #strong[time exceeded] può essere inviato dai
router quando scartano un pacchetto a causa del TTL scaduto. Sono alla
base del comando `traceroute`.

Il messaggio di tipo #strong[redirect] può essere inviato da un router
per informare il mittente del fatto che esiste un #strong[percorso
migliore] verso il quale inoltrare il pacchetto.

= Livello trasporto

Il livello trasporto estende il servizio di consegna del protocollo IP
tra due host terminali ad un servizio di consegna a due #strong[processi
applicativi] in esecuzione sugli host.

- TCP (Transfer Control Protocol): enfasi sul #strong[trasferimento] e
  sul #strong[controllo] dei dati;

- UDP (User Datagram Protocol): enfasi sui #strong[dati] e sull'uso che
  ne fa l'#strong[utente]

Funzionalità implementate dai protocolli di questo livello:

- gestire la #strong[comunicazione tra processi]. Devono avere capacità
  di #strong[multiplexing e demultiplexing] per farli comunicare sullo
  #strong[stesso canale];

- funzionalità di #strong[rilevamento degli errori], in modo simile ad
  Ethernet

TCP ed UDP sono ai due estremi:

- UDP è un protocollo che implementa il #strong[minimo indispensabile]
  per poter essere definito un protocollo di livello trasporto;

- TCP invece cerca di implementare tutte le funzionalità che potrebbero
  essere utili ed è quindi un protocollo molto più complesso

Spesso può avere senso sviluppare un protocollo proprietario per il
livello trasporto proprio per avere una \"via di mezzo\" tra TCP ed UDP.

Nel contesto dei protocolli di livello 4, multiplexing e demultiplexing
vengono implementati utilizzando le #strong[porte]. A livello 4, ciò che
identifica un'applicazione è la porta.

Nell'header del pacchetto trasporto ci sono la #strong[porta sorgente] e
la #strong[porta destinazione].

La porta è complementare all'indirizzo IP:

- l'IP identifica l'host;

- la porta identifica l'applicazione in esecuzione su quell'host

Il sistema operativo assegna una certa porta, in maniera
#strong[esclusiva], ad un processo.

La gestione delle porte è indipendente dal protocollo: la stessa porta
può essere utilizzata da 2 protocolli diversi, ma lo stesso protocollo
non può utilizzare 2 volte la stessa porta.

Il sistema operativo riesce a gestire il caso in cui la stessa porta sia
attiva sia per UDP che per TCP perché, leggendo il datagram IP, è in
grado di capire il protocollo di livello 4 usato e quindi ad inoltrare
il pacchetto all'applicazione specifica.

A seconda del protocollo, il sistema operativo potrebbe decidere di non
inviare immediatamente il pacchetto all'applicazione (es. i pacchetti
vengono inviati solo quando un #strong[buffer] si riempie, come avviene
in TCP).

La porta è un numero intero da #strong[16 bit].

Le porte sono divise in vari range:

- #strong[well-known ports]: range 0-1024. Sono assegnate a determinati
  protocolli applicativi ben definiti. Tipicamente vengono gestite in
  modo particolare anche dai sistemi operativi (ad esempio nei sistemi
  Linux sono necessari i privilegi di root per poter avviare un processo
  che usa queste porte);

- #strong[registered ports]: range 1.024 - 49.151. Anch'esse sono
  associate ad alcuni protocolli/applicazioni notevoli (es. 3306 MySQL,
  5432 PostgreSQL, ecc.), ma che sono meno \"fondamentali\" delle
  well-known ports;

- #strong[porte alte]: range 49.152 - 65.535. Non sono associate a
  nessun protocollo noto e non hanno alcun significato implicito.
  Tipicamente i client scelgono la propria porta sorgente all'interno di
  questo range.

Su Linux esiste il file `/etc/services` che mappa il numero della porta
con il protocollo applicativo.

== Paradigma client-server nei protocolli di livello 4

Tutti i protocolli di livello trasporto distinguono i ruoli di
#strong[client] e #strong[server]:

- il server apre una connessione #strong[passiva], mettendosi #strong[in
  ascolto su una certa porta];

- il client apre una connessione #strong[attiva] con il server

Sia il processo client che il processo server sono identificati da una
porta.

Nei casi d'uso reali:

- la porta del client è scelta in modo casuale dal sistema operativo;

- la porta del server è richiesta esplicitamente

Quando si parla di comunicazione a livello di trasporto, ogni pacchetto
è identificato da una #strong[quintupla]:

- IP sorgente/destinazione;

- porta sorgente/destinazione;

- tipo di protocollo (TCP o UDP)

Il termine #strong[packet flow] indica l'insieme dei pacchetti che
appartengono alla stessa comunicazione.

== Controllo d'integrità

Il controllo d'integrità a livello 4 viene fatto tramite un
#strong[checksum], che viene inserito nell'header del pacchetto.

Sia TCP che UDP effettuano il controllo d'integrità allo stesso modo.

Il controllo d'integrità a livello 4 viene fatto anche su informazioni
del livello 3. In particolare viene costruito uno #strong[pseudo-header]
di livello 4 con le seguenti informazioni:

- indirizzo IP mittente e destinatario;

- protocollo di livello 4 usato (TCP o UDP);

- lunghezza del pacchetto di livello 4

Il checksum viene poi calcolato su:

- pseudo-header;

- header reale di livello 4;

- payload

L'algoritmo di checksum del livello 4 lavora su blocchi da #strong[16
bit] alla volta, anche se il pacchetto è diviso in blocchi da 32 bit.

L'algoritmo di checksum del livello 4 viene eseguito dal software.
Tipicamente si tratta di un algoritmo molto più semplice di quello usato
a livello 2 (che invece gira su hardware dedicato).

Il controllo d'integrità esiste anche a livello 2 e 3, ma viene
introdotto anche a livello 4 per una serie di ragioni:

- non tutti i link forniscono un servizio di livello 2 per rilevare gli
  errori;

- il checksum di IP è fatto solo sull'header IP, non sui dati;

- il datagram di IPv6 non contiene più il checksum

== Protocollo UDP

Protocollo #strong[minimale] che implementa il minimo indispensabile per
poter essere definito un protocollo di trasporto.

Possiede comunque le caratteristiche fondamentali di questi protocolli,
ovvero la gestione delle porte e il controllo d'integrità.

Come IP, UDP non fornisce nessuna garanzia di affidabilità.

UDP è un protocollo #strong[orientato ai pacchetti] (a differenza di TCP
che è orientato alla connessione). Ogni pacchetto è trattato in modo
#strong[indipendente] da tutti gli altri (come avviene in IP).

La dimensione massima di un pacchetto UDP è data da:
$ sans("dimensione pacchetto IP") minus sans("dimensione header UDP") $

UDP non ha nessuna logica di frammentazione, che viene lasciata al
livello 3.

=== Pacchetto UDP (user datagram)

#figure([#image("images/86ba8ae97d2b7276ad9a7073a53e3200.png")],
  caption: [
    Pacchetto UDP
  ]
)

== Protocollo TCP

Si tratta di un protocollo definito in diversi RFC. Soggetto ancora oggi
a piccole modifiche in alcune sue parti.

Rispetto ad UDP, TCP garantisce #strong[affidabilità] anche in presenza
di protocolli sottostanti inaffidabili (es. IP).

TCP è un protocollo #strong[orientato alla connessione].

=== Problema dell'affidabilità

Si vuole creare un canale #strong[virtuale] affidabile su un canale
fisico inaffidabile. Questo canale virtuale è creato dal sistema
operativo, che dev'essere in grado di #strong[rilevare] e
#strong[correggere] gli errori.

In questo contesto, con \"correzione\" dell'errore s'intende la
ri-trasmissione del dato. A questo livello infatti non ci sono
informazioni sufficienti per andare effettivamente a correggere gli
errori.

Gli errori che devono essere rilevati (e corretti) da TCP sono:

- errori di trasmissione. Per questi errori si utilizza il checksum,
  come in UDP;

- il pacchetto non arriva a destinazione;

- arrivano più copie dello stesso pacchetto;

- delivery out-of-order dei pacchetti

TCP implementa delle rilevazioni per #strong[tutti] questi possibili
errori.

Non tutte le applicazioni però sono sensibili a questi errori
(specialmente al delivery out-of-order). Queste applicazioni quindi
possono usare UDP e re-implementarsi alcune funzionalità di rilevazione
degli errori di TCP.

La logica di rilevazione (e correzione) degli errori è gestita in
maniera trasparente dal sistema operativo. L'applicazione deve
preoccuparsi soltanto di inviare i dati.

=== Acknowledgement

Nei protocolli ad alta affidabilità è necessario predisporre un
meccanismo di #strong[acknowledgement]. L'acknownledgement può essere
positivo o negativo.

Nel caso di TCP esiste solo l'acknowledgement positivo, per una serie di
ragioni:

- se un pacchetto viene perso, il destinatario non ha modo di inviare un
  ACK negativo;

- nel corso degli anni è emerso come la casistica d'errore principale di
  Internet sia il #strong[sovraccarico dei router]. Aggiungere quindi
  del traffico (gli ACK negativi) che questi router dovranno gestire non
  è una buona idea.

Quando il mittente invia un messaggio, inizia a partire un
#strong[timeout]. Se dopo tale timeout il mittente non ha ricevuto un
ACK positivo per il messaggio che aveva mandato, allora assumerà che ci
sia stato un errore e ri-trasmetterà il messaggio.

TCP, come tutti i protocolli orientati alla connessione, ha 3
sotto-protocolli:

- uno per #strong[aprire] la connessione;

- uno per #strong[usare] la conessione (scambio di dati);

- uno per #strong[chiudere] la connessione (in realtà in TCP ce ne sono
  2)

Tutti questi sotto-protocolli devono essere #strong[affidabili] affinché
TCP nel suo insieme possa essere affidabile.

Nel caso di TCP, la connessione è soltanto #strong[logica]. Non c'è
un'allocazione stabile di risorse fisiche (come invece avviene in PPP a
livello 2).

Sia client che server sono tenuti a memorizzare uno #strong[stato] della
connessione.

=== Trasporto orientato al flusso dati

Il \"pacchetto\" TCP viene chiamato #strong[segmento], con l'idea che
non sia una cosa a sè stante ma faccia parte di un più ampio
#strong[flusso di dati].

TCP mette a disposizione alle applicazioni un'interfaccia per inviare i
dati. Sarà compito di TCP gestire la #strong[segmentazione] del flusso
di dati.

La segmentazione fatta da TCP è analoga a quella che fa IP a livello 3.
TCP però cerca di evitare che ci sia una ulteriore frammentazione a
livello 3, quindi di solito imposta come dimensione massima del segmento
l'MTU dell'interfaccia di rete.

Ogni segmento TCP viene identificato da un #strong[sequence number] che
consente al destinatario di:

- identificare (e scartare) eventuali #strong[duplicati];

- riordinare i segmenti in caso di delivery out-of-order

In TCP esiste un #strong[buffer] sia per l'invio che per la ricezione
dei pacchetti:

- il sistema operativo del mittente invia i dati soltanto quando il
  buffer è pieno;

- il sistema operativo del destinatario invia i dati all'applicazione
  soltanto quando il buffer è pieno

Il buffer destinatario viene usato anche per:

- rilevare eventuali errori;

- riordinare i pacchetti in caso di delivery out-of-order

La connessione virtuale che viene creata con TCP è di tipo #strong[full
duplex]. Una volta creata la connessione, non c'è più distinzione tra
client e server (entrambi possono usare il canale per inviare i dati in
maniera #strong[indipendente]). L'unico momento in cui TCP distingue
client e server è nell'#strong[apertura] della connessione,

=== Asincronia di TCP

La gestione tramite buffer rende TCP un protocollo #strong[asincrono]:
il momento in cui il sistema operativo invia effettivamente i dati non
coincide necessariamente con quello in cui l'applicazione chiede al SO
di inviarli.

L'asincronia c'è sia in fase di invio che in fase di ricezione.

Esistono alcune eccezioni con le quali l'applicazione può chiedere al
sistema operativo di inviare #strong[subito] i dati.

=== Cosa TCP NON gestisce

- comunicazione in #strong[tempo reale] (TCP è #strong[asincrono] e non
  è quindi adatto per comunicazioni real time);

- #strong[disponibilità di banda] (non garantisce una velocità minima o
  un ritardo massimo di trasmissione);

- comunicazioni multicast/broadcast (TCP è pensato per far comunicare
  soltanto 2 entità tra di loro)

#pagebreak(weak: true)
=== Segmento TCP

#figure([#image("images/6edf4a6b98426b6f97c63cbcce4c414a.png")],
  caption: [
    Segmento TCP
  ]
)

==== Sequence number e acknowledgement number

Il sequence number è l'#strong[offset], all'interno del #strong[flusso]
di comunicazione, di quel segmento specifico.

L'acknowledgement number è associato al sequence number ed indica quanti
byte il destinatario ha ricevuto correttamente.

Sequence number ed ACK number sono su campi separati perché TCP permette
di inviare dati anche all'interno di pacchetti di tipo ACK.

Dato che sequence number e ACK number sono codificati con 32 bit, per
avere flussi di comunicazione che trasferiscono più di $2^32$ byte
questi numeri sono #strong[ciclici] (si riparte da capo quando si arriva
alla fine).

==== Scelta dell'initial sequence number

Nel momento in cui client e server instaurano la connessione,
#strong[entrambi] generano in modo casuale un #strong[initial sequence
number] (diverso tra client e server) e lo inviano all'altro.

Client e server dovranno far partire i propri ACK number sulla base
dell'initial sequence number ricevuto dall'altro.

L'initial sequence number viene generato casualmente (e non si parte da
0) per ragioni di sicurezza. In questo modo un eventuale attaccante farà
più fatica a intromettersi in una comunicazione TCP generando segmenti
validi, perché dovrebbe indovinare l'initial sequence number utilizzato.

==== HLEN

Lunghezza dell'header TCP.

Questo campo è necessario perché in TCP, come in IP, la lunghezza
dell'header è #strong[variabile].

==== RESERVED

Campo riservato per usi futuri.

==== CODE BIT

Bitmask che indica le funzionalità attive in quel segmento.

- bit #strong[URGENT]: usato nella fase di scambio dati, serve per
  marcare un segmento come #strong[urgente], in modo che il sistema
  operativo gli dia priorità rispetto agli altri. In realtà questo bit
  non è quasi più utilizzato oggi (in caso di urgenza vera si usano
  direttamente altri protocolli piuttosto che TCP).

- bit #strong[ACK]. Se è `1` significa che questo è un segmento di
  acknowledgement e quindi il suo ACK number dev'essere interpretato dal
  destinatario;

- bit #strong[PUSH]: svuota il buffer di ricezione. Quando il sistema
  operativo del ricevente trova un segmento con bit PUSH pari ad 1,
  invierà immediatamente i dati all'applicazione, senza aspettare il
  riempimento del buffer.

- bit #strong[SYN]. Usato in fase di #strong[apertura] della
  connessione.

- bit #strong[FIN]. Usato in fase di chiusura (affidabile) della
  connessione.

- bit #strong[RST]. Usato in fase di chiusura (inaffidabile) della
  connessione.

==== WINDOW SIZE

Campo associato al controllo di flusso. Contiene la quantità di byte che
il ricevente può ancora ricevere prima di congestionarsi.

==== URGENT POINTER

Puntatore legato al bit `URG`.

Indica quali sono i dati urgenti all'interno del pacchetto.

==== TCP OPTIONS

Contiene eventuali opzioni usate dal protocollo.

Opzioni degne di nota:

- #strong[max segment size] (MSS): indica la dimensione massima del
  segmento supportata in #strong[ricezione]. Equivalentemente, si può
  dire che questo campo contiene la dimensione in byte del buffer di
  ricezione;

- #strong[window scale]: serve per indicare delle finestre di
  comunicazione più grandi di $2^16$ bit (massimo valore inseribile nel
  campo window size);

- #strong[maximum segment lifetime]: analogo del TTL del livello 3

=== Esempio di dati urgenti

Una delle poche applicazioni rimaste che fa uso del bit `URG` è `telnet`
(il vecchio SSH).

I segnali per i processi (es. `^Z`, `^C`, ecc.) vengono mandati come
\"dati urgenti\".

=== Negoziazione della max segment size

Se l'MSS non è mai scambiata tra le opzioni, si assume una dimensione di
#strong[536 byte]. In realtà l'opzione è sempre presente nelle fasi di
apertura della connessione.

Indicare un valore dell'MSS superiore a quello di default può essere
utile per #strong[aumentare le prestazioni] (cioè si riduce il numero di
pacchetti).

L'MSS dovrebbe comunque essere sempre inferiore all'MTU del livello 2,
in modo da evitare la frammentazione fatta a livello 3 da IP.

La dimensione ideale dell'MSS è:
$ upright("MTU") minus upright("dim. header liv. 3") minus upright("dim. header liv. 4") $

Client e server si scambiano le rispettive MSS durante le fasi di
apertura della connessione.

L'MSS può comunque essere ri-negoziato una volta aperta la connessione.

L'MSS che viene scelto è il #strong[minimo] tra quello di client e
server, oppure un valore ancora inferiore se tra client e server ci sono
reti con una MTU più piccola.

=== Piggybacking

Logica per la quale il ricevente, una volta ricevuti con successo i
dati, non invia immediatamente un acknowledgement, ma aspetta un po',
nella speranza di ridurre il numero di acknowledgement.

=== Apertura della connessione - three way handshaking

Questa è l'unica fase in cui si distinguono i ruoli di client e server:

- il server è in ascolto su una porta;

- il client vuole aprire una connessione verso il server su quella porta

L'instaurazione della connessione in TCP serve per diverse ragioni:

- assicurarsi che il server esista e che sia raggiungibile;

- negoziare alcuni parametri (es. MSS)

Tutto questo #strong[prima] di iniziare ad inviare dati.

Il processo con cui viene instaurata la connessione si chiama
#strong[three-way handshaking].

==== 1. Client SYN

Il 1° pacchetto necessario per aprire la connessione viene mandato
#strong[dal client al server].

Si tratta di un pacchetto #strong[vuoto] (non ha un payload) e che ha il
bit SYN \= 1.

In questo pacchetto il client deve indicare il suo initial sequence
number.

In questo pacchetto possono esserci anche informazioni per la
negoziazione dei parametri, quali:

- #strong[maximum receiver window]: il client indica al server la
  dimensione del proprio buffer di ricezione;

- maximum segment size

==== 2. Server SYN/ACK

Se il server intende aprire una connessione con il client, risponderà
con un altro pacchetto vuoto con #strong[entrambi] i bit SYN ed ACK
settati ad 1.

In questo pacchetto il server deve includere il proprio initial sequence
number.

L'ACK number che il server invia al client in questo pacchetto è
l'initial sequence number del client aumentato di 1.

==== 3. Client ACK

Il client risponde al server con un altro pacchetto vuoto con bit ACK \=
1.

- il seq. number di questo pacchetto è l'initial seq. number del client
  (scelto al punto 1), aumentato di 1;

- l'ACK number di questo pacchetto è l'initial seq. number del server
  (scelto al punto 2), aumentato di 1

A questo punto la connessione client $arrow.l.r$ server è aperta e non
c'è più distinzione tra client e server.

=== Chiusura della connessione

In TCP esistono 2 modi per chiudere una connessione:

- modalità #strong[polite] (con affidabilità);

- modalità #strong[unpolite] (senza affidabilità)

==== Chiusura polite

Viene utilizzata quando non si ha fretta di chiudere la connessione.

La connessione può essere chiusa arbitrariamente dal client o dal server
(ricordare che a questo punto della comunicazione non c'è nemmeno
distinzione tra client e server).

Supponendo che la comunicazione sia tra due entità A e B, la chiusura
della connessione prevede questi passi:

+ A invia a B un pacchetto TCP con bit FIN \= 1;

+ B riceve il pacchetto e risponde con un ACK;

+ B informa l'applicazione del fatto che A intende chiudere la
  connessione, in modo da darle tempo per disallocare eventuali risorse;

+ quando l'applicazione ha chiuso la connessione, B invia un pacchetto
  ad A con bit FIN \= 1;

+ A risponde a B con un ACK e fa partire un #strong[timeout], in modo da
  dare tempo all'applicazione in esecuzione su A di liberare eventuali
  risorse;

+ trascorso il timeout, anche A considera chiusa la connessione con B

Quando B riceve l'ACK di A, considererà chiusa la connessione.

La chiusura polite viene utilizzata per dare tempo all'applicazione di
gestire una logica di chiusura (rilasciare eventuali risorse, ecc.).

Il timeout di A serve per gestire eventuali segmenti TCP che potrebbero
essere ancora circolanti nella rete (ad esempio a causa di
ritrasmissioni).

==== Modalità unpolite

La connessione viene chiusa immediatamente.

Viene utilizzata quando non c'è tempo (o interesse) nell'aspettare tutto
il giro della chiusura polite.

In questo caso A invia un pacchetto TCP con bit RST \= 1. B non è tenuto
a rispondere in alcun modo (nemmeno con un ACK).

A considererà chiusa la connessione #strong[immediatamente] (subito dopo
l'invio del pacchetto).

Anche B considererà chiusa la connessione immediatamente, non appena
riceve il pacchetto (o quando si accorge che A non risponde più, se il
pacchetto RST è stato perso).

Con questa modalità non ci sono garanzie di affidabilità (approccio best
effort).

Questa modalità non è strettamente indispensabile dal punto di vista
tecnico: (per interrompere la connessione basterebbe che A e B smettano
di parlarsi, ci penserà poi il timeout di TCP a interrompere la
connessione), ma almeno si #strong[notifica] l'altra entità della
comunicazione del fatto che si vuole interrompere la connessione.

=== Timeout di TCP

Il timeout in TCP è #strong[adattativo]. Viene continuamente ri-stimato
in base alle condizioni della rete.

#block[
#strong[Definizione]: Round Trip Time (RTT)

Tempo che passa tra l'invio di un segmento e la ricezione del suo ACK.

]
Per definizione, un timeout valido dev'essere maggiore dell'RTT minimo
osservabile nell'ambito di una comunicazione.

Un primo approccio usato per stimare il timeout si basava sull'RTT
#strong[medio]:
$ upright("timeout") eq beta times upright("RTT")_(upright("medio")) $

Questa tecnica presenta alcuni problemi:

- la media non è sempre affidabile, basta un RTT molto alto/basso per
  sfasarla;

- gli RTT più vecchi dovrebbero avere un peso minore nella stima del
  timeout

Il #strong[sample RTT] all'istante $t$ è l'RTT misurato all'istante $t$.

L'#strong[estimated RTT] è una #strong[media pesata] per
#strong[stimare] l'RTT all'istante $t$:
$ upright("EstimatedRTT") lr((t)) eq lr((1 minus x)) dot.op upright("EstimatedRTT") lr((t minus 1)) plus x dot.op upright("SampleRTT") lr((t)) $

con $x in lr((0 comma 1))$ ed $x eq frac(1, n plus 1)$ come valore
iniziale, dove $n$ è il numero di campioni di RTT usati per il calcolo.

La formula con cui viene stimato l'RTT viene chiamata
#strong[Exponential Weighted Moving Average] (EWMA), perché si tratta di
una #strong[media pesata] in cui il peso dei campioni più vecchi
#strong[diminuisce esponenzialmente] con il passare del tempo.

Una volta stimato l'RTT, si procede con il calcolo del timeout:
$ upright("Timeout") lr((t)) eq upright("EstimatedRTT") lr((t)) plus 4 dot.op upright("Deviation") lr((t)) $

dove $upright("Deviation") lr((t))$ è un #strong[margine d'errore] che
dipende dall'RTT.

=== Prestazioni di TCP

Introduciamo alcuni termini per misurare le performance:

- tempo di propagazione: $upright("RTT") / 2$;

- utilizzazione: percentuale di utilizzo di una risorsa in un intervallo
  di tempo;

- (transmission) rate, #strong[throughput]: capacità trasmissiva della
  rete;

- $upright("L") lr((upright("pkt")))$: lunghezza del pacchetto

- tempo di trasmissione: $L / upright("Rate")$;

Il #strong[tempo di trasferimento] di un pacchetto è dato da:
$ 2 dot.op upright("tempo di trasmissione") plus upright("tempo di propagazione") $

Il tempo di trasmissione è raddoppiato perché bisogna considerare anche
quello dell'acknowledgement.

==== Protocollo stop-and-wait

Protocollo che invia #strong[un segmento alla volta] ed aspetta l'ACK
prima di inviare il prossimo segmento.

#figure([#image("images/5d52a1ef41d734d340e8221b7a993311.png")],
  caption: [
    Protocollo stop-and-wait
  ]
)


L'#strong[utilizzazione] del canale è:
$ upright("tempo trasmissione") / upright("tempo totale") eq frac(T, R T T plus T) eq frac(L / R, R T T plus L / R) eq frac(4, 30 plus 4) eq 0.12 approx 10 percent $

Per ottenere un'utilizzazione migliore si utilizza un #strong[protocollo
pipelined].

==== Protocollo pipelined

Si inviano più pacchetti alla volta anziché uno solo (ad esempio 3). Il
successivo \"stock\" di pacchetti viene inviato solo quando si riceve
l'ACK per lo \"stock\" precedente.

#figure([#image("images/bbdaa89ef0f0d87bd23a55d458d140d8.png", width: 100%)],
  caption: [
    Protocollo pipelined
  ]
)

Questo approccio aumenta la complessità:

- serve un #strong[buffer] per gestire i pacchetti, sia lato mittente
  (per tenere i dati inviati per cui non è ancora stato ricevuto l'ACK)
  sia lato destinatario (per mantenere le sequenze incomplete);

- serve una #strong[sliding window] per definire il numero massimo di
  dati che il mittente può inviare senza prima aver ricevuto l'ACK

La sliding window è un parametro #strong[dinamico] che si aggiorna
continuamente durante l'esecuzione di TCP.

=== Sliding window

La dimensione della sliding window (SWS, Sliding Window Size):

- è dinamica;

- è controllata dal destinatario

==== Sliding window del mittente

$ upright("LSS") minus upright("LAR") lt.eq upright("SWS") $

- LAR \= Last Acknowledgement Received;

- LSS \= Last Segment Sent;

- SWS \= Sender Window Size

#figure([#image("images/05eda5729f3732cf009c114c0c322f52.png", width: 100%)],
  caption: [
    Sliding window mittente
  ]
)

==== Sliding window del destinatario

$ upright("LAS") minus upright("LSR") lt.eq upright("RWS") $

- LAS \= Last Acknowledgement Sent;

- LSR \= Last Segment Received;

- RWS \= Receiver Window Size

#figure([#image("images/67d35c34ba13a27a67dea848dd4f77e7.png", width: 100%)],
  caption: [
    Sliding window destinatario
  ]
)

Il destinatario scarta i pacchetti che sono \"più avanti\" rispetto alla
sua sliding window, perché rimarrebbero per troppo tempo nel buffer di
ricezione (e quindi sprecherebbero risorse).

La dimensione della sliding window di ricezione dev'essere superiore a
quella di invio ($upright("RWS") gt.eq upright("SWS")$).

=== Algoritmi per l'affidabilità in TCP

==== Algoritmo Go-Back-N

Il destinatario invia degli ACK #strong[cumulativi] (non si invia un ACK
per ogni pacchetto). Se il mittente non riceve un ACK, dovrà
ri-trasmettere #strong[tutto] il blocco di pacchetti.

Con questo approccio non c'è bisogno di gestire una sliding window lato
destinatario per gestire il pipeling.

Lo svantaggio principale è che il destinatario non è in grado di inviare
un ACK per pacchetti che non sono consecutivi, esempio:

- il mittente invia 3 pacchetti: 10, 20 e 30;

- il destinatario riceve 10 e 30, ma non 20

- il destinatario non può inviare un ACK, perché non ha ricevuto tutti i
  pacchetti;

- scade il timeout per l'ACK al mittente e deve quindi ri-mandare tutti
  e 3 i pacchetti (nonostante 2 pacchetti su 3 fossero stati ricevuti
  correttamente)

==== Algoritmo di ritrasmissione selettiva

Ogni ACK è riferito solo ad un #strong[singolo] pacchetto.

Sia mittente che destinatario devono gestire una sliding window.

==== Algoritmo usato da TCP

TCP usa un ibrido tra ritrasmissione selettiva e Go-Back-N:

- gli ACK sono cumulativi;

- esiste un approccio di ritrasmissione selettiva

Esempio:

- il mittente manda i pacchetti 1, 2, 3 e 4;

- il destinatario riceve i pacchetti 1, 2 e 4;

- il destinatario si salva il pacchetto 4, ma risponde con ACK \= 2;

- il mittente ri-trasmetterà i pacchetti 3 e 4, perché ha ricevuto un
  ACK \= 2;

- il destinatario riceve i pacchetti 3 e 4 e risponde con ACK \= 4

Non è un approccio di ritrasmissione selettiva \"pulita\" (il mittente
rischia comunque di mandare più volte gli stessi pacchetti).

Questo approccio ibrido è utile anche in caso di delivery out-of-order:

- il mittente invia i pacchetti (in ordine) 1, 2 e 3;

- il destinatario riceve i pacchetti in ordine 1, 3 e 2;

- alla ricezione del pacchetto 1, il destinatario risponde con ACK \= 1;

- alla ricezione del pacchetto 3, il destinatario risponde ancora con
  ACK \= 1, ma si salva il pacchetto 3 nel buffer;

- alla ricezione del pacchetto 2, il destinatario risponde con ACK \= 3

Con quest'approccio il mittente può ricevere più ACK per lo stesso
pacchetto:

- fino a 2 ACK, il 2° ACK (duplicato) viene ignorato;

- 3 ACK per lo stesso pacchetto invece vengono interpretati come un
  #strong[ACK negativo]

Il fatto di avere ACK cumulativi aiuta anche il mittente in caso di
delivery out-of-order degli ACK stessi.

Nelle opzioni di TCP è possibile richiedere di utilizzare un algoritmo
di ritrasmissione selettiva pura anziché questo approccio ibrido. Oggi
questa è la scelta preferita (vedi opzione #strong[SACK] di TCP).

=== Calcolo della dimensione della sliding window del mittente

Per realizzare

- controllo di flusso

- controllo di congestione

è necessario avere una dimensione #strong[dinamica] della sliding
window.

La dimensione della sliding window viene scelta come la dimensione
minima fra:

- congestion window

- flow window

L'ACK che il destinatario invia al mittente contiene:

- sia quanti byte il destinatario ha ricevuto correttamente;

- sia quanti byte il destinatario può ancora ricevere. Se il buffer di
  ricezione del destinatario è pieno, questo valore sarà pari a 0.

In realtà se il destinatario ha esaurito il buffer, il mittente continua
periodicamente ad inviargli dei pacchetti (vuoti). Questo per dare modo
al destinatario di rispondere con un ACK che dice che è di nuovo
disponibile.

Per il controllo di congestione si usano un approccio #strong[slow
start] ed #strong[AIMD] (Additive Increase, Multiplicative Decrease)
sulla congestion window:

- inizialmente la congestion window è molto piccola (slow start);

- man mano che il mittente riceve degli ACK positivi, la dimensione
  della congestion window aumenta sempre di più (additive increase);

- appena si verifica un timeout, il mittente cala drasticamente
  (multiplicative decrease) la dimensione della congestion window per
  rallentare

Se si fa un grafico della velocità istantanea di TCP si ottiene un
grafico a dente di sega.

Alcuni algoritmi per il controllo di congestione utilizzano un approccio
#strong[pro-attivo], cioè cercano di #strong[prevenire] la congestione
piuttosto che #strong[reagire] ad essa.

La velocità cala in modo diverso tra triplo ACK positivo e timeout.
Generalmente il triplo ACK positivo viene considerato come una
congestione meno grave rispetto ad un timeout, quindi la velocità cala
molto meno.

=== Fairness di TCP

TCP è un protocollo #strong[fair], ovvero cerca di \"comportarsi bene\"
nei confronti degli altri protocolli/processi in esecuzione sulla
macchina (cioè non \"ruba\" risorse più del necessario).

Questa cosa in UDP non esiste: se si iniziano a spammare a manetta
pacchetti UDP, le connessioni TCP potrebbero piantarsi perché si manda
in congestione la rete. È compito del sistemista fare in modo che questi
protocolli potenzialmente \"maleducati\" non diano problemi alla rete.

=== TCP vs UDP

Nonostante le funzionalità offerte da TCP, ci sono comunque alcuni
vantaggi nell'uso di UDP:

- non c'è instaurazione della connessione, non ci sono #strong[stati] da
  dover conservare e gestire;

- i pacchetti TCP sono più grandi di quelli UDP (20 byte header TCP vs 8
  byte header UDP);

- in caso di applicazioni che devono essere a bassissima latenza (es.
  real-time), il controllo di flusso fatto da TCP potrebbe avere impatti
  negativi sulle performance;

- il delivery out-of-order non è un problema di tutte le applicazioni
  (ad esempio non lo è per HTTP);

- in una rete locale si ha generalmente un'affidabilità molto più alta
  rispetto che su un collegamento in Internet. Potrebbe quindi non
  valere la pena fare tutto il 3-way handshake in questi casi;

- non è sempre importante riceve tutti i pacchetti. In VoIP, per
  esempio, se si perde qualche pacchetto si sentirà un po' male la voce
  per un istante;

- l'applicazione potrebbe re-implementarsi la gestione dell'affidabilità
  per i fatti suoi

= Firewall

Principi per la sicurezza nelle reti locali:

- #strong[segmentazione]: partizionamento delle risorse fisiche e/o
  logiche (es. VLAN a livello 2);

- #strong[segregazione]: definizione di politiche di #strong[controllo
  degli accessi] (es. firewall)

#block[
#strong[Definizione]: firewall

Un firewall è un sistema che ha il compito di #strong[segregare] il
traffico tra due reti separate.

]
#block[
#strong[Definizione]: Access Control List (ACL)

Definizione di quali host e quali servizi sono consentiti e quali sono
proibiti.

]
Esistono 2 policy principali:

- negazione implicita;

- accettazione implicita

I firewall si differenziano tra loro per:

- tipologia (hardware o software);

- punto in cui devono essere installati (sugli host o a livello di rete
  su un router);

- protocolli supportati (firewall di livello 3 e 4);

- tipo di analisi (stateless o stateful)

Tipicamente i firewall agiscono come #strong[packet filter].

Tipologie principali di firewall:

- #strong[screening router]: caso più comune. Ha il compito di filtrare
  pacchetti di livello 3 e 4;

- #strong[stealth firewall]: versione più avanzata degli screening
  router. Tipicamente includono meccanismi di #strong[intrusion
  detecnion]. Concettualmente sono dispositivi di livello 2;

- #strong[proxy firewall] (o #strong[application gateway]): implementano
  logiche applicative per analizzare in maniera estremamente dettagliata
  i pacchetti. Possono essere #strong[trasparenti] al client oppure no
  (transparent proxy firewall)

L'approccio della #strong[defence-in-depth] prevede di utilizzare tra
loro diverse tipologie di firewall.

== Network design patterns

=== Single screening router

Singolo router, posto ai bordi della rete, con logica di packet
filtering.

#figure([#image("images/493d024e8134ee29cad353806d529377.png")],
  caption: [
    Single screening router
  ]
)

Pattern poco costoso e semplice da realizzare, ma con diversi svantaggi:

- singolo layer di difesa;

- single point of failure;

- la rete interna non è segregata;

- poca scalabilità (un singolo router ha un limite al numero di host che
  può gestire)

=== Dual-homed firewall

Router e firewall sono su dispositivi separati:

#figure([#image("images/00d093ae26bd2eb31828371b26fa6c73.png")],
  caption: [
    Dual-homed firewall
  ]
)

Il dual-homed firewall implementa il packet filtering. Può essere anche
un application proxy.

La rete interna e quella esterna sono ben separate.

Gli svantaggi sono gli stessi del single screening router:

- singolo layer di difesa;

- single point of failure;

- poca scalabilità rispetto alla dimensione della rete

=== Bastion host e DMZ

#figure([#image("images/6fe2c443cfa0bd519b1f0fa2d9dbafbd.png")],
  caption: [
    Sceened-host gateway
  ]
)

Il #strong[bastion host] è un proxy firewall che ha compito di
ispezionare il traffico tra la rete sicura (quella interna) e quella
insicura.

Lo screening router implementa logiche di packet filtering e lascia
passare soltanto il traffico diretto al bastion host, dove verrà
analizzato ulteriormente.

Questo modello può prevedere anche una #strong[DMZ] (De-militarized
Zone), ovvero una #strong[rete intermadia] tra quella interna e quella
esterna.

- per accedere gli host in DMZ dall'esterno non occorre passare dal
  bastion host;

- per accedere agli host in DMZ dalla rete interna invece sì

La DMZ è interessante perché il suo scopo è proteggere una
#strong[sottorete] della rete interna.

=== Screened subnet

Tutti i design precedenti vengono accorpati:

#figure([#image("images/a3be25649f159343a55fbd67684c56d1.png")],
  caption: [
    Screened subnet
  ]
)

Si ha una difesa multi-livello e si implementano correttamente
segmentazione e segregazione.

- il firewall esterno filtra il traffico tra la rete esterna e il
  bastion host/DMZ;

- il firewall interno protegge sia la rete interna da attacchi esterni,
  sia la DMZ da attacchi provenienti dalla rete interna

= DNS - Domain Name System

Il DNS definisce come gestire i #strong[nomi] su Internet.

Il DNS non è un protocollo, ma un intero #strong[sistema].

I sistemi di identificazione per i protocolli di rete usano di solito
degli #strong[indirizzi binari]. Il DNS è un sistema parallelo che
utilizza delle #strong[stringhe alfanumeriche] (cioè un #strong[nome])
per identificare gli interlocutori.

Il DNS è un sistema #strong[geograficamente distribuito].

== Hostname

Il DNS è un sistema per trasformare indirizzi IP in nomi. L'idea è
quella di avere una #strong[corrispondenza biunivoca] tra indirizzi IP e
nomi, in modo da riuscire a contattare un host tramite il suo nome
anziché il suo indirizzo.

Nel contesto del DNS, questi nomi vengono chiamati #strong[hostname]. Si
tratta di una sequenza di label separate dal carattere \"`.`\".

In origine in un hostname potevano esserci solo caratteri ASCII-7,
mentre oggi si possono usare anche caratteri non-ASCCI (es. Unicode) -
in questo caso si parla di regole #strong[IDN] (Internationalized Domain
Name).

Un hostname può essere lungo al massimo 256 caratteri.

Un hostname si dice #strong[canonico] se permette di identificare
#strong[univocamente] un host in Internet.

Gli hostname si leggono #strong[da destra verso sinistra]: si va dal
livello di dettaglio più alto a quello più specifico.

Un hostname canonico è composto da:

- #strong[dominio] (le due label più a destra);

- hostname #strong[relativo] (quello che rimane una volta tolto il
  dominio)

Gli hostname, oltre all'usabilità, forniscono anche flessibilità
rispetto agli indirizzi IP, per esempio:

- il client non ha più bisogno di sapere se l'host che vuole contattare
  ha un indirizzo IP v4 o v6;

- se il server viene spostato su un altro host, il suo indirizzo IP
  cambia, mentre il suo hostname resta lo stesso;

Un singolo hostname può essere mappato anche a più di un indirizzo IP
(tecnica usata anche per distribuire il carico su diverse macchine). In
questi casi il DNS restituisce una lista di indirizzi IP e il client
sceglie il 1° indirizzo di questa lista. È compito del DNS far ruotare
gli elementi di questa lista.

L'utilizzo del DNS comporta un overhead. Per migliorare le performance
si usano diverse tecniche #strong[caching] a più livelli.

== Reverse lookup

Meccanismo inverso del DNS dove si ottiene un hostname a partire dal suo
indirizzo IP.

== Name server

Sono i server che istanziano il sistema DNS.

Il name server è il server che viene invocato per effettuare il lookup
(o reverse lookup).

Il DNS è #strong[decentralizzato], ogni name server è
#strong[autoritativo] solo su un #strong[insieme limitato] di nomi.

In origine il lookup veniva fatto utilizzando UDP. Oggi, sebbene UDP sia
ancora il default, esistono diverse alternative orientate alla
#strong[privacy] (es. DNS over TLS, DNS over HTTPS, ecc.). Per
l'interazione tra name server si usa TCP.

== Cybersquatting e punycode

Questi 2 termini identificano delle pratiche malevole di uso del DNS.

Nel cybersquatting, una persona riserva un nome molto simile a quello di
un \"brand\" famoso (es. `g0ogle.com`) per motivi di phishing/truffe.

Nel punycode si utilizza invece lo stesso identico nome di un \"brand\"
famoso, ma con un'altra codifica (così il nome alfabetico è identico a
quello vero, ma in binario i due nomi sono diversi).

Esistono diverse regole che le autorità che gestiscono i nomi devono
applicare in modo da evitare questi comportamenti scorretti.

== Organizzazione dello spazio dei nomi

La label più a destra si chiama #strong[top level domain] (TLD), mentre
la 2° label più a destra si chiama #strong[second level domain] (SLD).

TLD ed SLD sono presenti in tutti i nomi, mentre le altre label sono
facoltative.

I TLD più famosi sono i #strong[country code TLD] (ccTLD), cioè TLD
associati a paesi (es. `.it`, `.uk`, ecc.).

I #strong[generic TLD] invece non sono associati a nessuna nazione in
particolare, ma ad uno \"scopo\" generico:

- `.com` per scopi commerciali;

- `.gov` per scopi governativi;

- ...

Gli #strong[infrastructure TLD] servono invece per scopi interni al DNS.
Un esempio è il TLD `.arpa`, utilizzato per il reverse lookup.

Recentemente DNS è stato esteso per permettere di registrare TLD
arbitrari.

Gli SLD sono associati alle entità che gestiscono il dominio stesso (es.
`unimore.it`).

Mediante TLD ed SLD si possono creare delle #strong[gerarchie] di
domini. La root di questa gerarchia non sono in realtà i TLD, ma esiste
una root \"nascosta\" (semplicemente \"`.`\") che ha come figli tutti i
vari TLD:

#figure([#image("images/83fbabe13828ba43b7468fcd28e74640.png")],
  caption: [
    Gerarchia di nomi
  ]
)

Per risolvere un nome si percorre questa gerarchia #strong[dalla radice
alla foglia]. I #strong[root name server] sono i server che permettono
di iniziare questo processo di risoluzione. I client quindi devono
conoscere soltanto gli indirizzi IP dei root name server.

Il #strong[local name server] è un server presente nella rete locale del
client a cui è affidato il compito di contattare tutti gli altri name
server. Nel caso di connessioni domestiche, l'IP del local name server
viene fornito dall'ISP.

I local name server hanno un ruolo importante nel meccanismo di caching.

La #strong[zona] è l'insieme dei domini per i quali il name server è
autoritativo, ovvero può dare direttamente una corrispondenza IP
$arrow.l.r$ nome senza dover passare per altri name server.

Il name server autoritativo è l'unico che può dire che un dominio non
esiste.

Nelle risposte del name server c'è un campo che indica se la risposta è
autoritativa oppure se proviene da informazioni cachate.

=== DNS su Linux

In ambiente Linux il local name server è configurato nel file
`/etc/resolv.conf`. Tipicamente questo file viene popolato tramite DHCP
o altre procedure automatiche.

In alcuni casi l'IP del local name server potrebbe non essere in questo
file, perché alcune distro (es. Fedora) utilizzano un #strong[processo
locale] per gestire la risoluzione dei nomi.

== Name server primari e secondari

Per questioni di ridondanza esistono dei meccanismi di replicazione nei
protocolli DNS.

I name server primari vengono detti #strong[master]. Tutti i name server
secondari devono essere sincronizzati con il master.

Il #strong[master file] è il database che contiene le mappature IP
$arrow.r$ nomi.

Lo scambio di dati periodico che avviene tra name server primari e
secondari viene detto #strong[zone transfer] e riguarda solo la zona in
cui quel name server è autoritativo.

== Resource record

Il #strong[resource record] (RR) è una riga del database di un name
server.

Esistono diversi tipi di resource record:

- `A`: rappresenta effettivamente il mapping nome $arrow.r$ IP. Serve
  per gestire la risoluzione diretta di un nome. È possibile che
  contenga una lista di indirizzi IP.

- `AAAA`: equivalente al record `A`, ma usato per IPv6;

- `NS`: mapping tra zona e name server autoritativo per essa. Se il name
  server risponde con un record `NS`, tipicamente nella risposta c'è
  anche un record `A` che contiene l'IP del name server da contattare;

- `SOA`: contiene dei parametri di una zona (es. TTL della cache, ecc.);

- `MX`: record speciale utilizzato dal sistema e-mail;

- `CNAME`: record utilizzato per gestire gli #strong[alias] (più
  hostname associati allo stesso IP);

- `PTR`: record usato per il reverse lookup;

- `TXT`: ufficialmente è un campo di testo libero, ma in realtà viene
  usato per inserire del testo machine-readable per poter essere usato
  da altri protocolli/sistemi (es. protocollo SPF nel sistema e-mail)

Ogni record contiene anche un TTL che indica per quanto tempo sarà
ancora valido.

=== Record PTR e reverse lookup

#figure([#image("images/ab32ca8df7a21c68e1c9fd8a73a66faf.png")],
  caption: [
    Esempio record `PTR`
  ]
)

I record `PTR` mappano un indirizzo IP all'hostname corrispondente.

Gli indirizzi IP nei record PTR hanno però 2 particolarità:

- sono scritti al contrario (cioè, nella figura sopra, la 1° riga mappa
  l'indirizzo `212.52.84.185`);

- terminano tutti con `.in-addr.arpa`

Gli indirizzi IP nei record `PTR` vengono scritti al contrario per
conservare la #strong[scalabilità]:

- gli hostname si leggono da destra (parte più generale) verso sinistra
  (parte più specifica);

- gli indirizzi IP si leggono da sinistra (parte più generale, net ID)
  verso sinistra (parte più specifica, host ID)

quindi con questo trucchetto è posssibile inserire tanti record (es.
`212.in-addr.arpa`, `52.212.in-addr.arpa`, ecc.) ognuno specifico per un
certo livello di dettaglio, esattamente come si può fare con gli
hostname (es. `.`, `.com`, `google.com`, ecc.).

Ad ogni indirizzo IP viene poi aggiunto il dominio `.in-addr.arpa`
perché ciò che sta nel record `PTR` non è un indirizzo IP, ma è a tutti
gli effetti un hostname.

Con queste tecniche quindi il reverse lookup si riconduce allo stesso
problema del lookup (ottenere l'IP partendo dal nome).

== Meccanismo di risoluzione

Il #strong[resolver] può fare 2 tipologie di #strong[query] (richieste
di risoluzione):

- query #strong[ricorsive]: viene fatta dal resolver in esecuzione sul
  client finale verso il local name server. Chiede al local name server
  di gestire anche tutte le eventuali richieste aggiuntive necessarie
  per ottenere l'IP finale;

- query #strong[iterative]: fatte dal local name server ai name server
  autoritativi. Una query iterativa tipicamente non restituisce
  immediatamente l'IP finale, ma l'IP di un altro name server che
  gestisce quella zona, a cui dovrà essere fatta la richiesta

#figure([#image("images/e6500362503e9a36eb540975d75bf500.png")],
  caption: [
    Esempio completo di query al DNS
  ]
)

== Registrar

Il registrar è l'organizzazione autorizzata a registrare i nomi
nell'ambito di un certo dominio.

I registrar di solito gestiscono la registrazione dei SLD associati ad
alcuni TLD.

= DHCP - Dynamic Host Configuration Protocol

Protocollo applicativo basato su UDP che serve per configurare il
livello 3 di un host.

La maggior parte delle infromazioni vengono trasmesse tramite protocolli
H2N.

DHCP è il successore del protocollo RARP (il \"reverse\" di ARP), ma non
ha nulla in comune con esso.

DHCP si basa sul paradigma client-server:

- il server è configurato staticamente;

- i client DHCP si collegano ad una rete che contiene un server DHCP. Di
  solito i client non conoscono l'IP del server DHCP (e, in generale,
  non hanno nemmeno idea di come sia fatta la rete alla quale si sono
  connessi)

L'obiettivo di DHCP è che dopo la sua esecuzione sul client, questi sia
in grado di interagire con un #strong[qualunque host] presente su
Internet. Deve quindi fornire tutto quello che serve al client per
permettergli di connettersi alla rete.

DHCP non è adatto per essere usato sui router.

L'amministratore deve prevedere delle #strong[policy di rete] in un
punto centralizzato (cioè il server DHCP) in modo che i client possano
utilizzarle per auto-configurarsi.

DHCP è molto #strong[scalabile]:

- il server DHCP è facilmente #strong[replicabile]. Una parte
  fondamentale di DHCP è saper riconoscere il server autoritativo in
  presenza di più server nella rete;

- DHCP può funzionare su una o più #strong[subnet] di rete. Questa è una
  caratteristica fondamentale che contraddistingue DHCP dai suoi
  predecessori (RARP ecc.).

DHCP si basa su #strong[messaggi broadcast locali], come ARP.

== Policy di rete

Le policy di rete sono i parametri di configurazione di DHCP, ad
esempio:

- come assegnare gli indirizzi IP ai vari host;

- regole di routing;

- comunicazione del local name server da utilizzare

Le policy sono #strong[persistenti] al riavvio del server e client DHCP.

L'assegnazione di un indirizzo IP ad un client da parte di DHCP può
essere #strong[statica] (lo stesso client riceve sempre lo stesso IP) o
#strong[dinamica] (l'IP viene scelto da un pool di indirizzi).

Si definisce #strong[lease] il tempo per cui un client possiede un certo
indirizzo IP.

DHCP è molto flessibile per quanto riguarda la gestione della rete, ad
esempio funziona perfettamente anche in reti configurate in parte
staticamente e in parte con DHCP.

DHCP possiede diversi meccanismi, sia sul client che sul server, per
assicurarsi che l'IP che viene assegnato non vada in conflitto con altri
host.

Il database delle policy è un database key-value:

- la key identifica univocamente l'host (tipicamente si usa il MAC
  address);

- il value è l'indirizzo IP da assegnare all'host (o il range dal quale
  sceglierlo), più eventuali altre configurazioni (gateway, DNS, ecc.)

== Realizzazione del paradigma client-server con DHCP

Nonostante DHCP distingua client e server, entrambi si mettono in
ascolto su una porta: `67/udp` il server e `68/udp` il client (anche il
client quindi usa una well-known port).

Il motivo per cui anche il client si mette in ascolto su una porta è
dovuto al fatto che, non essendo ancora configurati, devono avere
qualcosa di noto al server (la porta, in questo caso) per poter ricevere
le sue risposte.

Tutti i client sono sulla stessa porta `68/udp`.

== Pacchetto DHCP

#figure([#image("images/191b78db742f5afa9f7572309344be55.png")],
  caption: [
    Pacchetto DHCP
  ]
)

=== OP - 1 byte

Tipo di messaggio (request o response).

Si tratta in realtà di un'informazione ridondante (si potrebbe capire
guardando le porte sorgente/destinazione del pacchetto UDP), ma viene
comunque inserita esplicitamente.

=== xid - 4 byte

ID della transazione.

Serve per identificare i pacchetti che fanno parte della stessa sequenza
di request/response (è un po' la re-implementazione del sequence number
di TCP).

Viene scelto in modo casuale #underline[dal client] nel momento in cui
vuole iniziare a comunicare con il server.

=== ciaddr - 4 byte

Indirizzo IP attuale del client.

Questo campo può contenere informazioni se il client si era già connesso
alla rete precedentemnte e aveva già ottenuto un indirizzo IP dal server
DHCP.

=== yiaddr - 4 byte

Indirizzo IP #strong[proposto] dal server al client. Il client non è
obbligato ad accettarlo.

=== siaddr - 4 byte

Campo popolato se i server DHCP sono ridondati o se sono dei
#strong[relay server].

=== chaddr - 4 byte

MAC address del client, inviato dal server al client.

Anche questa è un'informazione ridondante (si potrebbe guardare il campo
del frame Ethernet), ma è inserita esplicitamente per far funzionare
DHCP anche su reti differenti (es. in caso di relay server).

=== options

Campo di dimensione variabile che il server può usare per passare al
client altre configurazioni non legate all'indirizzo IP (es. DNS server,
ecc.).

== Messaggi tipici del protocollo DHCP

=== OP \= 1 - da client a server (DHCP request)

- DHCPDISCOVER: utilizzado da un client #underline[non ancora
  configurato] per capire se nella rete a cui si è connesso esiste un
  DHCP server;

- DHCPREQUEST: utilizzato da un client che si era già collegato alla
  rete in precedenza per chiedere conferma per poter utilizzare un
  indirizzo IP che gli era rimasto in memoria. Questo tipo di messaggio
  viene usato anche dopo che il client ha ricevuto la proposta dal
  server, per chiedergli conferma prima di utilizzare l'indirizzo IP
  proposto;

- DHCPDECLINE: il client rifiuta l'IP proposto dal server. Questo può
  capitare se è il client a rilevare un conflitto di indirizzi con l'IP
  ricevuto dal server (scenario che può capitare se client e server DHCP
  sono su reti differenti);

- DHCPRELEASE: usato quando il client si disconnette alla rete, in modo
  da comunicare al server il rilascio dell'indirizzo IP;

- DHCPINFORM: simile ad una DHCPREQUEST, ma il client chiede altri
  parametri di configurazione (DNS server, ecc.) e non un indirizzo IP

=== OP \= 2 - da server a client (DHCP response)

- DHCPOFFER: offerta di un indirizzo IP al client;

- DHCPACK: conferma ad una DHCPREQUEST;

- DHCPNAK: rifiuto ad una DHCPREQUEST

== Workflow di messaggi - caso più comune

+ DHCPDISCOVER: il client cerca di capire se nella rete c'è un server
  DHCP;

+ DHCPOFFER: il server rileva che c'è un client e gli offre un indirizzo
  IP, eventualmente dopo aver verificato (es. tramite protocollo ARP)
  che non sia già utilizzato da qualcun altro;

+ DHCPREQUEST: il client riceve l'offerta del server e gli chiede
  conferma dell'IP ricevuto;

+ DHCPACK: il server conferma l'indirizzo IP. Il client ha terminato la
  fase di configurazione

È interessante notare che il sistema operativo del client accetta sempre
il pacchetto IP contenente la DHCOFFER del server. Questa è una
particolarità di tutti i S.O.: se ad un'interfaccia di rete non è
assegnato un indirizzo IP (come in questo caso), tutti i pacchetti
verranno sempre accettati.

== Transaction ID e note sulla sicurezza

Se il client riceve un pacchetto DHCP con un transaction ID non scelto
da lui, scarterà quel pacchetto.

Se non ci fosse il TXID, un server DHCP malevolo potrebbe spammare
continuamente in rete delle DHCPOFFER finché non si connette un client
che le accetta.

Quello che può succedere è una #strong[race condition] tra il server
DHCP malevolo e quello valido:

+ entrambi ricevono la DHCPDISCOVER del client con all'interno il TXID
  da utilizzare;

+ i due server \"fanno a gara\" per chi risponde prima al client

In caso di più pacchetti con lo stesso TXID, il client accetterà
soltanto il 1°.

= WWW - World Wide Web

Spesso WWW è usato come sinonimo di Internet, ma in realtà si tratta di
due cose ben distinte:

- Internet è la rete IP;

- WWW è un insieme di protocolli e strumenti che sfruttano la rete
  Internet per offrire un certo servizio

Protocolli e standard alla base di WWW:

- TCP;

- DNS;

- paradigma client server (server \= web server, client \= browser);

- HTTP: protocollo per scambiare le informazioni nel WWW;

- URL: standard per il #strong[naming delle risorse] all'interno degli
  host. È indipendente dal WWW (infatti gli URL esistono anche in altri
  contesti);

- HTML: standard di markup (rappresentazione delle informazioni). Grazie
  ad esso è possibile creare una #strong[rete di informazioni]
  utilizzando gli #strong[hyperlink]

== Meccanismi di naming del web

- URI (Uniform Resource Identifier): identifica univocamente una risorsa
  su Internet e può eventualmente contenere le informazioni su come
  ottenerla;

- URL (Uniform Resource Locator): identifica univocmanete una risorsa su
  Internet e contiene sempre le informazioni su come accedervi;

- URN (Uniform Resource Identifier): identifica univocamente una risorsa
  su Internet e non contiene mai le informazioni per ottenerla

== Struttura di un URL

#block[
`scheme ":" ["//" authority] path ["?" query] ["#" fragment]`

`authority = [userinfo "@"] host [":" port]`

]
Il path è composto da tanti #strong[segmenti], separati da `/`. Ogni
segmento può specificare dei parametri che il server potrà interpretare.

La query string serve per indicare dei #strong[parametri d'azione] su
una risorsa.

Il fragment identifica una specifica #strong[porzione] di una risorsa
alla quale il client è interessato.

L'URL potrebbe essere case sensitive oppure no:

- l'hostname è case-insensitive (dovuto al DNS);

- per il path invece dipende dal web server utilizzato (alcuni sono
  case-sensitive, altri no)

== Protocollo HTTP

Protocollo basato sui paradigmi #strong[request-response] e
#strong[client-server] usato per il trasferimento di informazioni
\"ipertestuali\" (cioè non solo testo ma anche file, immagini, ecc.).

HTTP utilizza TCP come protocollo trasporto.

HTTP è #strong[stateless]. Per gestire lo stato si utilizzano i
#strong[cookie]. \
I cookie sono dei #strong[token opachi]: il client non deve farci nulla
se non salvarseli e ri-mandarli al server alla prossima richiesta.

=== Versioni di HTTP

La versione iniziale di HTTP era la 1.0. Oggi si usano HTTP 1.1, 2.0 e
si sta iniziando a diffondere HTTP 3.0.

La differenza principale tra HTTP/1.0 e HTTP/1.1 è il
#strong[pipelining]:

- con HTTP/1.1 si possono richiedere #strong[più risorse
  contemporaneamente], senza dover aspettare di aver prima ottenuto la
  risposta precedente;

- HTTP/1.0 invece è un protocollo stop-and-wait

Il server è obbligato a rispondere con la stessa major version di HTTP
usata dal client. La minor version, invece, può anche essere diversa.

=== Struttura del messaggio HTTP

HTTP è un protocollo #strong[testuale]: i messaggi sono codificati in
ASCII e non in binario.

==== Request

#figure([#image("images/eb4b4e058fe09d75d6f6a1e9c2aa175f.png")],
  caption: [
    Request HTTP
  ]
)

Un header degno di nota è `Host`, che contiene l'hostname del server. Si
tratta di un header opzionale nella teoria, ma ormai richiesto da tutti
i web server in quanto fondamentale per implementare il #strong[virtual
hosting].

=== Response

#figure(
  image("images/9a2f3a15702f4696e64cbb0d81cadb52.png", height: 23%),
  caption: [
    Response HTTP
  ]
)

Il server deve sempre includere l'header `Content-Type` nelle sue
risposte. Il content type inoltre è autoritativo: se nel response body
c'è un video ma il content type è `text/plain`, quel body dovrà essere
interpretato come testo.

== HTML

Un #strong[documento ipertestuale] è un documento con testo e altro
contenuto multimediale (audio, immagini, ecc.).

Nel contesto dell'HTML, le risorse multimediali incluse nel documento si
chiamano #strong[embedded objects].

Il browser ha un engine che mette insieme i vari componenti di una
pagina e la renderizza sullo schermo.

== User agent

Termine tecnico con cui si indica un client HTTP.

== MIME

Sotto-protocollo di HTTP specializzato per capire il #strong[tipo] di
una risorsa.

MIME in realtà nasce con SMTP e non con HTTP.

= Protocolli sicuri

I protocolli sviluppati all'inizio di Internet non tengono in
considerazione la #strong[sicurezza].

Alcuni protocolli (Ethernet, TCP, IP) tengono in considerazione
l'#strong[affidabilità], ma solo rispetto a #strong[guasti] nella rete.
Nessuno di questi protocolli tiene in considerazione l'affidabilità
rispetto ad #strong[avversari umani] (es. indirizzi IP/MAC falsificati).

Dal punto di vista della sicurezza, un attaccante può violare:

- la #strong[confidenzialità], cioè riesce a leggere informazioni che
  dovrebbero essere a lui segrete;

- la #strong[data origin authenticity], ovvero l'autenticità
  dell'origine dei dati (l'attaccante può impersonare qualcun altro)

Un protocollo sicuro deve quindi garantire:

- confidenzialità dei \"dati che si spostano\" (#strong[data in
  motion]);

- #strong[autenticità]

La protezione dei \"dati in movimento\" è la ragione della nascita della
#strong[crittografia].

#block[
La crittografia protegge i dati nel momento in cui l'attaccante ne viene
in possesso.

]
Le garanzie di sicurezza che si cercano sono diverse:

- confidenzialità;

- #strong[integrità] rispetto ad #strong[attaccanti umani]. Il
  destinatario deve riuscire ad accorgersi se il messaggio è stato
  alterato;

- #strong[autenticità]: il destinatario dev'essere certo del mittente
  del messaggio;

- #strong[disponibilità] (availability): i dati non devono essere resi
  inaccessibili (es. tramite attacchi di tipo DoS)

In generale, i protocolli sicuri non coprono la disponibilità, perché
questo è un aspetto che si gestisce in fase di #strong[progettazione del
sistema].

== Crittografia

Nel contesto dei protocolli sicuri, l'informazione è sempre
#strong[cifrata].

La crittografia è una tecnica che #strong[trasforma] il messaggio in
modo da rendere impossibile risalire al messaggio originale.

La crittografia non è da confondere con:

- #strong[steganografia]: tecnica per #strong[nascondere] le
  informazioni all'interno di un altro messaggio sensato;

- #strong[crittoanalisi]: tecniche che cercano di rompere la
  crittografia

La crittografia esiste da secoli e si è evoluta di pari passo con le
#strong[tecniche di comunicazione]:

- #strong[crittografia classica] fino all'avvento della radio;

- #strong[crittografia moderna] dall'avvento della radio in poi

La crittografia classica:

- si basava sulla #strong[segretezza dell'algoritmo];

- garantiva soltanto confidenzialità, ma non integrità;

- si basava sul concetto di #strong[envelope]: ogni messaggio è
  #strong[indipendente] dagli altri (come nella comunicazione orientata
  ai pacchetti)

La crittografia moderna, invece:

- si basa sulla #strong[segretezza della chiave], l'algoritmo è
  pubblico;

- cerca di garantire anche l'integrità oltre che la confidenzialità;

- si basa sulla diffocoltà nel risolvere dei #strong[problemi
  matematici] complessi (es. logaritmo discreto, fattorizzazione di
  numeri primi molto grandi)

Le tecniche di crittografia si possono usare anche in contesti che non
riguardano la comunicazione, per esempio per la protezione dei
\"#strong[data at rest]\". Ognuno di questi scenari richiede lo sviluppo
di un protocollo differente.

=== Cryptographic settings

Con questo termine si indicano le informazioni che delineano come un
sistema deve funzionare:

- chi partecipa;

- come comunicano i partecipanti;

- quali informazioni si scambiano;

- ...

Si dividono in #strong[symmetric settings] e #strong[asymmetric
settings], che danno origine rispettivamente alla #strong[crittografia
simmetrica] e #strong[crittografia asimmetrica].

=== Visione modulare della crittografia moderna

La crittografia moderna è divisa in #strong[moduli]:

#figure([#image("images/e268eb0d8592f108a6d74aeeaa3d7bce.png")],
  caption: [
    Moduli della crittografia moderna
  ]
)

- alla base ci sono dei #strong[concetti matematici] che mettono a
  disposizione delle #strong[primitive];

- a partire da queste primitive si sviluppano tecniche orientate alla
  sicurezza;

- al livello più alto ci sono i protocolli e le applicazioni sicure,
  ovvero qualcosa di #strong[direttamente utilizzabile] nel mondo reale

=== Schemi di crittografia simmetrica

Un framework #strong[probabilistico] mette a disposizione
quest'interfaccia:

- `keygen([size]) → key`

- `encrypt(key, plaintext) → ciphertext`

- `decrypt(key, ciphertext) → plaintext`

La funzione `encrypt` #underline[non è deterministica]: a partire dallo
stesso input deve restituire un output #underline[sempre diverso].

Input e output di queste funzioni sono #strong[binari]. Se non si hanno
a disposizione dei dati binari, bisogna prima convertirli in questo
formato utilizzando una #strong[codifica] (che è #strong[indipendente]
dalla crittografia) e poi applicare la cifratura.

La crittografia non protegge la #strong[dimensione] del testo: la
lunghezza del testo cifrato dipende dalla lunghezza del testo in chiaro
(in alcuni casi, queste due dimensioni coincidono). Quando anche la
dimensione del dato è importante, bisogna prevedere delle tecniche di
#strong[padding] in modo che tutti i dati abbiano sempre la stessa
dimensione.

Un framework #strong[determinisitco] è fatto in questo modo:

- `keygen([size]) → key`

- `encrypt(key, {n|iv}, plaintext) → ciphertext`

- `decrypt(key, {n|iv}, ciphertext) → plaintext`

Nonce ed initialization vector hanno scopi diversi:

- il nonce dev'essere #strong[sempre diverso] ogni volta che si esegue
  una cifratura utilizzando la stessa chiave. La sua caratteristica è
  l'#strong[univocità]. Un nonce può essere implementato molto
  facilmente con un #strong[contatore];

- l'initialization vector è un vettore di bit scelti in modo
  #strong[casuale] (o pseudo-casuale). La sua caratteristica è
  l'#strong[imprevedibilità].

Utilizzare più volte lo stesso nonce/IV potrebbe avere conseguenze più o
meno gravi, a seconda dello schema di cifratura:

- potrebbe compromettere irrimediabilmente la sicurezza dello schema;

- potrebbe portare alla creazione di un pattern deterministico, fornendo
  informazioni utilissime ad un potenziale attaccante

I framework probabilistici utilizzano al loro interno un framework
deterministico e si occupano di generare un nonce/IV sempre diverso.

Con i framework deterministici, invece, è l'utente che usa il framework
a doversi occupare di generare nonce/IV sempre diversi.

#figure([#image("images/0d7b3287e73e5f2b43b52c252342e56d.png")],
  caption: [
    Schema probabilistico e schema deterministico
  ]
)

=== Funzioni hash

Garantiscono l'#strong[integrità] dei dati.

Una funzione hash prende in input dei dati binari di dimensione
arbitraria e restituisce un output di dimensione costante.

L'output di una funzione hash viene chiamato hash o #strong[digest] o
checksum.

La dimensione del digest non dipende dall'input, ma solo dalla funzione.

Una funzione hash è #strong[crittografica] se rilevare le
#strong[collisioni] è impossibile o impraticabile.

Esempi di funzioni hash crittografiche:

- MD5 (deprecato);

- SHA1 (deprecato);

- SHA2 e SHA3 (standard al momento riconosciuti)

SHA2 e SHA3 sono delle #strong[famiglie] di funzion. Un esempio di
funzione hash è SHA2-256.

Le funzioni hash non richiedono l'utilizzo di una chiave.

Le funzioni hash non possono essere utilizzate #strong[direttamente] per
controllare l'integrità di un messaggio rispetto ad avversari umani. Il
destinatario deve conoscere #strong[in anticipo] l'hash del messaggio.

Le funzioni hash non garantiscono #strong[autenticità].

=== Message Authentication Code (MAC)

Simili alle funzioni hash, ma oltre al messaggio richiedono in input
anche una #strong[chiave].

L'output di queste funzioni viene chiamato #strong[tag] ed è di
dimensione costante.

Le funzioni MAC garantiscono l'#strong[autenticità] di un messaggio. Chi
non ha accesso alla chiave non può più manipolare il messaggio senza che
il destinatario se ne accorga.

Non tutte le funzioni MAC sono implementate con delle funzioni hash. È
perciò fuorviante chiamare le funzioni MAC \"funzioni hash con chiave\".
Le funzioni MAC implementate con funzioni hash si chiamano funzioni
#strong[HMAC].

Le funzioni hash e MAC non garantiscono #strong[confidenzialità], perché
sono #strong[deterministiche]: se gli input di un'applicazione che usa
delle funzioni hash/MAC sono enumerabili, allora è molto facile
\"invertire\" queste funzioni.

Per avere una funzione MAC non è sufficiente passare ad una funzione
hash la chiave concatenata al messaggio (anzi, una cosa del genere è un
grosso problema di sicurezza).

=== Replay attack

Attacco in cui l'avversario invia una copia dello stesso messaggio al
destinatario, facendogli credere che siano arrivati 2 messaggi anziché
uno solo.

#figure([#image("images/05601b43daadceff683ff4379ddf7f54.png", width: 100%)],
  caption: [
    Replay attack
  ]
)

Le funzioni MAC riescono a garantire l'autenticità del singolo
messaggio, ma non dell'intero #strong[flusso] di comunicazione.

Per difendersi dai replay attack, è necessario inserire nel messaggio un
#strong[identificatore univoco]: il destinatario accetterà il messaggio
solo se fa riferimento ad un identificatore che non ha già incontrato in
precedenza.

#figure([#image("images/574d35378a183d91a25b9722c8bfb508.png")],
  caption: [
    Difesa dal replay attack
  ]
)

=== Reflection attack

Simile al replay attack, ma il messaggio viene mandato al mittente
stesso:

#figure([#image("images/00572627d872e8ea4fae542a8ada3977.png")],
  caption: [
    Reflection attack
  ]
)

Se mittente e destinatario usano lo stesso tag, al mittente sembrerà di
aver ricevuto una risposta corretta dal destinatario.

Per difendersi da questo attacco ci sono 2 metodi:

- si aggiunge ai metadati anche la #strong[direzione] del messaggio;

- si usano due tag diversi per mittente e destinatario

=== Cifratura autenticata

La cifratura \"normale\" garantisce confidenzialità.

La cifratura autenticata garantisce integrità e autenticità.

Gli standard moderni di solito forniscono un'interfaccia #strong[AEAD]
(Authentication Encryption with Associated Data) fatta in questo modo:

- `keygen([size]) → key`

- `encrypt(key, {nonce|iv}, a, plaintext) → ciphertext`

- `decrypt(key, {nonce|iv}, a, ciphertext) → plaintext`

`a` è un parametro opzionale che contiene dei dati da non cifrare, ma
dei quali si vuole garantire l'autenticità.

Se viene specificato il parametro `a`, il messaggio cifrato conterrà
anche un tag per garantire l'autenticità del messaggio.

La funzione `decrypt` effettua il controllo di autenticità
#strong[prima] di decifrare il messaggio.

Questo standard è stato realizzato perché è comune per le applicazioni
avere sia dati da cifrare che dati da non cifrare (perché necessari per
il funzionamento dell'applicazione stessa), ma di cui si vuole garantire
l'integrità.

Esempio di dati associati: alcuni campi dell'header di TCP (es. sequence
number).

=== Schemi asimmetrici

La crittografia asimmetrica cerca di risolvere un problema fondamentale
della crittografia simmetrica: la #strong[distribuzione della chiave]
tra mittente e destintario.

Nella crittografia asimmetrica, ogni partecipante ha una #strong[coppia
di chiavi] per cifrare e decifrare il messaggio.

Per comunicare con altri, ogni entità deve comunicare solo la propria
chiave pubblica.

Chiave pubblica e chiave privata sono correlate matematicamente.

La cifratura asimmetrica, da sola, garantisce confidenzialità ma non
autenticità.

Per garantire anche l'autenticità, è necessario aggiungere al messaggio
una #strong[firma digitale], la quale dà anche garanzie di #strong[non
repudiabilità].

#figure([#image("images/53f1f7180133e15b171a1f7c2b78fe5a.png", width: 100%)],
  caption: [
    Firma digitale
  ]
)

Firma digitale e cifratura asimmetrica si possono combinare, in modo
simile a MAC e cifratura simmetrica.

=== Scambio sicuro di chiavi

Le funzioni di cifratura asimmetrica sono ordini di grandezza più
complesse rispetto a quelle per la cifratura simmetrica, quindi si
preferisce generare due chiavi simmetriche e scambiarsele utilizzando la
crittografia asimmetrica.

Scenario: Alice e Bob vogliono scambiarsi delle chiavi su un canale
#strong[insicuro].

Prima idea: Alice genera una chiave `k`, la cifra utilizzando la chiave
pubblica di Bob e gliela manda.

Problema: quest'approccio è vulnerabile ad attacchi di tipo
man-in-the-middle: Eve potrebbe inserirsi nella comunicazione, generare
una chiave $k prime$, cifrarla con la chiave pubblica di Bob ed
inviargliela:

#figure([#image("images/228066a978dbe548b7535c411be88081.png", width: 100%)],
  caption: [
    Man in the middle
  ]
)

Bob non ha nessun modo per verificare che la chiave che gli arriva gli
sia stata mandata da Alice. È necessario quindi aggiungere uno schema di
firma digitale.

==== Schema Diffie-Hellman

Schema per lo scambio sicuro di chiavi che si basa sul #strong[logaritmo
discreto].

In questo problema si definisce un insieme #strong[discreto] di numeri e
si eseguono tutte le operazioni in modulo (in particolare l'elevamento a
potenza), in modo da far rimanere il risultato all'interno dello stesso
insieme.

Esempio:
$ Z_11 eq lr({0 comma 1 comma 2 comma 3 comma 4 comma 5 comma 6 comma 7 comma 8 comma 9 comma 10}) $
$ 3^7 #h(0em) mod med 11 eq 9 $

Data la base 3 e il risultato 9, risalire all'esponente 7 è un problema
difficile.

Lo schema di Diffie-Hellman sfrutta questo problema e le proprietà delle
potenze:

- Alice genera una chiave $a$ e calcola $g^a$;

- Alice manda a Bob il valore di $g^a$;

- Bob genera una chiave $b$ e calcola $g^b$;

- Bob manda ad Alice il valore di $g^b$;

- la chiave simmetrica che i partecipanti utilizzeranno sarà $g^(a b)$

#figure([#image("images/c42801682720bed475af276330275f6c.png", width: 100%)],
  caption: [
    Diffie-Hellman key exchange
  ]
)

Si dice che la chiave simmetrica viene calcolata in modo
#strong[partecipato], perché entrambi contribuiscono al risultato.

Problema: questo protocollo non garantisce autenticità della chiave,
perciò è necessario integrarlo con un sistema di firma digitale.

== Computational security

#block[
#strong[Definizione]: livello di sicurezza

Numero medio di operazioni necessarie per rompere uno schema di
cifratura simmetrica.

]
La #strong[dimensione delle chiavi] è un \"dato derivato\" dal livello
di sicurezza di uno schema.

Il livello di sicurezza di uno schema si misura in bit (es. 80 bit \=
$2^80$ operazioni necessarie, in media, per rompere lo schema).

Negli schemi simmetrici, il livello di sicurezza e la dimensione della
chiave sono strettamente correlati. Questa relazione invece non esiste
negli schemi asimmetrici.

Nella crittoanalisi asimmetrica, gli algoritmi più efficienti non sono
quelli basati sul #strong[bruteforcing] ma quelli basati sulla
risoluzione dei #strong[problemi difficili] sui quali si basa
l'algoritmo di cifratura asimmetrica utilizzato.

Nei contesti asimmetrici, la dimensione della chiave deriva dal problema
matematico che sta sotto.

Problemi matematici legati alle #strong[curve ellittiche] stanno
diventando sempre più popolari, perché permettono di tenere piccola la
dimensione della chiave garantendo lo stesso livello di sicurezza.

== Crittografia e computer quantistici

Si stima che tutti gli schemi asimmetrici attualmente in uso verranno
rotti nei prossimi decenni dai #strong[computer quantistici].

Si stanno già studiando nuovi schemi di cifratura a prova di computer
quantistici. Alcuni sono anche già stati standardizzati.

== Handshake sicuro

Client e server devono riuscire ad eseguire un protocollo che permetta
ad entrambi di ottenere la stessa chiave simmetrica $K$. Per ottenere
questo risultato si può utilizzare un protocollo per lo scambio sicuro
delle chiavi.

Dalla chiave $K$, sia client che server ne derivano altre 3 (tramite
funzioni MAC o hash), l'una indipendente dall'altra. Queste 3 chiavi
servono perché si vuole realizzare una comunicazione full-duplex:

- una chiave serve per la confidenzialità (i.e. per cifrare i dati);

- le altre 2 chiavi servono per l'autenticità. Ne vengono usate 2 e non
  una sola per proteggersi dai reflection attack (una chiave per ogni
  direzione).

In realtà in base al protocollo possono esserci anche più o meno di 3
chiavi.

Un approccio di questo tipo però è vulnerabile ad attacchi
man-in-the-middle. Lo scambio di chiavi deve essere
#strong[autenticato].

== Distribuzione di chiavi pubbliche

Esistono principalmente 3 approcci per la distribuzione di chiavi
pubbliche autenticate:

- trust-on-first-use (TOFU);

- out-of-band verification;

- approccio delegato;

=== Trust-on-first-use

Una volta instaurata la connessione si assume che il canale sia
#strong[sicuro] e quindi si usa questo stesso canale per scambiare la
chiave pubblica.

Il protocollo SSH utilizza questo paradigma.

Il canale deve essere sicuro rispetto ad attacchi #strong[attivi] (es.
di tipo man-in-the-middle), non è invece necessario che lo sia rispetto
ad attacchi #strong[passivi].

=== Out-of-band verification

In questo scenario ci sono 2 canali: uno insicuro ed uno sicuro.
Trasmettere informazioni sul canale sicuro è molto più costoso rispetto
al canale insicuro.

Esempio: Whatsapp. La chat è il canale insicuro, mentre il canale
\"sicuro\" sarebbe quello \"fisico\" (una persona mostra all'altra il QR
code con la sua chiave pubblica).

=== Approccio delegato

In questo scenario c'è un'#strong[entità terza] che garantisce
l'autenticità delle chiavi pubbliche.

Questo approccio può essere:

- centralizzato, se c'è una sola entità che ha il compito di garantire
  l'autenticità delle chiavi (es. PKI, Public Key Infrastructure);

- distribuito, se ci sono più entità con questo compito (es. OpenPGP)

Entrambi gli interlocutori devono fidarsi di queste entità terze.

#figure([#image("images/723979fc707bf2d56dae3ae2d63572d6.png", width: 100%)],
  caption: [
    Scambio di chiavi con PKI
  ]
)

+ Bob invia ad Alice una chiave simmetrica firmata digitalmente con la
  chiave pubblica di Bob, la quale è firmata a sua volta dalla
  certification authority;

+ Alice verifica che la chiave simmetrica ricevuta da Bob sia autentica
  controllando la chiave pubblica con cui è stata firmata;

+ Alice verifica che la chiave pubblica sia autentica controllando la
  firma della CA

=== Certificati

Con #strong[certificato] s'intende una chiave pubblica con diversi
#strong[metadati] associati (es. validità, dominio, ecc.).

I certificati vengono rilasciati dalle certification authority.

I mantainer dei browser includono all'interno del browser stesso i
certificati delle CA.

#figure([#image("images/e9232d9724f41f45e65c903dda60c533.png", width: 100%)],
  caption: [
    Flusso di messaggi
  ]
)

Con questa strategia si utilizzano poche chiavi pubbliche (quelle delle
CA) per autenticarne tante.

Le CA sono organizzate in modo gerarchico:

#figure([#image("images/63f0568f637d502a45f65081dbb51cb7.png")],
  caption: [
    Struttura gerarchica delle CA
  ]
)

Le CA intermedie sono quelle che firmano i siti finali. Le firme delle
CA intermedie sono a loro volta firmate dalle root CA, che sono le
uniche effettivamente salvate nel browser.

Quando un client si connette ad un server, la PKI prevede che il server
invii una #strong[catena di certificati] che permette al client di
verificare l'autenticità della chiave pubblica del server.

==== Self-signed certificates

Certificati in cui la firma digitale coincide con la chiave pubblica del
certificato stesso. Non c'è nessuna certification authority.

== Stack di protocolli sicuri

Esistono diversi protocolli sicuri per supportare diversi scenari:

- half-duplex o full-duplex;

- comunicazione a singoli o a gruppi;

- comunicazioni sincrone o asincrone;

- ...

Ad ogni livello dello stack TCP/IP esistono diversi protocolli sicuri
per garantire #strong[confidenzialità] ed #strong[autenticità].

Più il protocollo sicuro viene inserito in alto nello stack e più la
protezione è \"completa\":

- se il protocollo sicuro è usato al livello 2, la comunicazione è
  sicura solo all'interno della rete locale;

- se il protocollo sicuro è usato a livello 4, la comunicazione è sicura
  solo fino al livello applicativo;

- ...

ma più si scende nello stack e più informazioni si riescono a nascondere
(es. se si vogliono cifrare IP sorgente/destinazione bisogna agire a
livello 3).

=== Protocollo MACSec

Protocollo molto recente che garantisce l'autenticità dei messaggi
Ethernet.

L'obiettivo di questo protocollo è implementare dei forti controlli
d'accesso su reti Ethernet cablate.

Problema: se ci sono delle prese di rete libere, chiunque può
connettersi. \
Soluzione semplice: si gestisce una #strong[white list] di MAC address
autorizzati a connettersi. Il MAC address però può essere modificato
dall'amministratore di sistema, rendendo inutile questa white list. \
Soluzione corretta: si utilizza il protocollo MACSec.

Il protocollo MACSec è implementato dagli switch.

=== IPSec

Protocollo di livello 3, estensione di IP.

Contiene 2 sotto-protocolli:

- #strong[transport mode]: crea una connessione sicura a livello 3 tra
  due nodi;

- #strong[tunnel mode]: crea una connessione sicura a livello 3 tra due
  reti. Tutte le informazioni di livello 3 vengono incapsulate da un
  altro pacchetto IP e rimangono in chiaro solo i gateway delle 2 reti.

=== Protocolli sicuri a livello trasporto

IPSec e MACSec sono delle #strong[estensioni] di IP ed Ethernet.

A livello 4 invece si creano dei protocolli #strong[aggiuntivi] che si
mettono sopra egli esistenti TCP ed UDP:

#figure([#image("images/dc8412d5ea4396edecccdefd7d7abfae.png")],
  caption: [
    Protocolli sicuri a livello 4
  ]
)

Nel caso di TLS:

- prima ci si connette con TCP, nel solito modo;

- poi ci si connette in TLS

Le versioni di TLS precedenti alla 1.2 sono considerate insicure. Anche
la versione 1.2, sebbene sia considerata sicura, al suo interno potrebbe
usare dei cifrari non più sicuri. È opportuno quindi configurarla
correttamente.

DTLS offre, opzionalmente, funzionalità per proteggersi dai replay
attack.

==== Handshake TLS

+ scambio di metadati (es. versione di TLS, cifrari supportati, ecc.);

+ server key exchange e authentication (il server invia i propri
  certificati);

+ client key exchange e authentication. L'autenticazione del client è
  opzionale (es. in HTTPS il client non è mai autenticato);

+ fine

Quando è attivata anche l'autenticazione del client si parla di
#strong[mutual authentication] (MTLS). La connessione è autenticata in
entrambe le direzioni.

==== Downgrade attack

Attacco con cui l'attaccante \"costringe\" client e server ad utilizzare
una versione di TLS non più sicura.

I downgrade attack sono il motivo per cui si consiglia sempre di
#strong[disabilitare completamente] le versioni insicure di TLS (che
invece spesso vengono lasciate attive per ragioni di
retrocompatibilità).

=== Protocolli applicativi sicuri

Si possono distinguere in 2 famiglie:

- quelli che usano il protocollo insicuro mettendoci sopra TLS (es.
  HTTPS, FTPS, ecc.);

- quelli che non usano TLS e si re-inventano il layer di comunicazione
  sicuro (es. SSH)

#figure([#image("images/4fa3342390a7732cc1cab712f3b75967.png", width: 100%)],
  caption: [
    Protocolli insicuri con sopra TLS
  ]
)

#figure([#image("images/34491a1c1e1224170bafcb73e718e87b.png", width: 100%)],
  caption: [
    Protocolli sicuri nativi
  ]
)

== HTTPS e virtual hosting

In HTTPS viene cifrato tutto il contenuto della request HTTP.

In realtà però l'#strong[hostname] a cui ci si connette viene lasciato
in chiaro, perché altrimenti:

- i web server non sarebbero più in grado di fare #strong[virtual
  hosting];

- i web server non saprebbero che certificato restituire al client

L'hostname in chiaro lo si trova nel campo #strong[Server Name
Indication] (SNI) di TLS.L

Lasciare l'hostname in chiaro presenta diversi problemi di privacy. Per
queste ragioni sono allo studio diversi standard che permettono di
cifrarlo.

= Posta elettronica

== Indirizzi email

#block[
`username "@" domain`

]
- 64 caratteri al massimo per lo username. Secondo lo standard dovrebbe
  essere case-sensitive, ma ogni mail provider fa come gli pare;

- 255 caratteri al massimo per il dominio, che deve rispettare tutte le
  regole del DNS

== Affidabilità e sicurezza

Il sistema email è stato pensato agli inizi degli anni '70, quindi la
sicurezza non è stata minimamente presa in considerazione.

Rischi del sistema email:

- email false;

- mittenti che si spacciano per altri (#strong[message spoofing])

- phishing;

- URL insicure;

- allegati malevoli;

- ...

La protezione da queste vulnerabilità è resa difficile anche dalla
#strong[decentralità] del sistema email (ci sono tanti attori in gioco e
ognuno dev'essere libero di fare quello che gli pare).

== Elementi architetturali del protocollo email

- mail transfer agent: componente del mail server che si occupa
  dell'invio e della ricezione delle email. A seconda dei contesti si
  può scomporre in #strong[mail submission agent] (ricezione) e
  #strong[mail delivery agent] (invio);

- mail user agent: componente che gestisce le email lato utente (e.g.
  client di posta);

Protocolli usati nel sistema email:

- #strong[SMTP] (Simple Mail Transfer Protocol): usato per il
  trasferimento dei messaggi di posta. Il protocollo SMTP viene usato
  sia per la comunicazione client $arrow.r$ server, sia per la
  comunicazione server $arrow.r$ server. Al giorno d'oggi si usa quasi
  sempre SMTP con TLS, soprattutto nella comunicazione client $arrow.r$
  server;

- #strong[POP]: famiglia di protocolli usati dal client. Si tratta di
  protocolli molto semplici che permettono solo il download delle email
  dal server;

- #strong[IMAP]: altro protocollo usato dal client, più complesso
  rispetto a POP. Oltre al download, IMAP permette una
  #strong[sincronizzazione] tra client e server (es. email lette,
  etichette, cartelle, ecc.);

- HTTP: indipendente dal sistema email. Al giorno d'oggi è usato dagli
  end-user per interagire con il #strong[client web] di posta (es.
  Gmail).

Il mail server gestisce l'invio di messaggi con una #strong[coda].

Esempio di comunicazione end-to-end:

#figure([#image("images/f3bc5d4d3dbf3f38ac698bfb637c7b84.png")],
  caption: [
    Comunicazione tra due utenti tramite sistema email
  ]
)

== Architettura di un mail server

#figure([#image("images/cb74af9f64f129d9bcfc08b1d8b9d98f.png", width: 100%)],
  caption: [
    Architettura di un mail server multi-utente
  ]
)

La coda di messaggi in uscita viene chiamata #strong[spool].

Oggi i mail server tipicamente gestiscono anche un #strong[database di
utenti].

== Interazione con il DNS

Il dominio degli indirizzi email è gestito dal DNS.

Il sistema email è fortemente decentralizzato. Non esiste un punto
univoco che elenca #strong[tutti] gli indirizzi email presenti sul
pianeta.

Se Google deve mandare un'email a Libero, la 1° cosa che deve fare è
capire #strong[a quale host] inviare la mail. Google dovrà quindi
interrogare il DNS per recuperare il record #strong[MX] associato a
Libero.

Il record MX del DNS espone i nomi dei server da usare per
#strong[inviare] email a colui che espone il record MX stesso. I record
MX quindi vengono usati nella comunicazione server $arrow.r$ server.

Nel caso di comunicazione client $arrow.r$ server, invece, il client non
legge il record MX del server ma una #strong[configurazione manuale]
fatta dall'utente.

== Protocollo SMTP

Protocollo con paradigma client-server per #strong[inviare] email.

Utilizza TCP come protocollo trasporto.

La comunicazione in SMTP è composta da diverse fasi (non è ad esempio
come HTTP che è un protocollo request-response). Si tratta quindi di un
protocollo #strong[stateful].

#figure([#image("images/26fbe78a5665b86b3bcad55df6250e2c.png")],
  caption: [
    Comunicazione server $arrow.r$ server con SMTP
  ]
)

SMTP prevede che il 1° messaggio venga inviato dal server, per
presentarsi al client. Questo messaggio (presente anche in altri
protocolli, es. FTP ed SSH) viene chiamato #strong[banner].

SMTP è un protocollo #strong[testuale], come HTTP.

Nella comunicazione client $arrow.r$ server con SMTP è sempre presente
anche una fase di #strong[autenticazione]. Per poter inviare email, il
client dev'essere autenticato.

Nella comunicazione server $arrow.r$ server invece non c'è mai una fase
di autenticazione, perché impossibile da gestire a causa della
decentralità del sistema email. È molto facile quindi fare attacchi di
tipo email spoofing nella comunicazione tra server.

== Formato del messaggio SMTP

SMTP è un protocllo testuale in cui sono accettati solo caratteri ASCII
7 bit.

Per gestire altre tipologie di messaggi si utilizza il protocollo
#strong[MIME].

== Email sicure

Uno dei problemi di sicurezza principali del sistema email è l'email
spoofing: nella comunicazione server $arrow.r$ server, il server
mittente può spacciarsi per un altro server senza che il server
destinatario abbia modo di accorgersene.

Il record MX usato nella comunicazione server $arrow.r$ server permette
di capire a chi inviare le email, ma non permette al server destinatario
di verificare che il server mittente sia realmente chi dice di essere.

Nei protocolli moderni esistono tante estensioni per la sicurezza. Non
tutti i mail provider supportano tutte queste estensioni.

La sicurezza delle nostre email dipende #strong[esclusivamente] dal
provider utilizzato.

Tutte queste estensioni vanno ad interfacciarsi sempre con il DNS, che
viene usato anche per verificare da dove vengono i dati ricevuti da un
mail server.

=== SPF

Protocollo che prevede che il mail server di destinazione possa
controllare che il mail server mittente sia effettivamente autorizzato
ad inviare email per un certo dominio.

- chi gestisce il dominio del mittente deve inserire nel proprio DNS dei
  record #strong[TXT] che contengono gli #strong[indirizzi IP] dei
  server autorizzati ad inviare email per conto di quel dominio;

- il mail server destinazione deve fare una query TXT al proprio DNS per
  verificare se l'IP del server da cui gli è arrivata la mail è
  abilitato ad inviare email per conto di quel dominio

È importante capire che il protocollo SPF protegge #strong[il mittente]:
è chi NON espone questi record TXT a rendersi vulnerabile ad email
spoofing.

Il protocollo SPF, come tutte le altre estensioni per la sicurezza, è
#strong[facoltativo]. I mail server non sono tenuti ad implementarlo.

Se la validazione fatta dal destinatario fallisce, ciò che succede
dipende dal mail provider.

- alcuni decidono di scartare del tutto la mail;

- altri la accettano comunque e possono decidere se dare un feedback
  all'utente

=== DKIM

Molto simile ad SPF, ma i record TXT esposti dal mail server mittente
non contengono degli indirizzi IP ma delle #strong[chiavi pubbliche].

- il mail server mittente firma il messaggio con la propria firma
  digitale;

- il mail server destinatario fa una query TXT al DNS per verificare la
  firma

È più sicuro di SPF (è più difficile falsificare una firma digitale
piuttosto che un indirizzo IP), ma è anche più oneroso.

Permette anche una flessibilità maggiore rispetto ad SPF nel caso in cui
sia molto difficile enumerare gli IP dei mail server autorizzati. Nel
caso di tanti mail server, infatti, con DKIM è sufficiente avere un
unico mail server finale che si occupa di firmare i messaggi.

Al giorno d'oggi SPF è dato per scontato, mentre DKIM è ancora piuttosto
raro.

=== Sicurezza end-to-end

Se l'utente non vuole affidarsi al mail provider per la sicurezza,
esistono anche dei protocolli che permettono di gestirla a livello
end-to-end.

==== S/MIME

Estensione del protocollo MIME per gestire #strong[firma] e
#strong[cifratura] delle email, oltre che la codifica.

S/MIME si interfaccia con il sistema PKI. Ogni utente possiede:

- un certificato rilasciato da una certification authority;

- una (o due) coppia di chiavi asimmetriche per firmare e cifrare i
  messaggi

==== PGP - Pretty Good Privacy

Protocollo molto simile a S/MIME, ma che non si interfaccia con il
sistema PKI. Anch'esso si basa comunque su firma e cifratura tramite
chiavi asimmetriche.

È stato pensato principalmente per contesti decentralizzati (es.
sviluppo open source).

== PEC - Posta Elettronica Certificata

Sistema esistente solo in Italia per aggiungere garanzie di autenticità
alle email.

La PEC è solo autenticata. Non supporta la cifratura.

Lo scopo principale della PEC è dare #strong[garanzia legale] (in
particolare #strong[non repudiabilità]). La cifratura non è supportata
perché a livello legale è più comodo avere i messaggi in chiaro.

Gli schemi di firma usati dalla PEC sono gli stessi di S/MIME, ma non
viene implementata la parte legata alla cifratura.

Esiste una lista ben precisa di mail provider PEC autorizzati.

Il protocollo S/MIME viene esteso dalla PEC per garantire l'autenticità
anche della #strong[ricevuta] del messaggio (cosa che nell'email
originale non esiste). In realtà la conferma di ricezione è inviata dal
mail server, non dall'utente finale destinatario (che potrebbe non aver
ancora visto l'email). Tuttavia, a livello legale, si suppone che dopo 2
settimane l'utente destinatario abbia letto la PEC, se il suo mail
server ha inviato la ricevuta.
