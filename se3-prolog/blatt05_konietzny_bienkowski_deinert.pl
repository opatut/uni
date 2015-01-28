% Blatt 05 - Konietzny, Bienkowski, Deinert

%%% Aufgabe 1

%% ?- n(F,g)=n(k,G).
%% F = k,
%% G = g.
%% Klappt, da obige Belegung immer gilt.

%% ?- p(B,B)=p(i,j).
%% false.
%% da B nicht i und j gleichzeitig unifizieren kann (i und j sind Atome und daher ungleich).

%% ?- r(r(d,D),r(D,d))=r(r(E,e),r(e,E)).
%% D = e,
%% E = d.
%% Die Ausdrücke sind ähnlich aufgebaut, D kann jeweils durch e ersetzt werden, und E durch d.

%% ?- m(t(X,Y),X,c(g),h(Y))=
%%    m(t(r,s),r,h(g(T))).
%% false.
%% m hat unterschiedliche Stelligkeiten links und rechts (m/4 vs m/3).

%% ?- false=not(true).
%% false.
%% Es handelt sich um zwei Atome, diese sind nicht unifizierbar.

%% ?- False=not(true).
%% False = not(true).
%% Jetzt ist False eine Variable, sodass sie unifizierbar ist mit not(true).


%%% Aufgabe 2.1

% vorgaenger(?Zahl, ?Vorgaenger)
% Vorgaenger kommt direkt vor Zahl
vorgaenger(s(X), X).
%% ?- vorgaenger(s(s(0)), A).
%% A = s(0).

% nachfolger(?Zahl, ?Nachfolger)
% Nachfolger kommt direkt nach Zahl
nachfolger(X, s(X)).
%% ?- nachfolger(s(s(0)), A).
%% A = s(s(s(0))).

% geq(?Term1,?Term2)
% Term1 und Term2 sind Peano-Terme, so dass Term1
% größer oder gleich Term2 ist
geq(0,0).
geq(s(_),0).
geq(s(X), s(Y)) :- geq(X, Y).
%% ?- geq(s(0), s(s(0))).
%% false.
%% ?- geq(s(s(0)), s(0)).
%% true.
%% ?- geq(s(s(0)), s(s(0))).
%% true.

% min(?Peano1,?Peano2,?PeanoMin)
min(0,s(_),0).
min(s(_),0,0).
min(s(X),s(Y),s(M)) :- min(X, Y, M).
%% ?- min(s(0), s(s(0)), X).
%% X = s(0).

% between(?From, ?To, ?Value)
% Siehe help(between).
between(X,Y,X) :- geq(Y,X).
between(X,Y,s(X)) :- geq(Y,X).
between(X,Y,Y) :- geq(Y,X).
%% ?- between(s(0), s(s(s(0))),  s(s(0))).
%% true.
%% ?- between(s(0), s(s(s(0))),  Y).
%% Y = s(0) ;
%% Y = s(s(0)) ;
%% Y = s(s(s(0))) ;
%% false.

% peanoInt(?Peano, ?Int).
% Wandelt Peano in eine Integer-Zahl `Int` um.
peanoInt(0, 0).
peanoInt(s(X), Z) :- peanoInt(X, Z2), Z is Z2 + 1.
%% ?- peanoInt(s(s(s(0))), Z).
%% Z = 3.


%%% Aufgabe 2.2

% Definition von Peano-Termen.
peano(0).
peano(s(X)) :- peano(X).

% lt(?Term1,?Term2)
% Term1 und Term2 sind Peano-Terme, so dass Term1
% kleiner als Term2
lt(0,s(X)) :- peano(0), peano(X).
lt(s(X),s(Y)) :- lt(X,Y), peano(X), peano(Y).

% add(?Summand1,?Summand2,?Summe)
% Summand1, Summand2 und Summe sind Peano-Terme,
% so dass gilt: Summand1 + Summand2 = Summe
add(0,X,X) :- peano(X). 
add(s(X),Y,s(R)) :- peano(X), peano(R), peano(Y), add(X,Y,R).

% Am Verhalten der Prädikate ändert sich nichts.

%%% Aufgabe 3.

% tree(?Reich, ?Stamm, ?Klasse, ?Ordnung, ?Familie, ?Gattung, ?Art)
% Es gilt, dass die Art Teil der Gattung ist, die Gattung in der Familie, usw...
tree(Reich, Stamm, Klasse, Ordnung, Familie, Gattung, Art) :-
    reich(Reich),
    sub(Stamm, stamm, Reich),
    sub(Klasse, klasse, Stamm),
    sub(Ordnung, ordnung, Klasse),
    sub(Familie, familie, Ordnung),
    sub(Gattung, gattung, Familie),
    sub(Art, art, Gattung).

%% ?- tree(Reich, Stamm, Klasse, Ordnung, Familie, Gattung, menschenfloh).
%% Reich = vielzeller,
%% Stamm = gliederfuesser,
%% Klasse = insekten,
%% Ordnung = floehe,
%% Familie = pulicidae,
%% Gattung = pulex .

%% ?- tree(Reich, Stamm, insekten, _, _, _, _).
%% Reich = vielzeller,
%% Stamm = gliederfuesser .



% 4.1

% fertigungstiefe(?From, ?To, ?Tiefe)
% Sodass die Fertigungstiefe zwischen dem Teil From und 
% dem Teil To genau Tiefe ist.
fertigungstiefe(From, From, 0).
fertigungstiefe(From, To, 1) :-
    arbeitsschritt(From, _, _, To).
fertigungstiefe(From, To, Depth) :-
    arbeitsschritt(Zwischen, _, _, To),
    fertigungstiefe(From, Zwischen, Depth2), 
    Depth is Depth2 + 1.
%% ?- fertigungstiefe(wumme27, galaxy2004, T).
%% T = 4 ;
%% T = 4 ;
%% T = 3 ;
%% T = 3 ;
%% false.

% 4.2

%% fertigungstiefen(+From, +To, -Liste)
fertigungstiefen(From, To, Liste) :-
    findall(Depth, fertigungstiefe(From, To, Depth), Liste1),
    sort(Liste1, Liste).
%% ?- fertigungstiefen(wumme27, galaxy2004, T).
%% T = [3, 4].

% 4.3

% sum_list(+Liste, -Anzahl)
% Summiert die Elemente der Liste in Anzahl auf.
sum_list([], 0).
sum_list([H|T], Sum) :- sum_list(T, Rest), Sum is H + Rest.

% zulieferzahl(+From, +To, -Anzahl)
% Zählt, wie viele Elemente 'From' man für 'To' braucht, in Anzahl.
zulieferzahl(From, To, Anzahl) :-
    findall(Ind,
        (arbeitsschritt(Zwischen, Ind1, _, To), zulieferzahl(From, Zwischen, Ind2), Ind is Ind1 * Ind2),
        IndirektListe
        ),
    sum_list(IndirektListe, Indirekt),
    findall(Dir, 
        arbeitsschritt(From, Dir, _, To), 
        DirektListe),
    sum_list(DirektListe, Direkt),
    Anzahl is Direkt + Indirekt.

%% ?- zulieferzahl(wumme27, galaxy2004, Anzahl).
%% Anzahl = 10.
