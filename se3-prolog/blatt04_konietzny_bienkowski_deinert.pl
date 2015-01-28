% Blatt 04 - Konietzny, Bienkowski, Deinert

%%% Aufgabe 1

% A ist das Geburtsdatum von B
%%keine. 

% A ist im Turnier gegen B angetreten
%% symmetrisch
%% Wenn A gegen B angetreten ist, dann ist auch B gegen A angetreten. 

% A ist älter als B
%% transitiv
%% Wenn A älter als B ist und B älter als C, ist auch A älter als C

% A und B sind Geschwister
%% transitiv, symmetrisch
%% Wenn A ein Geschwisterkind von B ist, ist B auch eines von A. 
%% Gleichzeitig ist A ein Geschwisterkind von C, wenn C auch eins von B ist 

% A ist eine (echte oder unechte) Teilmenge von B
%% für unechte Teilmenge:
%% symmetrisch, reflexiv, transitiv
%% Wenn A eine Teilmenge von B ist, ist B auch eine von A. A ist eine unechte Teilmenge von sich selbst.
%% Wenn A eine teilmenge von B ist und C eine von B, dann ist A auch eine von C

%% für echte Teilmenge:
%% transitiv
%% Wenn A eine teilmenge von B ist und C eine von B, dann ist A auch eine von C

% A und B sind Häuser in der gleichen Straße
%% reflexiv, transitiv, symmetrisch
%% A steht in der selben Straße wie A (obviously). Wenn A in der selben Straße wie B steht und C in der selben wie B, 
%% dann steht A in der selben Straße wie C. Wenn A in der selben Straße wie B steht, steht B in der selben Straße wie A.

%%% Aufgabe 2

vorfahre_von(Vorfahre, Nachkommende) :-
    mutter_von(Vorfahre, Nachkommende); vater_von(Vorfahre, Nachkommende).

vorfahren_von(Vorfahre, Nachkommende) :-
    vorfahre_von(Vorfahre, Nachkommende);
    vorfahre_von(Vorfahre1, Nachkommende), vorfahren_von(Vorfahre,Vorfahre1).


%%% Aufgabe 3

% 3.1

% Einfach, damit der Code dort unten etwas lesbarer ist ;)
direkte_voraussetzung(Produkt1, Produkt2) :-
    arbeitsschritt(Produkt1, _, _, Produkt2).

% Produkt1 ist entweder direkte Voraussetzung für Produkt2,
% oder wir finden ein Zwischenprodukt, welches direkte Voraussetzung
% für Produkt2 ist, und als direkte oder indirekte (rekursiv!) Voraussetzung
% Produkt1 hat.
voraussetzung(Produkt1, Produkt2) :-
    direkte_voraussetzung(Produkt1, Produkt2) ;
    (direkte_voraussetzung(Zwischen, Produkt2) , voraussetzung(Produkt1, Zwischen)).


% 3.2
produktion_stoppen(Nichtlieferbar, Endprodukt) :-
    voraussetzung(Nichtlieferbar, Endprodukt), 
    endprodukt(Endprodukt).

% Beispiel:
% ?- produktion_stoppen(m27, Endprodukt).


% 3.3

% Das Prädikat `voraussetzung` terminiert, solange keine Zyklen in der Datenbasis enthalten sind,
% also kein Produkt sich selbst direkt oder indirekt als Voraussetzung hat.
% Um dies zu überprüfen, kann man nach Produkten suchen, die eben ihre eigene Voraussetzung sind, also:
% ?- voraussetzung(Produkt, Produkt).

% 3.4

% Wir haben uns für eine andere Lösung als die vorgeschlagene entschieden, welche
% einfach nicht herstellbare Produkte findet und diese wie nicht lieferbare Produkte
% behandelt.

nicht_erstellbar(Arbeitsplatz, Produkt) :-
    (arbeitsschritt(_, _, Arbeitsplatz, Produkt)),
    \+ (arbeitsschritt(_, _, Arbeitsplatz2, Produkt), Arbeitsplatz2 \= Arbeitsplatz).

vom_ausfall_betroffene_endprodukte(Arbeitsplatz, Endprodukte) :-
    findall(Endprodukt, (
            nicht_erstellbar(Arbeitsplatz, Zwischenprodukt),
            produktion_stoppen(Zwischenprodukt, Endprodukt)
        ), EndprodukteUnsorted),
    sort(EndprodukteUnsorted, Endprodukte).

% 3.5

fertigungstiefe(Zulieferteil, Endprodukt, Tiefe) :-
    (direkte_voraussetzung(Zulieferteil, Endprodukt), Tiefe = 1);
    (direkte_voraussetzung(Zwischen, Endprodukt), fertigungstiefe(Zulieferteil, Zwischen, Tiefe2), Tiefe is Tiefe2 + 1).


% 3.6 
fertigungspfad(Produkt1, Produkt2, Pfad) :-
    zulieferung(Produkt1),
    endprodukt(Produkt2),
    travel(Produkt1, Produkt2, [Produkt1], Pfad2),
    reverse(Pfad2, Pfad).

travel(Produkt1, Produkt2, Pfad, [Produkt2|Pfad]) :- 
    direkte_voraussetzung(Produkt1, Produkt2).

travel(Produkt1,Produkt2,Besucht,Pfad) :-
    direkte_voraussetzung(Produkt1,Zwischen),           
    Zwischen \== Produkt2,
    \+member(Zwischen,Besucht),
    travel(Zwischen,Produkt2,[Zwischen|Besucht],Pfad).  

mehrfache_fertigungspfade(Zulieferteil, Endprodukt) :-
    zulieferung(Zulieferteil),
    endprodukt(Endprodukt),
    findall(Pfad, fertigungspfad(Zulieferteil, Endprodukt, Pfad), Pfade), 
    length(Pfade, AnzahlPfade),
    AnzahlPfade > 1.
