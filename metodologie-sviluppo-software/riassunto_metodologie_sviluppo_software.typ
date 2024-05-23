#set page(paper: "a4")
#set par(leading: 0.55em, justify: true, linebreaks: "optimized")
#set text(font: "New Computer Modern", lang: "it")
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

#set page(
  footer: context [
    #set text(10pt)
    #table(
      stroke: none,
      columns: (1fr, 1fr, 1fr),
      align: (left, center, right),
      inset: (x: 0pt, y: 5pt),
      [#link("https://github.com/rickysixx/unimore-informatica")[#text(fill: blue)[rickysixx/unimore-informatica]]], [Metodologie di sviluppo software], [a.a. 2023-2024]
    )
    #set align(center)
    
    #counter(page).display(
      "1 of 1",
      both: true,
    )
  ]
)

#outline(
    indent: auto
)

= Modelli e metodologie

Attività principali del processo di sviluppo di un software:
+ raccolta e definizione dei *requisiti*;
+ design dell'architettura;
+ implementazione;
+ *test* e validazione;
+ *manutenzione* ed evoluzione

Un *modello* di sviluppo del software è una *rappresentazione astratta* del processo.

I modelli più noti sono:
- modello a cascata
  - *separa chiaramente* le varie attività del processo;
- component-based
  - si cotruisce il sistema mettendo insieme vari componenti
- modelli *iterativi*
  - modello evolutivo
  - modello incrementale
- transformational model

== Modello a cascata

#figure(
  image("assets/0a79073b28bd66c0d2305d3893839c01.png"),
  caption: [Modello a cascata]
)

#figure(
  table(
    columns: (auto, auto),
    align: (left, left),
    [*Vantaggi*], [*Svantaggi*],
    [
      - le fasi del processo sono *ben definite*;
      - è facile *stimare i costi*;
      - si può adattare a qualunque tipologia di progetto
    ], [
      - poca flessibilità, le fasi sono definite in modo molto rigido;
      - questa rigidità rende questo modello molto problematico in caso di *cambiamenti* (es. ai requisiti)
    ]
  ),
  caption: [Vantaggi e svantaggi del modello a cascata]
)

#pagebreak(weak: true)
== Modello component-based

Si mettono insieme *componenti già esistenti*.

Nonostante il vantaggio (teorico) dovuto al *risparmio di tempo* perché si riciclano componenti già esistenti, questo modello è raramente utilizzato nel mondo reale per una serie di svantaggi:
- è molto difficile riuscire a riciclare componenti già esistenti per scopi diversi da quelli per cui sono stati pensati;
- ci sono frequenti *problemi d'integrazione*;
- le specifiche devono essere riadattate ai componenti già esistenti (quando dovrebbe essere il contrario)

== Modelli iterativi

A differenza dei modelli precedenti, i modelli iterativi eseguono *più volte* la stessa attività. L'obiettivo è rendere il processo meno rigido e dunque più resistente ai cambiamenti che avvengono in corso d'opera.

Lo svantaggio principale di questi modelli è che non si ha una visione ben chiara della *fine*, dunque è *difficile stimare i costi*.

=== Modello evolutivo

#figure(
  image("assets/2e1bb8a1530d4a35ee7d8ddb1c36a7b7.png", height: 40%),
  caption: [Modello evolutivo]
)

Il progetto si *evolve nel tempo*:
+ si parte da un *prototipo piccolo*;
+ si valida il prototipo;
+ si estende il prototipo precedente, si valida e così via

I prototipi devono essere *usa e getta*, in modo da poter riadattare lo sviluppo in caso di cambiamenti nei requisiti.

Questo modello si presta bene nei casi in cui il progetto viene fatto su *sistemi già noti* al team di sviluppo.

Può essere usato anche per sviluppare *piccole parti* di un sistema più grande.

=== Modello incrementale

#figure(
  image("assets/9150cd6723b46717eca2fa56f154414a.png"),
  caption: [Modello incrementale]
)

+ ad ogni requisito è associata una *priorità*;
+ il progetto viene costruito requisito per requisito, in ordine di priorità, in modo incrementale;

Al termine di ogni incremento si esegue sempre una fase di *verifica*.

Questo modello permette al cliente di avere il prima possibile le funzionalità a cui tiene di più.

=== Modello evolutivo vs modello incrementale

Nel modello evolutivo si parte da un *prototipo base* e si raffina sempre di più il risultato, fino ad ottenere il prodotto finale.

Nel modello incrementale invece ogni incremento si considera come *già definitivo* (salvo cambiamenti nei requisiti ovviamente).

#figure(
  image("assets/b2abf51d67d4cbba806316724a605de8.png", height: 31%),
  caption: [Modello evolutivo vs modello incrementale (by Jeff Patton)]
)

== Transformational model

Modello *teorico* che si basa su *metodi formali* per:
+ raccogliere requisiti;
+ trasformare i requisiti in codice

Questo modello rende gran parte del processo di implementazione *automatico*, ma è molto difficile da implementare nel mondo reale.

== Confronto tra i modelli

#figure(
  image("assets/823c03f230747a0dc8e4a9488e466567.png"),
  caption: [Confronto tra i modelli di sviluppo]
)

== Unified process (UP)

Si tratta di un vero e proprio *standard industriale*, nato negli anni '60. Di fatto è un *modello iterativo* (incrementale).

Ogni incremento può essere:
- additivo (si *aggiungono* funzionalità);
- perfettivo (si perfezionano funzioalità già esistenti)

Questo modello prevede di fare una *release* al termine di ogni iterazione.

#figure(
  image("assets/4ecd2b5b28b3f9ebaad56d99eec0c452.png"),
  caption: [Fasi di unified process]
)

UP ha gettato le basi di quelle che saranno poi le *metodologie agile*.

= Agile

Motivi per cui è nato:
- rigidità dei modelli di sviluppo usati al tempo (2001);
- si perdeva molto tempo nella produzione di documenti non tecnici (liste di requisiti, documentazione, specifiche, ecc.) che poi si rivelavano totalmente inutili (sia perché i requisiti cambiano in corso d'opera, sia perché molto spesso ci si accorge che alcune specifiche concordate all'inizio successivamente diventano non più rilevanti)

L'idea alla base di agile è che lo sviluppo di software è un *lavoro creativo* in cui la *comunicazione* è fondamentale, perciò i modelli industriali non sono utilizzabili.

== Agile manifesto

- *individuals* and *interactions* over processes and tools;
- *working software* over comprehensive documentation;
- *customer collaboration* over contract negotiation;
- *responding to change* over following a plan

== 12 principi agile

+ *soddisfare il cliente* ha la massima priorità;
+ accettare i *cambiemtni*;
+ effettuare *rilasci frequenti*;
+ business e sviluppatori devono *lavorare insieme*;
+ dare ad ogni individuo tutti gli strumenti di cui ha bisogno per portare a termine il lavoro;
+ preferire discussioni faccia a faccia piuttosto che lunghe pagine di documentazione;
+ il progresso del progetto si misura in termini di *software che funziona*;
+ i processi agile devono promuovere uno *sviluppo sostenibile* del progetto (non si deve andare di corsa);
+ si presta attenzione sia al design che alla parte tecnica;
+ si prediligono *soluzioni semplici*;
+ si prediligono team auto-organizzati, cioè in cui il lavoro da fare viene gestito autonomamente dal team;
+ si effettuano *riflessioni periodiche* al fine di migliorare il proprio lavoro

== Metodologie agile

- test-driven development (TDD);
- pair programming;
- refactoring;
- cross-functional team;
- timeboxing;

=== Pair programming

Il *driver* scrive il codice, mentre il *navigator* controlla e suggerisce. I ruoli vengono scambiati frequentemente.

Studi hanno dimostrato che a fronte di una riduzione del 15% della velocità di sviluppo, fare uso di pair programming *riduce la presenza di bug* nel codice del 50%.

#pagebreak(weak: true)
=== Refactoring

Si modifica il codice al fine di renderlo *più semplice da capire* (o da modificare), senza alterarne il comportamento visibile.

Quando *non* fare refactoring:
- quando il codice è talmente messo male che si fa prima a buttarlo via e riscriverlo da capo;
- quando si è un prossimità di una *scadenza*
  - fare refactoring in questo momento sarebbe inutile perché i benefici si avrebbero *dopo* la scadenza

=== Cross-functional team

Ogni membro del team può svolgere più funzioni. In particolare, la stessa persona può svolgere funzioni diverse in base alle necessità del momento. Questo permette alle persone di *lavorare in parallelo*.

In questi team non c'è un "capo" che assegna ad ognuno le attività da svolgere, ma ognuno si auto-organizza.

=== Timeboxing

Si definisce un *tempo prestabilito* per portare a termine un'attività.

Permette di definire in anticipo e con chiarezza i costi, ma non è sempre applicabile.

=== User stories

Una user story è una descrizione di quello che un utente si aspetta di fare con un software.

Permettono di raccogliere requisiti in modo *rapido e informale* direttamente dagli utenti.

Le user stories sono derivate dagli *epic*, che definiscono un requisito in modo più generale.

Le user stories non sono da confondere con gli *use case*:
- una user story descrive cosa l'utente vuole dal software;
- uno user case rappresenta una generica *interazione* tra il sistema e l'utente

In particolare gli use case *non definiscono i risultati* che l'utente vuole, ma solo il funzionamento dell'interazione col sistema.

#figure(
  table(
    columns: (auto, auto),
    align: (left, left),
    [*Vantaggi*], [*Svantaggi*],
    [
      - incentivano l'*interazione* (attività fondamentale nelle metodologie agile) tra utenti e sviluppatori;
      - facilitano la raccolta dei requisiti
    ], [
      - i requisiti raccolti possono essere *molto vaghi*, perché provengono direttamente dagli utenti;
      - difficile raccogliere *requisiti non funzionali* (es. di sicurezza o di performance)
    ]
  ),
  caption: [Vantaggi e svantaggi delle user stories]
)

== Successo e problematiche delle metologie agile

Le metodologie agile non sono adatte a tutti i contesti. In particolare si evidenzia come queste funzionino peggio su *progetti grandi* e/o con team di sviluppo *distribuiti* (che porta quindi ad avere *meno interazione*).

Per funzionare, le metodologie agile devono essere applicate bene e per farlo è richiesta *molta esperienza*. Sono quindi poco adatte a contesti in cui la maggior parte del team è inesperto.

= Metodologie agile

== Agile Unified Process

Deriva dalla metodologia Unified Process. Nella versione agile, le iterazioni durano meno e i rilasci sono più frequenti.

Principi:
- semplicità;
- aderenza ai principi e ai valori agile;
- *indipendenza dai tool*;

== Scrum

Il processo di sviluppo del software viene diviso in iterazioni chiamate *sprint*, ciascuna lunga 4 settimane circa. Al termine di ogni sprint si ha un *prodotto funzionante*.

Nella fase di design si raccoglie una *lista sintetica* di requisiti, es. tramite user stories.

#figure(
  table(
    columns: (auto, 1fr),
    align: (center + horizon, left + horizon),
    [*product owner*], [
      - interagisce con gli *stakeholders*;
      - prende le decisioni *strategiche* (decide cosa fare, ma non come farlo);
    ],
    [*scrum master*], [
      - ha un ruolo manageriale;
    ], 
    [*team di sviluppo*], [
      - è auto-organizzato e multi-funzionale;
      - prende le decisioni operative (decide come realizzare un'attività lato implementativo)
    ]
  ),
  caption: [Ruoli scrum]
)

=== Meetings

Come in tutte le metodologie agile, anche in scrum si dà molta importanza alla comunicazione face-to-face. Per questo motivo sono previste diverse tipologie di meeting.

==== Sprint planning

Si fa all'inizio dello sprint per definire le attività che il team di sviluppo deve realizzare nello sprint stesso. 

L'elenco prodotto in questo meeting prende il nome di *sprint backlog*.

A questo metting partecipano *tutti i ruoli* di scrum.

==== Daily scrum

Come dice il nome, si tratta di un incontro fatto *ogni giorno* durante lo sprint.

Si parla di:
- cos'è stato fatto nel giorno precedente;
- cosa si farà oggi;
- quali problemi sono stati riscontrati e quali si prevedono di dover affrontare

L'obiettivo di questo meeting è *esporre i problemi* a tutti i membri del team. Non è invece compito di questo meeting cercare di *risolvere* i problemi evidenziati.

Tutti i ruoli scrum partecipano a questo meeting.

==== Backlog grooming

Si valutano i requisiti contenuti nel backlog, ad esempio in caso di un cambiamento.

Questo meeting è riservato ai membri del team di sviluppo.

=== Scrum of scrum

Si utilizza per avere una comuicazione *inter-team*.

All'incontro partecipa 1 persona per ogni team.

=== Sprint review

Si mostrano i *risultati* dello sprint al cliente e agli stakeholders.

Tutte le persone coinvolte partecipano al meeting.

=== Sprint retrospective

Si valuta cos'è stato fatto nello sprint precedente, quali sono stati i punti di forza e debolezze, al fine di migliorare il proprio modo di lavorare.

A questo meeting partecipano lo scrum master e i membri del team di sviluppo.

== Scrum artifacts

=== Product backlog

Lista di requisiti del prodotto, *ordinata per priorità*. È compito del product owner date una priorità ad ogni requisito.

Gli elementi di questa lista vengono chiamati *product backlog items*.

Tutti possono *leggere e modificare* questa lista, ma è il product owner che ha il compito di gestirla.

Questo elenco rappresenta sostanzialmente *quello che c'è ancora da fare* per portare a termine il progetto.

=== Sprint backlog

Elenco di attività da completare *entro lo sprint corrente*, derivato dal product backlog.

Ogni attività è divisa in *task*. Idealmente, ogni task dev'essere portato a termine entro un giorno lavorativo.

I membri del team *prendono autonomamente i task*, non gli vengono assegnati da qualcuno.

Per tenere traccia dei vari task si usa una *task board*.

=== Increment

Somma di tutti i product backlog items completati durante lo sprint corrente e quelli precedenti.

In altre parole: cos'è stato fatto finora (a partire dall'inizio del progetto).

=== Burn down

Grafico che mostra il *lavoro rimanente* per portare a termine il progetto:
- backlog nell'asse $y$;
- tempo nell'asse $x$

#pagebreak(weak: true)
== Feature-driven development

L'attività di sviluppo si divide in 5 attività, basate sulle *funzionalità* che devono essere implementate:
+ si definisce un modello generale, che dev'essere *completo quanto basta* per poter cominciare il lavoro (non serve che sia perfetto);
+ si costruisce una *feature list*
  - ad ogni feature viene associato un *business value*;
  - ogni feature dev'essere indicata nela forma `<azione>` $->$ `<risultato>` $->$ `oggetto` (es. `calcola il totale della fattura`);
  - la feature list viene costruita in modo *collaborativo*;
  - si adotta *timeboxing* (non più di due settimane per completare la feature list);
+ pianificazione by feature
  - ogni feature viene assegnata ad un *chief programmer*, che ne diventa responsabile
    - il chief programmer divide il lavoro da fare in task ed assegna ogni task ad un programmatore
+ design by feature
  - si costruisce il design della feature da implementare;
  - il chief programmer definisce l'elenco di feature da realizzare nell'iterazione corrente
+ sviluppo

Le fasi 1, 2 e 3 vengono fatte *una sola volta*, all'inizio dell'iterazione, mentre le fasi 4-5 vengono ripetute più volte nella stessa iterazione.

Ognuna di queste fasi produce un *artifact* che permette di passare alla fase successiva.

== Dynamic System Development Model

Evoluzione agile del modello RAD (Rapid Application Development). Si basa su *poca pianificazione* e *rapido sviluppo*.

È un modello di tipo *iterativo incrementale*.

Tutte le modifiche fatte in fase di sviluppo devono essere *reversibili*, in modo da adattarsi ad eventuali cambiamenti.

Applica la *regola 80/20*: l'80% del software è costituito dal 20% dei requisiti.

#figure(
  image("assets/4516919ac6e0b7a216ae2c53881be5a7.png", height: 34%),
  caption: [Fasi di DSDM]
)

La fase iniziale di studio prevede sia uno *studio di fattibilità* (per stimare i costi e i rischi), sia un *business study* per capire i requisiti principali del progetto.

Per stabilire le priorità dei requisiti si usa l'*approccio MoSCoW*. Ogni requisito rientra in una categoria fra:
- *must*: la funzionalità è indispensabile;
- *should*: la funzionalità deve esserci, ma non è il core del progetto;
- *could*: la funzionalità può essere inserita solo se non interferisce con altre funzionalità più importanti;
- *won't*: la funzionalità *non deve esserci* nel progetto. In futuro si potrebbe riconsiderare questa scelta.

== Extreme programming

2 obiettivi principali:
+ organizzare il lavoro in modo da produrre *software di qualità* nel *minor tempo possibile*;
+ ridurre i costi dovuti a *cambiamenti nei requisiti*

Le attività principali di XP sono:
+ codicng
  - secondo XP, *il codice è l'unica cosa che conta* e dev'essere usato anche come forma di *comunicazione*
+ testing;
+ ascolto dei *feedback* da parte del cliente e degli utenti;
+ design in caso di progetti particolarmente complessi

XP si basa su una serie di *valori* (comunicazione, semplicità, feedback, coraggio e rispetto).

In XP il cliente viene considerato *parte del team* e definisce sia gli obiettivi che le *priorità* del progetto.

Ogni membro del team dev'essere in grado di *misurare il progresso* del proprio lavoro rispetto agli obiettivi.

Nel proprio metodo di lavoro, XP adotta diversi principi importanti:
- YAGNI (You Aren't Gonna Need It): si scrive solo il codice strettamente indispensabile per implementare una funzionalità;
- collective ownership: tutto il codice è di tutti, in particolare chiunque può modificare il codice scritto da chiunque altro
- *continuous integration*: le nuove modifiche al codice devono essere integrate il prima possibile nella code base;
- le release devono essere *piccole e frequenti*. Il cliente dev'essere in grado di misurare il progresso del progetto tramite le release.

== Agile modeling

Nonostante le metodologie agile si concentrino più sulla parte di codice, anche il *design* è un aspetto fondamentale dello sviluppo agile.

Il design agile è basato sui soliti principi:
- semplicità, comunicazione, feedback rapido (lavorando a stretto contatto col cliente);
- massimizzazione del ROI per gli stakeholders
- avere come obiettivo un *software funzionante*;
- le modifiche devono essere *incrementali* e reversibili

L'agile modeling usa la tecnica del *model storming*: quando si ha un problema si coinvolgono le altre persone.

La modellazione dev'essere *sufficiente quanto basta* per realizzare il task che si ha in carico. No ad over-engineering.

La modellazione dev'essere fatta *in anticipo* rispetto al punto in cui si trovano gli sviluppatori, in modo da prepararsi a problemi che possono sorgere.

#figure(
  table(
    columns: (auto, auto),
    align: (center + horizon, left + horizon),
    [*document late*], [
      - si documenta tutto alla fine;
      - permette di procedere rapidamente con gli sviluppi, ma si avrà un grosso picco alla fine a causa della documentazione da scrivere
    ], 
    [*document continuously*], [
      - si documenta man mano;
      - permette di avere un ritmo più costante e senza picchi
    ]
  ),
  caption: [Approcci alternativi per gesitre la documentazione con agile modeling]
)

== Confronti tra i modelli agile

#figure(
  image("assets/832b1e91af6d8d26ef6abea7c0553330.png"),
  caption: [Tecniche agile utilizzate]
)

#figure(
  image("assets/7abcf5acb5fa50f62a468cd912ee866a.png"),
  caption: [Attività della fase di sviluppo]
)

#figure(
  image("assets/18c1d9b3992d97207413b109611e3120.png"),
  caption: [Attività della fase di design]
)

= Project estimation

Obiettivo: stimare il tempo necessario per completare il software, sia per la parte di sviluppo che per tutte le altre fasi.

Queste stime ci interessano perché i costi di un progetto sono proporzionali al tempo impiegato per realizzarlo.

Si indica con $t_d$ il *delivery time*, ovvero il tempo necessario per consegnare il prodotto al cliente.

I *cost driver* sono dei fattori che influiscono sul costo del progetto. I requisiti sono un chiaro esempio di cost driver.

L'attività di stima può dare altre informazioni utili oltre al tempo, quali:
- effort necessario (quanto il team deve correre);
- personale necessario (skill richieste, numero di persone da coinvolgere);
- GANNT chart e person-month chart

Spesso nel mondo software si usa un *falso mito*: più persone che ci lavorano e meno è il tempo richiesto. Questo mito è ovviamente falso perché non tiene conto del fatto che sviluppare software è un *lavoro creativo*.

È importante stimare anche i costi *post-development*:
- manutenzione;
- assistenza tecnica;
- *service level agreement* (SLA)

== Modello algoritmico

La stima è fatta da un *algoritmo* che considera molti fattori (dimensioni del progetto, tipologia, costi precedenti per progetti simili, ecc.).

#figure(
  table(
    columns: (auto, auto),
    align: (left, left),
    [*Vantaggi*], [*Svantaggi*],
    [
      - molto accurato;
      - indipendente da eventuali contingency;
    ], [
      - per essere accurato richiede *tanti* dati;
      - il caolcolo è molto complesso
    ]
  ),
  caption: [Vantaggi e svantaggi del modello algoritmico]
)

== Approccio guru

La stima è a carico di un esperto ("guru"), che la fa sostanzialmente in base alla propria *esperienza*.

Questo approccio costa molto poco, ma ha lo svantaggio di essere un metodo *empirico* e potenzialmente *poco accurato* (se l'esperto non è un vero esperto).

== Stima per analogia

Si cerca di confrontare il progetto da stimare con altri progetti realizzati precedentemente, in modo da capirne i costi.

Naturalmente è impraticabile quando non si hanno progetti confrontabili con cui comparare i dati.

== Legge di Parkinson

Il progetto costa esattamente quanto *tutte le risorse disponibili*: se si hanno 6 mesi di tempo, il progetto costerà 6 mesi di tempo.

Nel mondo reale questa tecnica è poco utilizzabile, perché le risorse stabilite all'inizio si rivelano spesso *insufficienti*.

== Pricing to win

Il progetto costa tanto quanto il cliente è disposto a pagare.

Rispetto alle altre tecniche, questa prevede un *contratto ben definito* con il cliente.

Questo approccio è il meno soddisfacente per il cliente, che molto probabilmente si ritroverà con un sistema che non lo soddisfa.

Quello che il cliente può/vuole pagare non sempre riflette bene i costi del progetto.

== Come si procede nella pratica

Se ci sono dati a disposizione si usa l'approccio algoritmico, altrimenti si va di price to win. Le altre tecniche sono difficilmente realizzabili nel mondo reale.

In generale è bene usare *modelli diversi* per la stima, in modo da confermare i costi. Se ogni modello dà valori totalmente diversi dagli altri, allora l'unica strada percorribile è la tecnica price to win.

== Top-down e bottom-up

Il progetto può essere stimato con un approccio top-down o bottom-up:
- l'approccio top-down permette di considerare anche i *costi d'integrazione* delle varie sotto-componenti, ma potrebbe sottostimare i costi per la realizzazione del sotto-componente;
- viceversa, l'approccio bottom-up è molto preciso nello stimare i costi dei singoli sotto-componenti, ma può essere impreciso nello stimare i costi di integrazione

== Metriche nella project estimation

=== Linee di codice

Sono molto facili da calcolare, anche se non c'è una definizione precisa su cosa sia una linea di codice (es. vanno considerati i commenti? come si considera una linea di codice che contiene più statement?).

È una metrica molto utilizzata.

=== Token

Anziché le righe di codice, si considerano dei generici *token* (es. operandi e/o operatori). Questo permette di considerare costi diversi per linee di codice diverse.

=== Function points

Partendo dai *requisiti funzionali* del progetto, lo si divide in componenti più piccole facili da stimare.

I fattori che determinano il costo di ogni componente sono 4:
- dati di input, output e di input/output;
- tipologie di file;
- interfacce

Il valore function point risultante si calcola come:
$
  F_p = a dot "inputs" + b dot "outputs" + c dot "inquires" + d dot "files" + e dot "interfaces"
$

A partire da $F_p$ si calcola una stima della *dimensione del codice* $S$ (in termini di righe di codice). Il calcolo dipende dal linguaggio considerato.

#pagebreak(weak: true)
=== Code complexity

Approccio che valuta la complessità del codice da scrivere per implementare il progetto.

Un esempio di metrica di questo tipo + la McCabe Cyclomatic Complexity Metrics, che calcola il numero di *percorsi indipendenti* all'interno del codice.

== CoCoMo (Constructive Cost Model)

Considera 3 tipologie di progetto, che sono determinate sostanzialmente dalla sua *dimensione*:
- organic: dimensioni piccole;
- semi-detached: dimensioni medie;
- embedded: dimensioni grandi

L'obiettivo è stimare:
- il costo del progetto in *mesi-uomo* ($K_m$);
- il time to delivery ($t_d$)

Il modello CoCoMo base considera come unico input la dimensione del progetto espressa in migliaia di righe di codice ($S_k$).

Una volta calcolato $K_m$, il costo monetario del progetto si calcola moltiplicando $K_m$ per il costo mensile di ogni sviluppatore (5.000€ in Italia).

#figure(
  image("assets/d4be70d5139f933f62e7b8858d4ad540.png", height: 13%),
  caption: [Formule CoCoMo base]
)

Il modello base è molto utile per avere una *rapida* stima dei costi, ma è fortemente limitato dal fatto che non considera molti fattori che possono influire sui tempi di sviluppo.

=== Intermediate model

Oltre alle dimensioni del progetto si considerano anche altri fattori, ad esempio i *requisiti* (sia di prodotto che hardware) e il team coinvolto.

I product requirement sono basati su 15 attributi, che sono i cost diver del modello. Ognuno di questi attributi ha un valore che va da "very low" a "very high". Il valore determina il *coefficiente* del cost diver.

Per fare il calcolo della stima:
+ si calcola il costo nominale $K_n$ a partire da $S_k$;
+ si calcola $K_m$ moltiplicando $K_n$ per la *produttoria* dei coefficienti di ogni cost driver:
$
  K_m = K_n product c_i
$

#figure(
  image("assets/b7407decad5fbffc46c1de6a3082d119.png", height: 13%),
  caption: [CoCoMo intermedio]
)

=== Costo della manodopera

Il costo della manodopera non è uniforme per tutta la durata del progetto, ma varia nel tempo (in particolare è minimo all'inizio e alla fine del progetto).

=== Sottoprogetti

Il costo calcolato da CoCoMo si abbassa se il progetto si può dividere in sottoprogetti *indipendenti*.

==== Esempio

- $S_k = 60$;
- 3 sottoprogetti per cui $S_k_1 = 10$, $S_k_2 = 20$ ed $S_k_3 = 30$

Calcolando il costo del progetto intero, con $S_k = 60$, il risultato è di 294 person-month.

Calcolando invece i costi individuali dei 3 progetti e sommandoli poi assieme si ottiene un costo di 261 person-month.

=== Detailed model

Ogni modulo del software viene classificato in modo *estremamente preciso*, scegliendo i cost driver per ogni modulo.

L'obiettivo è avere una misura il più accurata possibile.

Il calcolo fatto da questo modello è molto complesso, perciò necessita di software specializzati.

=== CoCoMo 2

La dimensione $S_k$ non si misura più in linee di codice non-commento, ma in linee di codice *logiche*. Questo permette di considerare più righe di codice "fisiche" come una singola riga di codice logica (es. un `if-then-else` viene considerato come una sola riga di codice logica).

Aggiunge alcuni cost diver rispetto a CoCoMo 1 e ne modifica di esistenti.

CoCoMo 2 considera anche la *volatilità dei requisiti* nei propri calcoli.

== PERT (Program Evaluation and Review Techniques)

Mostra un elenco di *attività*, ciascuna con le relative *dipendenze* (es. attività `A` dev'essere svolta prima di attività `B`).

Fornisce anche una stima della *durata* di ogni attività. Oltre a questo, permette anche di capire:
- quali sono le *attività critiche*, cioé che non possono essere prolungate a meno di allungare la durata del progetto;
- quali invece sono le attività che si possono allungare (ed entro quali limiti) senza impattare sulla durata del progetto

Queste informazioni lo rendono molto utile per capire a che punto del progetto si è durante la fase di sviluppo.

Il fattore di cui ogni attività può essere prolungata prende il nome di *slack*.

Difetti principali di questa metodologia:
- richiede dei calcoli, sebbene non siano complessi;
- se il progetto ha *tante* attività potrebbe essere complesso gestire il grafo;
- il grafo delle attività *va tenuto aggiornato* durante il progetto

#pagebreak(weak: true)
=== PERT AON diagram

Grafo in cui i nodi sono le attività (AON = activity on nodes), mentre gli archi sono le dipendenze tra le varie attività.

I punti d'inizio (e di fine) di questo grafo possono essere *più di uno*, il che lo rende poco chiaro e dunque deprecato al giorno d'oggi.

Questi grafi vengono chiamati anche CPM charts.

=== PERT AOA diagram

Grafo in cui le attività stanno gli archi. I nodi invece rappresentano l'inizio e la fine di ogni attività.

In questo grafo ci sono un solo punto d'inizio ed un solo punto di fine.

=== Duration estimation

PERT permette di stimare la durata di ogni attività partendo da 3 valori:
- $"to"$: tempo *ottimistico*;
- $"tm"$: tempo "*most likely*";
- $"tp"$: tempo *pessimistico*

A partire da questi valori si calcola il *tempo previsto* $"te"$ come
$
  "te" = frac("to" + 4 dot "tm" + "tp", 6)
$

=== CPM (Critical Path Method)

Permette di calcolare la *durata del progetto* a partire dalla durata di ciascuna attività e dalle *dipendenze* tra le attività.

Ogni attività (archi del grafo) ha una certa durata, mentre gli eventi (i nodi del grafo) hanno un *tempo minimo* e un *tempo massimo*, indicati rispettivamente con $t_"min"$ e $t_"max"$.

Per calcolare il tempo minimo:
+ si parte dal nodo di partenza, che ha $t_"min" = 0$;
+ per gli altri nodi, il tempo minimo è pari alla *somma* del tempo minimo del *predecessore* e dell'arco che li collega. Se il nodo ha più di un predecessore, si esegue questo calcolo per ognuno di essi e si prende il *valore massimo* ottenuto

Il calcolo del $t_"max"$ invece è speculare:
+ si parte dal nodo di fine del grafo, che ha $t_"max" = t_"min"$;
+ per gli altri nodi, il tempo massimo è pari alla *differenza* tra il tempo massimo del successore e dell'arco che li collega. Se il nodo ha più di un successore, si esegue questo calcolo per ognuno di essi e si prende il *valore minimo* ottenuto

Una volta calcolati il tempo minimo e massimo di ogni attività (indicati rispettivamente con $t_"min"$ e $t_"max"$), il *critical path* è il percorso che ha $t_"min" = t_"max"$ per ogni nodo. In altre parole è il percorso il cui costo è il *massimo possibile* tra tutti i possibili percorsi del grafo.

Una volta calcolato il critical path, lo *slack* dell'$i$-esimo percorso del grafo è dato dalla *differenza* tra il costo del critical path e quello dell'$i$-esimo percorso (il costo del percorso si calcola come somma di tutti gli archi). Questo valore esprime di quanto si possono allungare le attività non-critiche senza impattare sulla durata complessiva del progetto (che è invece impattata dalle attività che stanno nel critical path).

#pagebreak(weak: true)
==== Esempio 1

#align(center)[
  #image("assets/87a76531a53e7acb37cc5d778c18039e.png")
]

#figure(
  table(
    columns: (auto, auto, auto),
    align: (center + horizon, left + horizon, left + horizon),
    [Nodo], [Tempo minimo], [Tempo massimo],
    [1], [0], [4 - 4 = 0],
    [2], [0 + 4 = 4], [9 - 5 = 4],
    [3], [4 + 5 = 9], [13 - 4 = 9],
    [4], [4 + 3 = 7], [13 - 4 = 9],
    [5], [9 + 4 = 13], [15 - 2 = 13],
    [6], [13 + 2 = 15], [15]
  ),
  caption: [Calcolo dei tempi minimi e massimi]
)

- per calcolare il $t_"min"$ del nodo 5 si sceglie l'arco $(3, 4)$ perché è quello che produce il costo massimo tra i 2 archi entranti del nodo 5;
- la scelta dell'arco per il $t_"max"$ del nodo 2 invece è indifferente, perché il risultato è sempre 4 sia scegliendo l'arco $(2, 3)$ che scegliendo l'arco $(2, 4)$

#figure(
  table(
    columns: (auto, auto, auto),
    align: (left + horizon, center + horizon, center + horizon),
    [*Percorso*], [*Costo*], [*Critical path*],
    [$A -> B -> D -> F$], [15], [x],
    [$A -> C -> E -> F$], [13], []
  ),
  caption: [Calcolo del critical path]
)

Slack = 15 - 13 = 2, distribuibile tra le attività non critiche C ed E.

#pagebreak(weak: true)
==== Esempio 2

#align(center)[
  #image("assets/73bd6916a1fa0e6bc0ebdae497bf93a6.png")
]

#figure(
  table(
    columns: (auto, auto, auto),
    align: (center + horizon, center + horizon, center + horizon),
    [Nodo], [Tempo minimo], [Tempo massimo],
    [1], [0], [17 - 17 = 0],
    [2], [0 + 17 = 17], [28 - 11 = 17],
    [4], [17 + 11 = 28], [31 - 3 = 28],
    [3], [28 + 3 = 31], [36 - 5 = 31],
    [5], [31 + 5 = 36], [44 - 8 = 36],
    [6], [36 + 8 = 44], [64 - 20 = 44],
    [7], [44 + 20 = 64], [64]
  ),
  caption: [Calcolo dei tempi minimi e massimi]
)

- per il calcolo del $t_"min"$ del nodo 3 si sceglie l'arco $(4, 3)$;
- per il calcolo del $t_"max"$ del nodo 2 si sceglie l'arco $(2, 4)$

#figure(
  table(
    columns: (auto, auto, auto),
    align: (left + horizon, center + horizon, center + horizon),
    [*Percorso*], [*Costo*], [*Critical path*],
    [$A -> B -> E -> F -> G$], [60], [],
    [$A -> C -> D -> E -> F -> G$], [64], [x]
  ),
  caption: [Calcolo del critical path]
)

Slack = 64 - 60 = 4, distribuibile solo sull'attività B (l'unica che non fa parte del critical path).

#pagebreak(weak: true)
==== Esempio 3 (calcolo del critical path)

#align(center)[
  #image("assets/bb4967c7e578a497eee3c34065b55eff.png")
]

#figure(
  table(
    columns: (auto, auto, auto),
    align: (center + horizon, center + horizon, center + horizon),
    [Nodo], [Tempo minimo], [Tempo massimo],
    [1], [0], [4 - 4 = 0],
    [2], [0 + 4 = 4], [10 - 6 = 4],
    [3], [4 + 6 = 10], [27 - 15 = 12],
    [4], [4 + 8 = 12], [30 - 18 = 12],
    [5], [10 + 15 = 25], [30 - 3 = 27],
    [6], [12 + 18 = 30], [35 - 5 = 30],
    [7], [30 + 5 = 35], [35]
  ),
  caption: [Calcolo dei tempi minimi e massimi]
)

- per calcolare il $t_"min"$ del nodo 6 si sceglie l'arco $(4, 6)$;
- per calcolare il $t_"max"$ del nodo 2 la scelta dell'arco è indifferente, perché sia con $(2, 3)$ che con $(2, 4)$ il risultato è sempre 4

#figure(
  table(
    columns: (auto, auto, auto),
    align: (left + horizon, center + horizon, center + horizon),
    [*Percorso*], [*Costo*], [*Critical path*],
    [$A -> B -> D -> F -> G$], [33], [],
    [$A -> C -> E -> G$], [35], [x]
  )
)

Slack = 35 - 33 = 2, distribuibile sulle attività non critiche ${B, D, F}$.

= DevOps

Il motivo per cui DevOps è nato è la crescente complessità del processo di sviluppo software.

Concetti alla base:
- collaborazione;
- offuscamento delle *responsabilità*: lo sviluppatore ora non è più responsabile solo della parte di sviluppo, ma anche della parte di testing, release, deploy e mantenimento
  - si raggruppa in un unico ruolo quello che precedentemente era svolto da 3 ruoli distinti (sviluppatori, tester e operations)

Se applicata correttamente, DevOps permette di *ridurre il time to market*.

Il concetto di "offuscamento delle responsabilità" si esprime anche come "rompere i silos" che ci sono tra il team di sviluppo e il team di operations.

#figure(
  image("assets/732d37299390febacb8866eb5cf1f614.png", height: 32%),
  caption: [DevOps riassunto in un'immagine]
)

DevOps ha diversi difetti:
- aggiunge complessità al progetto;
- è *costosa* e richiede un *investimento iniziale* che non è detto venga poi ripagato;
- non ci sono standard consolidati;

== Hardware management

DevOps fa uso di data center per gestire l'infrastruttura hardware.

Non ci sono più server fisici, ma è tutto in cloud. Questo aiuta ulteriormente a blurrare le responsabilità tra dev ed ops.

DevOps fa ampio uso di *hardware virtualizzato*.

== Configuration management

Dato che hardware e sistema operativo sono flessibili, DevOps introduce delle complessità nella *gestione della configurazione*. Il software può trovarsi a girare in condizioni per cui non è stato pensato, dunque è opportuno che la fase di *testing* sia ben fatta.

Esistono dei tool (configuration as code) che rendono più agevole la gestione della configurazione.

== DevSecOps

Si aggiunge al concetto di DevOps anche quello di *cybersecurity*, in ognuna delle attività.

La sicurezza diventa un aspetto a cui *tutto il team* presta costantemente attenzione.

== Quality assurance (QA)

In DevOps non è più una fase a sè stante, ma la qualità si valida in ogni fase del processo di DevOps.

== Step per adottare DevOps

+ partire da un componente possibilmente semplice;
+ adottare una metodologia agile (DevOps si adatta bene a scrum);
+ usare un *version control system*;
+ integrare il version control system con il sistema di gestione progetto, in modo da avere un *unico punto* da cui tenere sotto controllo tutto il progetto;
+ scrivere test;
+ costruire una pipeline CI/CD che:
  + integra le nuove modifiche nel repository esistente, testandole;
  + prepara la release;
  + effettua il deploy della release
+ aggiungere strumenti di monitoraggio (es. per identificare bug, problemi di performance, system health, ecc.)

== CI/CD

Insieme di pratiche volte ad *automatizzare* il processo di *integrazione e rilascio* del software:
- continuous integration (CI): automatizza l'integrazione di nuovo codice nel repository esistente, eseguendo test automatici;
- continuous deployment (CD): automatizza il rilascio del codice, eventualmente anche in ambiente di produzione

CI/CD permette agli sviluppatori di rilasciare software più rapidamente.

=== Continuous delivery vs countinuous deployment

Nel continuous delivery ci si occupa solo di *preparare il pacchetto* che verrà poi *installato manualmente* nei vari ambienti.

Il continuous deployment invece *automatizza anche il deploy* nell'ambiente di produzione.

=== CI/CD in DevOps

CI/CD riguarda l'aspetto principalmente tecnico (automatizzazione dei processi). DevOps utilizza i concetti di CI/CD, ma è una metodologia più ad alto livello che riguarda anche aspetti *culturali* (favorire collaborazione e comunicazione tra dev ed operations, rompendo i "silos").