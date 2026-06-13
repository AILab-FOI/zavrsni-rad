# Game Design Document (GDD)

# Izrada 2D igre tipa platformer s elementima preživljavanja

## 1. Koncept igre

Igra je 2D platformer čija je radnja smještena u podzemnoj pećini. Glavni cilj igre je pronaći izlaz iz mračne pećine, pritom izbjegavajući prepreke i neprijatelje unutar razine te pokušavajući ne izgubiti sve živote.

## 2. Pravila i osnovne mehanike

Igrač upravlja likom koristeći osnovne kontrole:

Hodanje (tipke A / strelica lijevo i D / strelica desno)
Skakanje (tipka W / strelica gore)
Trčanje (tipka SHIFT)
Interakcija s objektima (tipka E)

Osnovne mehanike uključuju:

Sustav zdravlja (igrač gubi život pri kontaktu s neprijateljima / zamkama)
Sustav stamine (igrač ima ograničenu količinu stamine koja se troši prilikom trčanja)
Sustav checkpointova (spremanje napretka na određenim točkama)

Igra završava kada igrač dođe do izlaza ili izgubi sve živote.

## 3. Priča i likovi 

Istraživač istražuje duboke i skrivene dijelove pećine kada iznenada dolazi do urušavanja tla te pada u njezinu unutrašnjost. Na sreću, preživljava pad te mu ostaje samo baklja koja mu osvjetljava put. Njegov cilj je pobjeći iz mračne pećine i pronaći izlaz na površinu, izbjegavajući opasnosti koje se nalaze unutar nje.

## 4. Vizualni stil i zvuk

Vizualni stil je 2D pixel art s tamnom atmosferom i naglaskom na kontrast svijetla i tame. Zvukovi uključuju ambijentalne efekte poput kapljanja vode, zvukove kretanja neprijatelja te slične okolišne zvukove, uz glazbu u pozadini.

## 5. Korisničko sučelje

Korisničko sučelje (UI - User Interface) sastoji se od glavnog izbornika koji uključuje početak igre, nastavak igre (ako je igrač stigao do određenog checkpointa), postavke igre i izlazak iz igre. Tijekom igranja igraču se prikazuje status zdravlja i stamine.
