% Blatt 07 - Konietzny, Bienkowski, Deinert

%%% Aufgabe 1

% ?- [A,m,A] = [B,B,n]
% false.
%% ist quasi
%% A=B,B=m,A=n.
%% und damit natürlich nicht unifizierbar.

% ?- [0,[T,1,T],S,[1,S,1]] = [M,N,[M,1,N],[1,0,1],N].
% false.
%% Die Listen sind unterschiedlich lang.

% ?- [D,D|E] = [[P,b], [a|Q], [Q,P], [P,Q], [P|Q], [Q|P]].
% D = [a, b],
% E = [[[b], a], [a, [b]], [a, b], [[b]|a]],
% P = a,
% Q = [b].
%% Geht halt gut auf.
%% Z.B.:
%% D=[P,b],D=[a|Q],E=[[Q,P], [P,Q], [P|Q], [Q|P]].
%% P=a,Q=[b], E=[...].

% ?- [r|W] = [V,V,V].
% W = [r, r],
% V = r.
%% denn
%% r=V,W=[V,V].

%%% Aufgabe 2

% 2.1
% newnumlist/3(?Low, ?High, ?List).
newnumlist(High, High,[High]).
newnumlist(Low,High,List):-
    Low<High,
    Newlow is Low + 1,
    newnumlist(Newlow, High, SmallerList),
    List = [Low | SmallerList].
%% ?- newnumlist(1, 5, L).
%% L = [1, 2, 3, 4, 5] ;
%% false.

% 2.2
% newnth0(+Element, +Liste, -Index).
newnth0(0,[H|_],H).
newnth0(N,[_|T],Element) :-
    M is (N-1),
    newnth0(M,T,Element).
%% ?- newnth0(4, [0,1,2,3,5,3,4,4], I).
%% I = 5 ;
%% false.

%% Beide unsere Prädikate laufen nach der ersten Lösung weiter,
%% liefern aber keine weiteren Ergebnisse, sondern `false`.


%%% Aufgabe 3

% 3.1

% ungerade(+Wert).
ungerade([1|_]).
%% ?- ungerade([1,0,0,1]).
%% true.
%% ?- ungerade([0,0,0,1]).
%% false.

% gerade(+Wert).
gerade(Z) :- \+ ungerade(Z).
%% ?- gerade([1,0,0,1]).
%% false.
%% ?- gerade([0,0,0,1]).
%% true.
%% ?- gerade([]).
%% true.
%% Die Null (0) ist gerade.

% Alternativ/explizit:
%% gerade([0|_]).
%% gerade([]).

% 3.2

% doppelt(+Wert, -Ergebnis).
doppelt(Wert, [0|Wert]) :- Wert \= [].
doppelt([], []).
%% ?- doppelt([1], X).
%% X = [0, 1].
%% ?- doppelt([], X).
%% X = [].

% halb(+Wert, -Ergebnis).
halb([0|Wert], Wert) :- Wert \= [].
halb([], []).
%% ?- halb([0, 1], X).
%% X = [0, 1].
%% ?- halb([], X).
%% X = [].
%% ?- halb([1,0,0,1], X).
%% false.

% 3.3
geradeMachen([1|Rest], [0|Rest]).
%% ?- geradeMachen([1,0,0,1], X).
%% X = [0, 0, 0, 1].
%% ?- geradeMachen([0,0,0,1], X).
%% false.


% 3.4
bz([]).
bz([0|R]) :- bz(R).
bz([1|R]) :- bz(R).
%% ?- bz([1,0,1]).
%% true.
%% ?- bz([]).
%% true.
%% ?- bz([1, 2, 3]).
%% false.

% 3.5
bz2nat([], 0).
bz2nat([0|R], N) :-
    bz2nat(R, WertR),
    N is 2 * WertR.
bz2nat([1|R], N) :-
    bz2nat(R, WertR),
    N is 2 * WertR + 1.
%% ?- bz2nat([0,1,1,1], N).
%% N = 14.
%% ?- bz2nat([], N).
%% N = 0.

nat2bz(0, []).
nat2bz(N, B) :-
    Mod is N mod 2,
    NRest is (N - Mod) / 2,
    nat2bz(NRest, Rest),
    B = [Mod | Rest].
%% ?- nat2bz(100, X).
%% X = [0, 0, 1, 0, 0, 1, 1] ;
%% X = [0, 0, 1, 0, 0, 1, 1, 0] ;
%% X = [0, 0, 1, 0, 0, 1, 1, 0, 0] ...
%% ?- nat2bz(0, X).
%% X = [] ;
%% X = [0] ;
%% X = [0, 0] ...


% 3.6

volladdierer(X, Y, CarryIn, Sum, CarryOut) :-
    FullSum is X + Y + CarryIn,
    Sum is FullSum mod 2,
    CarryOut is (FullSum - Sum) / 2.
%% ?- volladdierer(1, 0, 1, S, C).
%% S = 0,
%% C = 1.
%% ?- volladdierer(1, 1, 1, S, C).
%% S = C, C = 1.
%% ?- volladdierer(0, 0, 0, S, C).
%% S = C, C = 0.
%% ?- volladdierer(0, 0, 1, S, C).
%% S = 1,
%% C = 0.

% 3.7

% Als erstes definieren wir ein Prädikat, welches
% eine Liste auf eine fixe Länge bringt, mit 0-en dran.
pad(X, Length, X) :-
    length(X, LengthActual),
    LengthActual >= Length.
pad(X, Length, Xout) :-
    length(X, LengthActual),
    LengthActual < Length,
    append(X, [0], New),
    pad(New, Length, Xout).
%% ?- pad([1,0,1], 5, L).
%% L = [1, 0, 1, 0, 0] .


% Dieses Prädikat bringt 2 Listen auf die gleiche Länge.
samelength(X, Y, Xout, Yout) :-
    length(X, XLength),
    length(Y, YLength),
    Length is max(XLength, YLength),
    pad(X, Length, Xout),
    pad(Y, Length, Yout).
%% ?- samelength([1,0], [1,0,1], X, Y).
%% X = [1, 0, 0],
%% Y = [1, 0, 1].

% Hier addieren wir.
bzadd(X, Y, S) :-
    samelength(X, Y, Xpad, Ypad),
    bzadd_help(Xpad, Ypad, S, 0).
%% ?- bzadd([1,0,1], [0,1], E).
%% E = [1, 1, 1].
%% ?- bzadd([1,1,1,1], [1], E).
%% E = [0, 0, 0, 0, 1] .

bzadd_help(X, Y, S, CarryIn) :-
    X = [X1|XR],
    Y = [Y1|YR],
    S = [S1|SR],
    volladdierer(X1, Y1, CarryIn, S1, CarryOut),
    bzadd_help(XR, YR, SR, CarryOut).
bzadd_help([], [], [], 0).
bzadd_help([], [], [1], 1).
