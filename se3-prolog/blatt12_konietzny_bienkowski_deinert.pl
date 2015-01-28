% 2.1

% Prüft, ob alle elemente der Liste x in der Liste y in angegebener Reihenfolge
% enthalten sind.

foo1([], _).
foo1(_, []) :- fail, !.
foo1([X1|XR], [Y1|YR]) :-
    X1 = Y1 ->
        foo1(XR, YR);
        foo1([X1|XR], YR).

% 2.2

% Gibt eine Liste zurück mit erst allen Elemente aus x, welche nicht in y
% enthalten sind, und dann dem gesamten y zurück. Dies entspricht einer
% Zusammenfügung der beiden Listen ohne Duplikate (unter der Voraussetzung,
% dass keine der ursprünglichen Listen Duplikate enthielt).

% foo2(+X, +Y, -Z).
foo2([], Y, Y).
foo2([X1|XR], Y, Z) :-
    member(X1, Y) ->
        foo2(XR, Y, Z);
        (
            foo2(XR, Y, ZR),
            Z = [X1|ZR]
        ).

% 2.3

% Alle Elemente aus X, die nicht in Y enthalten sind.

foo3([],_,[]).
foo3([X1|XR], Y, Z) :-
    member(X1, Y) ->
        foo3(XR, Y, Z);
        (
            foo3(XR,Y,ZR),
            Z = [X1|ZR]
        ).


% 2.4

% Gibt das Maximum der Liste zurück.
foo4([X1], X1).
foo4([X1|XR], Maximum) :-
    foo4(XR,Max),
    ((X1 > Max) ->
        Maximum = X1;
        Maximum = Max).


%Unterschied: Prolog Implementation ist  nicht endrekursiv.



%%2.5

% Ermittelt das Skalarprodukt (Punktprodukt).

foo5([],_, 0).
foo5(_,[],0).
foo5([X1|XR], [Y1|YR], Ergebnis) :-
    foo5(XR, YR, Erg),
    Ergebnis is X1* Y1 + Erg.
