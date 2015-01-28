:- use_module(library(lists)).
:- use_module(library(clpfd)).

count([],_,0).
count([X|T],X,Y):- count(T,X,Z), Y is 1+Z.
count([X1|T],X,Z):- X1\=X,count(T,X,Z).

countall(List,X,C) :-
    sort(List,List1),
    member(X,List1),
    count(List,X,C).

% Scenario:
% Klassifikation der Kundenzufriedenheit (schlecht, mittel, gut) beim
% Kauf einer Alternative eines Produktes (z.B. Kühlschrank) nach folgenden Kriterien:
% - Preis des Produktes
% - Lieferzeit (in Tagen)
% - Gründungsjahr der Marke
% - Garantiedauer (in Monaten)

d(schlecht, [500, 2, 1992, 24]).
d(schlecht, [314, 3, 1968, 48]).
d(schlecht, [420, 2, 2005, 24]).
d(mittel,   [390, 4, 1971, 24]).
d(mittel,   [530, 9, 1980, 48]).
d(mittel,   [840, 2, 1980, 96]).
d(gut,      [310, 3, 1952, 24]).
d(gut,      [910, 1, 1959, 24]).
d(gut,      [880, 7, 1982, 96]).

test([600, 2, 1970, 24]).

% euclidean_distance(+A, +B, -Distance).
% Calculates the euclidean distance between A and B.
euclidean_distance(A, B, Distance) :-
    euclidean_distance_sum(A, B, Sum),
    Distance is sqrt(Sum).

euclidean_distance_sum([], [], 0).
euclidean_distance_sum([A|As], [B|Bs], Sum) :-
    Diff is B - A,
    euclidean_distance_sum(As, Bs, NextSum),
    Sum is NextSum + Diff * Diff.

%% ?- euclidean_distance([1,2,3],[3,2,1],X).
%% X = 2.8284271247461903.
%% ?- euclidean_distance([1,2,3],[9,2,1],X).
%% X = 8.246211251235321.
%% ?- euclidean_distance([0,0,3],[0,0,9],X).
%% X = 6.0.

sample(Distance - Class, Test) :-
    d(Class, Data),
    euclidean_distance(Data, Test, Distance).

samples(Test, Results) :-
    findall(Sample, sample(Sample, Test), Results).

classmatch(Test, Class) :-
    samples(Test, Samples),
    keysort(Samples, [Best|_]),
    Best = _ - Class.

bestmatches(Test, K, Matches) :-
    samples(Test, Samples),
    keysort(Samples, Sorted),
    append(Matches, _, Sorted),
    length(Matches, K).

majority(Matches, Class) :-
    % extract classes from matches
    findall(C1, member(_ - C1, Matches), Classes),
    % count number of class occurences
    findall(NAmount - C2, (countall(Classes, C2, Amount), NAmount is -Amount), Amounts),
    % sort amount
    keysort(Amounts, [Best|_]),
    Best = _ - Class.

kmatcher(Test, K, Class) :-
    bestmatches(Test, K, Matches),
    majority(Matches, Class).

% Ein zu großes K (bei nur kleiner Trainingsgröße) kann keine Aussagen mehr machen. Natürlich werden
% wenn k größer ist als die Anzahl der Trainingsdaten in einer Klasse, auch andere Datensätze
% in die "Abstimmung" mit einbezogen.
% Bei zu kleinem K (z.B. k=1, wie der "einfache" Klassifikator) spielen falsche oder "besondere" Trainingsdaten
% allerdings eine größere Rolle, hier ist es sehr wichtig, einen guten Trainingsdatensatz zu haben.

avg([], 0).
avg(L, E) :-
    sum(L, #=, Sum),
    length(L, Length),
    E is Sum / Length.

variance(L, V) :-
    avg(L, E),
    variance(L, E, V).

variance([], _, 0).
variance([H|T], M, V):-
    variance(T, M, V1),
    V is (V1 + ((H-M)*(H-M))).

