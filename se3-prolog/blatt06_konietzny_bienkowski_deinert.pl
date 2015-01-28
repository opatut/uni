% Blatt 06 - Konietzny, Bienkowski, Deinert

%%% Aufgabe 1 %%%

goldener_schnitt_1(0, 1).
goldener_schnitt_1(Schritt, Resultat) :-
    Schritt > 0,
    Vorschritt is Schritt - 1,
    goldener_schnitt_1(Vorschritt, VorschrittResultat),
    Resultat is (1 / (VorschrittResultat) + 1).
%% ?- goldener_schnitt(10, R).
%% R = 1.6179775280898876 .


goldener_schnitt_step(Akku, 0, Akku).
goldener_schnitt_step(Akku, StepsLeft, Result) :-
    StepsLeft > 0,
    Zwischen is ((1 / Akku) + 1),
    StepsLeftNow is StepsLeft - 1,
    goldener_schnitt_step(Zwischen, StepsLeftNow, Result).

goldener_schnitt_2(Steps, Result) :-
    goldener_schnitt_step(1, Steps, Result).
%% ?- goldener_schnitt_2(10, R).
%% R = 1.6179775280898876 .

% goldener_schnitt_1: Rekursiver Abstieg
% goldener_schnitt_2: Rekursiver Aufstieg, Endrekursion

%% Ein bisschen Benchmarking! Man beachte, dass die nicht-endrekursive Lösung bei
%% sehr vielen Rekursionsschritten `out of stack` läuft. Die Endrekursion ist natürlich
%% wensentlich schneller, je größer die Rekursionstiefe.

%% ?- time(goldener_schnitt(100000, R)).
%% % 200,000 inferences, 0.751 CPU in 0.750 seconds (100% CPU, 266403 Lips)
%% R = 1.618033988749895 .

%% ?- time(goldener_schnitt_2(100000, R)).
%% % 200,001 inferences, 0.029 CPU in 0.030 seconds (99% CPU, 6832702 Lips)
%% R = 1.618033988749895 .

%% ?- time(goldener_schnitt(10000000, R)).
%% % 2,796,057 inferences, 0.490 CPU in 0.508 seconds (96% CPU, 5705894 Lips)
%% ERROR: Out of local stack

%% ?- time(goldener_schnitt_2(10000000, R)).
%% % 20,000,001 inferences, 2.714 CPU in 2.716 seconds (100% CPU, 7370522 Lips)
%% R = 1.618033988749895 .

%% Für 10e-10 Genaugkeit braucht man 28 Rekursionsschritte. Empirisch ausprobiert.


%%% Aufgabe 2 %%%

% 2.1

nat_zahl_help(Akku, Result) :-
    Result is Akku;
    nat_zahl_help(Akku + 1, Result).

% nat_zahl(?X).
% Generiert natürliche Zahlen.
nat_zahl(X) :-
    nat_zahl_help(0, X).

% 2.2
nat_zahl_max_help(Max, Akku, Result) :-
    Result is Akku;
    (Max > Akku, nat_zahl_max_help(Max, Akku + 1, Result)).

% nat_zahl_max(+Max, ?X).
% Generiert natürliche Zahlen bis Max in X.
nat_zahl_max(Max, X) :-
    nat_zahl_max_help(Max, 0, X).

%% ?- nat_zahl_max(5, X).
%%    X = 0 ;
%%    X = 1 ;
%%    X = 2 ;
%%    X = 3 ;
%%    X = 4 ;
%%    X = 5 ;
%%    false.

% 2.3
goldener_schnitt_incr_step(Akku, 0, Akku).
goldener_schnitt_incr_step(Akku, StepsLeft, Result) :-
    StepsLeft > 0,
    (Result is Akku; (
        Zwischen is ((1 / Akku) + 1),
        StepsLeftNow is StepsLeft - 1,
        goldener_schnitt_incr_step(Zwischen, StepsLeftNow, Result)
    )).

goldener_schnitt_incr(Steps, Result) :-
    goldener_schnitt_incr_step(1, Steps, Result).

% Beispielaufruf siehe Aufgabenblatt.

% 2.4
%% Nach 8 Schritten ist der Genaugkeitsgewinn kleiner als ein Pixel.


%%% Aufgabe 3 %%%

% 3.1

% binarytree(+X).
% Typtest für Binärbäume, Struktur siehe Aufgabenblatt.

binarytree(X) :-
    atom(X).

binarytree(s(X, Y)) :-
    binarytree(X), binarytree(Y).

%% ?- binarytree(a).
%% true.

%% ?- binarytree(s(a, b)).
%% true.

%% ?- binarytree(p(a, b)).
%% false.

%% ?- binarytree(s(a)).
%% false.

%% ?- binarytree(s(s(a, b), c)).
%% true.

% 3.2

% blatttiefe(+Baum, -Tiefe).
% Sodass die Tiefe die Blatttiefen des Baumes angibt.

blatttiefe(Baum, 0) :-
    atom(Baum).

blatttiefe(s(X, Y), Tiefe) :-
    binarytree(s(X, Y)),
    blatttiefe(X, XTiefe),
    Tiefe is XTiefe + 1.

blatttiefe(s(X, Y), Tiefe) :-
    binarytree(s(X, Y)),
    blatttiefe(Y, YTiefe),
    Tiefe is YTiefe + 1.

%% ?- blatttiefe(s(a, s(s(s(a,c), b), s(c, d))), T).
%% T = 1 ;
%% T = 4 ;
%% T = 4 ;
%% T = 3 ;
%% T = 3 ;
%% T = 3.

% 3.3

% max_blatttiefe_*(+Tree, -MaxTiefe).
% Gibt die Maximale Tiefe des Baumes (auf 3 Arten) an.

max_blatttiefe_1(Tree, MaxTiefe) :-
    findall(Tiefe, blatttiefe(Tree, Tiefe), Liste),
    max_list(Liste, MaxTiefe).

%% ?- max_blatttiefe_1(s(s(s(a,c),b),c), T).
%% T = 3.

% Alternativ, ohne max_list/2
max_blatttiefe_2(Tree, MaxTiefe) :-
    blatttiefe(Tree, MaxTiefe), \+ (blatttiefe(Tree, Tiefe), Tiefe > MaxTiefe).

%% ?- max_blatttiefe_2(s(s(s(a,c),b),c), T).
%% T = 3.

% 3.4
max_blatttiefe_3(X, 0) :-
    atom(X).

max_blatttiefe_3(s(X, Y), Tiefe) :-
    max_blatttiefe_3(X, XTiefe),
    max_blatttiefe_3(Y, YTiefe),
    Tiefe is 1 + max(XTiefe, YTiefe).

%% ?- max_blatttiefe_3(s(s(s(a,c),b),c), T).
%% T = 3.


% 3.5

% min_max_blatttiefe(+Tree, -Min, -Max).
% Sodass Min die minimale und Max die maximale Blatttiefe des Baumes ist.

min_max_blatttiefe(X, 0, 0) :-
    atom(X).

min_max_blatttiefe(s(X, Y), Min, Max) :-
    min_max_blatttiefe(X, XMin, XMax),
    min_max_blatttiefe(Y, YMin, YMax),
    Min is 1 + min(XMin, YMin),
    Max is 1 + max(XMax, YMax).


% balanciert(+Tree).
% Tree ist balanciert.

balanciert(Tree) :-
    min_max_blatttiefe(Tree, Min, Max),
    (Min = Max ; Min =:= Max - 1).

%% ?- balanciert(s(s(a,s(c,x)), d)).
%% false.

%% ?- balanciert(s(s(a,s(c,x)), s(d,a))).
%% true.
