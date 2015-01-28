%%% Aufgabe 1 %%%

% vorfahrt_prio(+Regel, -Priorität).
% Weist der Vorfahrts-Regel eine Priorität zu.
vorfahrt_prio(sondersignal, 10) :- !.
vorfahrt_prio(kreisverkehr, 5) :- !.
vorfahrt_prio(hauptstrasse, 3) :- !.
vorfahrt_prio(rechts, 2) :- !.
vorfahrt_prio(_, 1) :- !.

% hat_vorfahrt(+A, +B).
% Prüft, ob Regel A vor Regel B Vorrang hat.
hat_vorfahrt(A, B) :-
    vorfahrt_prio(A, PrioA),
    vorfahrt_prio(B, PrioB),
    %% writef("Fahrzeug A: %w (%w), Fahrzeug B: %w (%w)\n", [A, PrioA, B, PrioB]),
    PrioA > PrioB.

% fahrzeug(?Fahrzeug, ?Regel).
% Definiert Fahrzeuge und ihre Regeln.
fahrzeug(feuerwehr, sondersignal).
fahrzeug(gruen, kreisverkehr).
fahrzeug(gruen, links).
fahrzeug(fahrrad, kreisverkehr).
fahrzeug(fahrrad, rechts).
fahrzeug(traktor, links).
fahrzeug(bus, hauptstrasse).
fahrzeug(bus, links).
fahrzeug(lkw, rechts).
fahrzeug(pferdekutsche, hauptstrasse).
fahrzeug(jeep, nebenstrasse).
fahrzeug(jeep, rechts).


% teste_vorfahrt(A, B).
% Prüft, ob Fahrzeug A vor Fahrzeug B Vorfahrt hat.
% Fahrzeug A muss mindestens *eine* Regel habe, die vor *allen* anderen
% von Fahrzeug B Vorrang hat.
teste_vorfahrt(A, B) :-
    % dies wird per Backtracking erneuert
    fahrzeug(A, RegelA),
    writef('A: %w\n', [RegelA]),

    % nun prüfen wir, dass auch ja keine von B besser ist
    forall(fahrzeug(B, RegelB), (
        writef('Teste Regelkombination: %w vs %w\n', [RegelA, RegelB]),
        hat_vorfahrt(RegelA, RegelB))),

    % Debug :)
    writef('Fahrzeug "%w" hat Vorfahrt vor "%w", weil es (u.A.) "%w" hat.\n', [A, B, RegelA]),

    % uns reicht es, wenn *eine* Regel Priorität über alle anderen hat
    !.

% Ist ja nur das Gegenteil der Vorfahrt.
teste_nachfahrt(A, B) :-
    \+ teste_vorfahrt(A, B),
    writef('Fahrzeug "%w" muss auf "%w" warten, weil es keine stärkere Regel hat.\n', [A, B]).



%%% Aufgabe 2 %%%


:- dynamic chocolate_remember/4.
% Try to remember an already solved version.
chocolate(Width, Height, Break, Count) :-
    chocolate_remember(Width, Height, Break, Count), !.
chocolate(1, 1, done, 0).
chocolate(Width, Height, Break, Count) :-
    Width2 is Width - 2,
    between(0, Width2, Index),
    WidthA is Index + 1,
    WidthB is Width - WidthA,
    chocolate(WidthA, Height, BreakA, CountA),
    chocolate(WidthB, Height, BreakB, CountB),
    Break = break(x, Index, BreakA, BreakB),
    Count is CountA + CountB + 1,
    assert(chocolate_remember(Width, Height, Break, Count)).
chocolate(Width, Height, Break, Count) :-
    Height2 is Height - 2,
    between(0, Height2, Index),
    HeightA is Index + 1,
    HeightB is Height - HeightA,
    chocolate(Width, HeightA, BreakA, CountA),
    chocolate(Width, HeightB, BreakB, CountB),
    Break = break(x, Index, BreakA, BreakB),
    Count is CountA + CountB + 1,
    assert(chocolate_remember(Width, Height, Break, Count)).


% Zum Vergleich nochmal ohne Datenbank:
chocolate1(1, 1, done, 0).
chocolate1(Width, Height, Break, Count) :-
    Width2 is Width - 2,
    between(0, Width2, Index),
    WidthA is Index + 1,
    WidthB is Width - WidthA,
    chocolate(WidthA, Height, BreakA, CountA),
    chocolate(WidthB, Height, BreakB, CountB),
    Break = break(x, Index, BreakA, BreakB),
    Count is CountA + CountB + 1.
chocolate1(Width, Height, Break, Count) :-
    Height2 is Height - 2,
    between(0, Height2, Index),
    HeightA is Index + 1,
    HeightB is Height - HeightA,
    chocolate(Width, HeightA, BreakA, CountA),
    chocolate(Width, HeightB, BreakB, CountB),
    Break = break(x, Index, BreakA, BreakB),
    Count is CountA + CountB + 1.

% 2.4:

% Chocolate1: Variante ohne Datenbank.
% Chocolate: Variante mit Datenbank.

%% ?- time(chocolate(200, 1000, _, X)).
%% % 10,587 inferences, 1.915 CPU in 1.916 seconds (100% CPU, 5529 Lips)
%% X = 199999

%% ?- time(chocolate1(200, 1000, _, X)).
%% % 10,585 inferences, 1.973 CPU in 1.975 seconds (100% CPU, 5364 Lips)
%% X = 199999 .

% ... geht jetzt auch nicht schneller :(
