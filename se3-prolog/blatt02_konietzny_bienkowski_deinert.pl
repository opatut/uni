%
% Aufgabenblatt 02 - SE3-LP WS1415
% 
% Carolin Konietzny 6523939
% Paul Bienkowski 6415133
% Julian Deinert 6535880
%


% Es müssen natürlich [familie] und [medien] geladen sein.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Aufgabe 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Anmerkung: Alle neuen Variablennamen sind relativ zu P1 zu verstehen.
% Um die Bezugsverhältnisse klar zu halten, haben wir P1 und P2 absichtlich
% nicht ersetzt, das Verhältnis dazwischen haben wir ja beschrieben.

?- mutter_von(P1, Sohn),vater_von(Sohn, P2).
% P1 ist Großmutter von P2, väterlicherseits.

?- mutter_von(Mutter,P1),mutter_von(Mutter,P2),P1\=P2.
% Geschwister oder Halbgeschwister mütterlicherseits (aka gleiche Mutter).

?- mutter_von(Mutter,P1),mutter_von(Großmutter,Mutter),mutter_von(Großmutter,P2),Mutter\=P2.
% P2 ist (Halb-)Onkel/Tante mütterlicherseits von P1.

?- vater_von(Vater,P1),mutter_von(Großmutter,Vater),mutter_von(Großmutter,Tante), mutter_von(Tante,P2),Vater\=Tante.
% P2 ist Cousin/Cousine von P1, aber nur die Kinder von Schwestern des Vaters von P1.

?- mutter_von(MutterVonP1,P1),mutter_von(MutterVonP2,P2),vater_von(GemeinsamerVater,P1), vater_von(GemeinsamerVater,P2),P1\=P2,MutterVonP1\=MutterVonP2.
% P1 und P2 sind echte Halbgeschwister mit gemeinsamem Vater.



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Aufgabe 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 1.
?- produkt(_, _, Titel, _, _, _, 0).

/**
 * Titel = blutrache.
 */

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 2.
?- produkt(_, buch, Titel, Autor, _, X, _),X<2004.

/**
 * Titel = winterzeit,
 * Autor = wolf_michael,
 * X = 2002 ;
 * false.
 */

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 3.
?- verkauft(PId, 2013, _, X), verkauft(PId, 2012, _, Y), X>Y, produkt(PId, buch, Titel, Autor, _, _, _).

/**
 * PId = 12346,
 * X = 22,
 * Y = 2,
 * Titel = hoffnung,
 * Autor = sand_molly ;
 * PId = 12349,
 * X = 97,
 * Y = 83,
 * Titel = winterzeit,
 * Autor = wolf_michael ;
 * false.
 */

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 4.
% Hier brauchen wir ein solches Buch zum Testen, das einen anderen Verlag hat. Wir haben Blutrache ausgesucht und
% tun nun so, als hätte Kasper es neu aufgelegt.
?- assertz(produkt(12350, buch, blutrache, wolf_michael, kasper, 2015, 200)).

% Nun die Anfrage:
?- produkt(_, buch, Titel, Autor, Verlag1, Jahr1, _), produkt(_, buch, Titel, Autor, Verlag2, Jahr2, _), Verlag1\=Verlag2, Jahr1<Jahr2.

/**
 * Titel = blutrache,
 * Autor = wolf_michael,
 * Verlag1 = meister,
 * Jahr1 = 2010,
 * Verlag2 = kasper,
 * Jahr2 = 2015 ;
 * false.
 */

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 5.

?- produkt(_, buch, Titel, Autor, _, _, _), \+ produkt(_, hoerbuch, Titel, Autor, _, _, _).

/**
 * Titel = sonnenuntergang,
 * Autor = hoffmann_susanne ;
 * Titel = blutrache,
 * Autor = wolf_michael ;
 * Titel = blutrache,
 * Autor = wolf_michael.
 */

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 6.
?- produkt(P1, _, Titel, Autor, _, _, Bestand), \+ (produkt(P2, _, _, _, _, _, B2), B2 > Bestand, P1\=P2).

/**
 * P1 = 12346,
 * Titel = hoffnung,
 * Autor = sand_molly,
 * Bestand = 319 ;
 * false.
 */




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Aufgabe 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Ein Sportverein hat Mitglieder, diese müssen ihre Beiträge zahlen,
% es gibt Trainings-Termine, an denen einige Mitglieder anwesend sind.

% mitglied(MId, Name, Geburtsjahr, Eintrittsjahr)
% bezahlt(MId, Jahr, Betrag)
% training(TId, Jahr, Monat, Tag, Stunde, Ort)
% anwesend(MId, TId)

mitglied(1, carolin_konietzny, 1993, 2011).
mitglied(2, paul_bienkowski, 1994, 2011).
mitglied(3, julian_deinert, 1993, 2014).
mitglied(4, rafael_epplee, 1994, 2008).
bezahlt(1, 2011, 50).
bezahlt(1, 2012, 50).
bezahlt(1, 2013, 50).
bezahlt(1, 2014, 50).
bezahlt(2, 2011, 50).
bezahlt(2, 2012, 50).
bezahlt(2, 2014, 50).
bezahlt(3, 2014, 60).
bezahlt(4, 2008, 50).
bezahlt(4, 2009, 50).
bezahlt(4, 2010, 50).
bezahlt(4, 2011, 50).
bezahlt(4, 2012, 50).
bezahlt(4, 2014, 50).
training(1, 2014, 05, 12, 12, halle).
training(2, 2014, 05, 19, 12, halle).
training(3, 2014, 05, 26, 12, halle).
training(4, 2014, 06, 02, 15, stadion).
training(5, 2014, 06, 09, 12, stadion).
training(6, 2014, 06, 16, 12, sportplatz).
training(7, 2014, 06, 23, 12, sportplatz).
training(8, 2014, 06, 30, 12, halle).
anwesend(1, 1).
anwesend(1, 2).
anwesend(1, 3).
anwesend(1, 4).
anwesend(1, 5).
anwesend(1, 6).
anwesend(1, 8).
anwesend(2, 3).
anwesend(2, 4).
anwesend(2, 6).
anwesend(2, 7).
anwesend(2, 8).
anwesend(3, 1).
anwesend(4, 5).
anwesend(4, 6).


% 1. Wer ist am längsten dabei?
?- mitglied(M1, Name, _, Eintritt), \+ (mitglied(M2, _, _, Eintritt2), Eintritt>Eintritt2).

/**
 * M1 = 4,
 * Name = rafael_epplee,
 * Eintritt = 2008.
 */

% 2. Finde alle Trainings-Termine, bei denen niemand anwesend war. 
?- training(TId, Jahr, Monat, Tag, Stunde, _), \+ anwesend(MId, TId).

/**
 * TId = 9,
 * Jahr = 2014,
 * Monat = Tag, Tag = 7,
 * Stunde = 12.
 */

% 3. Finde alle Termine, an denen Mitglieder mit gleichem Eintrittsjahr anwesend waren.
?- training(TId, _, _, _, _, _), anwesend(MId1, TId), anwesend(MId2, TId), mitglied(MId1, _, _, Eintritt), mitglied(MId2, _, _, Eintritt), MId1\=MId2.

/**
 * TId = MId1, MId1 = 1,
 * MId2 = 2,
 * Eintritt = 2011 ;
 * TId = MId2, MId2 = 1,
 * MId1 = 2,
 * Eintritt = 2011 ;
 */

% 4. Wer hat 2013 noch nicht bezahlt?
?- mitglied(MId, Name, _, _), \+ bezahlt(MId, 2013, _).

/**
 * MId = 2,
 * Name = paul_bienkowski ;
 * MId = 3,
 * Name = julian_deinert ;
 * MId = 4,
 * Name = rafael_epplee.
 */

% 5. Wer war am öftensten anwesend?
?- mitglied(MId, Name, _, _), 
    \+ (aggregate_all(count, anwesend(MId, _), CountSelf), 
        mitglied(MId2, _, _, _), 
        aggregate_all(count, anwesend(MId2, _), CountOther), 
        CountSelf<CountOther  
        ).

/**
 * MId = 1,
 * Name = carolin_konietzny ;
 * false.
 */

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Aufgabe 4
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Gemeinsamkeiten und Unterschiede:

% - Alle sind unterschiedlich lang
% - Sie beginnen alle mit einem Großbuchstaben
% - "Fakt" kommt aus dem Lateinischen "Faktum", "Regel" hat Ursprung im mittel-/althochdeutsch "regula, regile", "Anfrage" kommt von "anfragen"
% - Sortierreihenfolge nach Länge ist gleich mit Sortierreihenfolge nach Anzahl der Vokale
% - Nur "Regel" kann man rückwärts aussprechen
% - "Fakt" und "Regel" stehen in der gleichen Zeile, "Anfrage" in der nächsten.
% - Keiner der Begriffe ist ein Singularetantum

%%% Verwendung der Konzepte:

% Fakten sind explizite Relationsbeziehungen, welche in der Datenbasis
% gespeichert werden können. Z.B.
%     ist_lebendig(arne).
%     uebungsgruppenleiter_von(arne, wir).

% Anfragen sind Anfragen an die Datenbasis, um Fakten zu erlangen.
% Anfragen werden für gewöhnlich im interaktiven Prompt ausgeführt.
%     ?- ist_lebendig(arne).   -> true.

% Regeln ermöglichen neue Anfragen, ohne explizit Fakten aufzulisten,
% sondern durch Kombination anderer Anfragen weitere implizite Tatsachen
% zu ermitteln.
%     ist_lebendiger_uebeungsgruppenleiter_von(Leiter, Teilnehmer) :- 
%           ist_lebendig(Leiter), uebungsgruppenleiter_von(Leiter, Teilnehmer).

% Damit kann man eine neue Anfrage stellen:
%     ?- ist_lebendiger_uebeungsgruppenleiter_von(arne, wir).   -> true



