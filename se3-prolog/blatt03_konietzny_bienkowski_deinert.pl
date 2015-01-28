% Zum testen ein paar Ladenhüter einbauen. Hierfür muss multifile für produkt/7 und verkauft/4
% aktiviert sein in medien.pl.
produkt(1337, egal, ladenhueter, schlechter_autor, ein_verlag, 2013, 120).
verkauft(1337, 2013, 12, 15).
produkt(1338, 2, nicht_blattknoten, egal, ein_verlag, 2013, 1000).
kategorie(22, ungueltig, 123).

% This is required for the sum/3 relation.
:- use_module(library(clpfd)).

%%% Aufgabe 1

% Suche ist das, was Prolog für einen macht. Es spannt einen Suchbaum auf mit allen 
% möglichen Regeln und Fakten, und sucht dann darin nach möglichen Ergebnissen.
% Eine Variable kann mit einem Wert instanziiert werden. Dann hat im Teil-Suchbaum
% darunter diese Variable eben diesen Wert. Dies schränkt die Suche ein. Wenn
% eine Variable instanziiert wird, heißt das dann auch "Instanziierung".


%%% Aufgabe 2

% 2.1
% Ist produkt <PId> im Jahr <Jahr> teurer geworden?
teurer_geworden(Jahr, PId) :-
    produkt(PId, _, _, _, _, _, _), 
    verkauft(PId, Jahr, Preis, _), 
    verkauft(PId, Vorjahr, Vorjahrespreis, _), 
    Vorjahr =:= Jahr - 1,
    Vorjahrespreis < Preis.

% Jahr = 2003, PId = 12347 ;
% Jahr = 2004, PId = 12347 ;
% Jahr = 2010, PId = 12349 ;

% 2.2
erstverkauf(PId, Jahr) :-
    produkt(PId, _, _, _, _, _, _),
    verkauft(PId, Jahr, _, _),
    \+ (verkauft(PId, Jahr2, _, _), Jahr2 < Jahr).

% PId = 12345, Jahr = 2006 ;
% PId = 12346, Jahr = 2005 ;
% PId = 12347, Jahr = 2002 ;
% PId = 12348, Jahr = 2010 ;
% PId = 12349, Jahr = 2009 ;
% PId = 23456, Jahr = 2009 ;
% PId = 23457, Jahr = 2009 ;
% PId = 23458, Jahr = 2010 ;
% PId = 34567, Jahr = 2008 ;
% PId = 34568, Jahr = 2006 ;
% PId = 1337, Jahr = 2013 ;


% 2.3
ladenhueter(PId) :-
    produkt(PId, _, _, _, _, _, Bestand),
    \+ (verkauft(PId, Jahr, _, _), Jahr<2013),
    verkauft(PId, 2013, _, Anzahl),
    Anzahl * 2 < Bestand.

% PId = 1337 ;


%%% Aufgabe 3

% 3.1
guenstige_produkte(Ergebnis) :-
    findall(PId, (verkauft(PId, 2013, Preis, _), Preis < 10), Liste),
    length(Liste, Ergebnis).

% Ergebnis = 3.

% 3.2
schlecht_verkauft(Liste) :-
    findall(PId,
        (
            produkt(PId, _, _, _, _, _, _),
            findall(Umsatz, (verkauft(PId, _, Preis, Anzahl), Umsatz is Preis * Anzahl), Umsaetze),
            sum(Umsaetze, #=, Umsatz),
            Umsatz < 500
        ),
        Liste).

% Liste = [23456, 23457, 1337, 1338].

% 3.3
vorhandene_ladenhueter(Anzahl) :-
    findall(Bestand, ( 
            ladenhueter(PId),
            produkt(PId, _, _, _, _, _, Bestand)
        ), Bestaende),
    sum(Bestaende, #=, Anzahl).

% Anzahl = 120.

%%% Aufgabe 4

% 4.1
kategorien_nach_name(Name, Kategorien) :-
    findall(KId, kategorie(KId, Name, _), Kategorien).

% ?- kategorien_nach_name(krimi, Kategorien).
% Kategorien = [7, 8, 9].


% 4.2

% Hilfsprädikat, ist eh ganz nützlich
ist_blattknoten(KId) :-
    \+ kategorie(_, _, KId).

nicht_blattknoten_produkte(Liste) :-
    findall(PId, (
            produkt(PId, KId, _, _, _, _, _),
            (\+ ist_blattknoten(KId);               % ist kein blattknoten
                \+ kategorie(KId, _, _))            % oder noch nichtmal eine Kategorie
        ), Liste).

% Auf medien2.pl:
% Liste = [1337, 1338].
% Auf medien.pl (dort sind ja auch ungültige Kategorienschlüssel):
% Liste = [1337, 1338, 12345, 12346, 12347, 12348, 12349, 23456, 23457|...].

% 4.3
ungueltige_kategorien(Liste) :-
    findall((KId, Name),
        (kategorie(KId, Name, Parent), (Parent \= 0, \+ kategorie(Parent, _, _))),
            Liste).

% Liste = [ (22, ungueltig)].
