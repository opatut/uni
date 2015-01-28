% == Blatt 08 ==
% Konietzny
% Bienkowski
% Deinert

%%% Aufgabe 1

listmaxabs([], 0).
listmaxabs([X|Xs], M):-
    listmaxabs(Xs, Ms),
    M is max(abs(X), Ms).

divideEach([], _, []).
divideEach([X|R], F, [Y|S]) :-
    Y is X / F,
    divideEach(R, F, S).

% normalize(+SIn, -SOut).
% Normalisiert SIn nach SOut.
normalize(SIn, SOut) :-
    listmaxabs(SIn, MaxAbs),
    divideEach(SIn, MaxAbs, SOut).

%% ?- normalize([1,2,3,5,-10], X).
%% X = [0.1, 0.2, 0.3, 0.5, -1].

%% ?- sound(1,_,Xs), normalize(Xs, Xn).
%% Xs = [-0.0016174316, -0.020721436, 0.0017700195, 0.011230469, -0.011505127, -0.0020141602, -0.018005371, 0.0017700195, 0.015045166|...],
%% Xn = [-0.016510902975218022, -0.2115264839039807, 0.01806853546619462, 0.114641746844314, -0.11744548308228996, -0.020560748064243167, -0.18380062168551933, 0.01806853546619462, 0.1535825540146792|...].

% nulldurchgangsdichte(+Liste, -Zahl).
% Zählt Nulldurchgänge in der Liste.
nulldurchgangszahl([], 0) :- !.
nulldurchgangszahl([_], 0) :- !.
nulldurchgangszahl([A,B|R], Zahl) :-
    As is sign(A),
    Bs is sign(B),
    As = Bs,
    nulldurchgangszahl([B|R], Zahl).
nulldurchgangszahl([A,B|R], Zahl) :-
    As is sign(A),
    Bs is sign(B),
    As \= Bs,
    nulldurchgangszahl([B|R], Zahl1),
    Zahl is Zahl1 + 1.

% Berechnet Dichte aus Nulldurchgangszahl und Sample-Zahl.
nulldurchgangsdichte(Xs, Dichte) :-
    nulldurchgangszahl(Xs, Zahl),
    length(Xs, Length),
    Dichte is Zahl / Length.


%%% 1.3.
%%%sound(Signal,_, A), nulldurchgangsdichte(A, Dichte).
%%%Signal = 1,
%%%A = [-0.0016174316, -0.020721436, 0.0017700195, 0.011230469, -0.011505127, -0.0020141602, -0.018005371, 0.0017700195, 0.015045166|...],
%%%Dichte = 0.498125 ;
%%%Signal = 2,
%%%A = [0.052612305, 0.046630859, 0.013122559, 0.062896729, 0.036529541, -0.02923584, 0.018341064, 0.062652588, 0.014038086|...],
%%%Dichte = 0.49375 ;
%%%Signal = 3,
%%%A = [0.13595581, -0.13372803, 0.017883301, 0.043426514, -0.081512451, 0.07824707, 0.067138672, -0.022674561, -0.082092285|...],
%%%Dichte = 0.519375 ;
%%%Signal = 4,
%%%A = [0.030090332, 0.038787842, 0.04095459, 0.04107666, 0.041259766, 0.035888672, 0.038970947, 0.023742676, 0.027862549|...],
%%%Dichte = 0.07125 ;
%%%Signal = 5,
%%%A = [-0.65481567, -0.6524353, -0.6628418, -0.67681885, -0.68585205, -0.65148926, -0.62698364, -0.50134277, -0.32418823|...],
%%%Dichte = 0.058125 ;
%%%Signal = 6,
%%%A = [0.0057067871, 0.006652832, -0.0014038086, -0.0059509277, -0.0026550293, -0.0018920898, -0.0076904297, -0.016998291, -0.026977539|...],
%%%Dichte = 0.036875 ;
%%%Signal = 7,
%%%A = [0.048065186, 0.054016113, 0.059997559, 0.067932129, 0.075256348, 0.081939697, 0.086029053, 0.08694458, 0.088134766|...],
%%%Dichte = 0.029375 ;
%%%Signal = 8,
%%%A = [0.010162354, 0.009765625, 0.0075683594, 0.0062255859, 0.0023498535, -0.00051879883, -0.0033569336, -0.0068664551, -0.0099487305|...],
%%%Dichte = 0.01875 ;
%%%Signal = 9,
%%%A = [0.02130127, 0.017272949, 0.0058288574, -0.00012207031, 0.0015258789, -0.0015258789, -0.0049743652, -0.0087890625, -0.011505127|...],
%%%Dichte = 0.02125 ;
%%%Signal = 10,
%%%A = [0.037475586, 0.03729248, 0.033172607, 0.024993896, 0.016937256, 0.0098876953, 0.0015563965, -0.0034179688, -0.0098876953|...],
%%%Dichte = 0.03 ;

%%%Die nulldurchgangsdichte für stimmhafte Laute ist < 0.05 und die nulldurchgangsdichte
%%% für stimmlose Laute ist >= 0.05.

% klassifizierung(+Dichte, -Klasse).
klassifizierung(Dichte, stimmlos):- Dichte >= 0.05.
klassifizierung(Dichte, stimmhaft):- Dichte < 0.05.

%%%?- sound(Signal,_, A), nulldurchgangsdichte(A, Dichte), klassifizierung(Dichte, Klasse).

%%%Signal = 11,
%%%A = [0.10559082, 0.10357666, 0.10308838, 0.10339355, 0.097747803, 0.094970703, 0.091705322, 0.084747314, 0.079467773|...],
%%%Dichte = 0.0275,
%%%Klasse = stimmhaft ;
%%%Signal = 12,
%%%A = [0.27130127, -0.52667236, 0.32150269, 0.17532349, -0.39401245, 0.28158569, 0.062469482, -0.23303223, 0.19906616|...],
%%%Dichte = 0.666875,
%%%Klasse = stimmlos ;
%%%Signal = 13,
%%%A = [-0.030761719, -0.028930664, -0.031890869, -0.032562256, -0.031433105, -0.036010742, -0.037017822, -0.036132812, -0.037719727|...],
%%%Dichte = 0.056875,
%%%Klasse = stimmlos ;
%%%Signal = 14,
%%%A = [-0.0077819824, -0.010620117, -0.017547607, -0.021972656, -0.021881104, -0.016082764, -0.0085754395, -0.0031433105, -0.0013427734|...],
%%%Dichte = 0.055,
%%%Klasse = stimmlos ;
%%%Signal = 15,
%%%A = [-0.0077819824, -0.010620117, -0.017547607, -0.021972656, -0.021881104, -0.016082764, -0.0085754395, -0.0031433105, -0.0013427734|...],
%%%Dichte = 0.055,
%%%Klasse = stimmlos ;
%%%Signal = 16,
%%%A = [0.074676514, 0.059234619, 0.051025391, 0.060791016, 0.06338501, 0.015563965, -0.011230469, 0.034637451, 0.030609131|...],
%%%Dichte = 0.295,
%%%Klasse = stimmlos ;
%%%Signal = 17,
%%%A = [0.034820557, -0.006072998, -0.038116455, 0.0062561035, 0.010345459, -0.04675293, -0.02722168, 0.0099182129, -0.025909424|...],
%%%Dichte = 0.13625,
%%%Klasse = stimmlos ;
%%%Signal = 18,
%%%A = [-0.1178894, -0.12380981, -0.12902832, -0.13687134, -0.14535522, -0.14981079, -0.15423584, -0.15811157, -0.16415405|...],
%%%Dichte = 0.0375,
%%%Klasse = stimmhaft ;


%%% Aufgabe 2

%% [
%%    [pair(Key, Value), pair(Key, Value), ...],
%%    [pair(Key, Value), pair(Key, Value), ...],
%%    [pair(blah, Value), pair(rofl, Value), ...],
%%    [pair(Key, Value), pair(Key, Value), ...],
%%    [pair(Key, Value), pair(Key, Value), ...],
%% ]
%%
%% Buckets sind in einer Liste, Bucket-Schlüssel ist Index.
%% Jeder Bucket ist eine Liste von Strukturen pair(Key, Value).

% make_hashtable(+Length, -EmptyTable).
make_hashtable(0, []) :- !.
make_hashtable(Size, [[]|Rest]) :-
    Size1 is Size - 1,
    make_hashtable(Size1, Rest).

%% ?- make_hashtable(5, X).
%% X = [[], [], [], [], []].

hash_help([], 0).
hash_help([X|R], H) :-
    hash_help(R, HR),
    H is X + 256 * HR.

hash(Key, Hash) :-
    atom_codes(Key, Codes),
    hash_help(Codes, Hash).

%% ?- hash(hallo, X).
%% X = 478560412008.

% replace_nth(+N, +Replacement, +OldList, -NewList).
replace_nth(0, Replacement, [_|OldRest], [Replacement|OldRest]) :- !.
replace_nth(N, Replacement, [Head|OldRest], [Head|NewRest]) :-
    N > 0,
    N1 is N - 1,
    replace_nth(N1, Replacement, OldRest, NewRest).

% insert(+Key, +Value, +Table, -NewTable).
insert(Key, Value, Table, NewTable) :-
    length(Table, N),
    hash(Key, Hash),
    BucketIndex is Hash mod N,
    nth0(BucketIndex, Table, Bucket),
    NewBucket = [pair(Key, Value)|Bucket],
    replace_nth(BucketIndex, NewBucket, Table, NewTable).

%% ?- make_hashtable(5, Empty), insert(hallo, welt, Empty, Result).
%% Empty = [[], [], [], [], []],
%% Result = [[], [], [], [pair(hallo, welt)], []].

% insert_all(+Elements, +Table, -NewTable).
insert_all([], Table, Table) :- !.
insert_all([[Key,Value]|Rest], Table, NewTable) :-
    insert(Key, Value, Table, IntTable),
    insert_all(Rest, IntTable, NewTable).

% test_hashtable(+Size, -Table).
% Gibt uns die Hashtable der Größe `Size` mit den Werten aus textindex.
test_hashtable(Size, Table) :-
    index(Liste),
    make_hashtable(Size, EmptyTable),
    insert_all(Liste, EmptyTable, Table).

% get(+Key, +Table, -Value).
get(Key, Table, Value) :-
    length(Table, N),
    hash(Key, Hash),
    BucketIndex is Hash mod N,
    nth0(BucketIndex, Table, Bucket),
    member(pair(Key, Value), Bucket).

%% ?- test_hashtable(5, X), get(kaffee, X, R).
%% X = [[pair(kaffee, 469), pair(vielleicht, 458), pair(new, 447), pair(bereit, 443), pair(entwickler, 416), pair(coders, 411), pair(passe, 391), pair(..., ...)|...], [pair('klappt\'s', 459), pair(geschrieben, 439), pair(unkonventionalitaet, 433), pair(bannon, 398), pair(aktion, 385), pair(message, 370), pair(..., ...)|...], [pair(lieber, 470), pair(schreiben, 456), pair(empfehlung, 455), pair(arbeiten, 450), pair(nachhaltigkeit, 431), pair(..., ...)|...], [pair(bier, 463), pair(einfach, 453), pair(york, 448), pair(unternehmen, 425), pair(..., ...)|...], [pair(fahne, 438), pair(fun, 435), pair(kennt, 417), pair(..., ...)|...]],
%% R = 469 .

% 2.6. Unsere Implementation kann mehrere Key-Value-Paare mit demselben Key
% einfügen, und gibt diese auch alle wieder zurück.

% Mappt buckets auf ihre Längen
% bucket_ch (+Buckets, -Counts).
bucket_counts([], []) :- !.
bucket_counts([Bucket|Table], [Count|Counts]) :-
    length(Bucket, Count),
    bucket_counts(Table, Counts).

% stats(+Table, -Min, -Max, -Avg).
% Berechnet Bucket-Auslastungen der Tabelle.
stats(Table, Min, Max, Avg) :-
    bucket_counts(Table, Counts),
    min_list(Counts, Min),
    max_list(Counts, Max),
    sum_list(Counts, Sum),
    length(Table, N),
    Avg is Sum / N.

% quality(+Table, -Quality).
% Gibt einen Wert der Qualität einer Tabelle: max((avg-min), (max-avg))/avg
quality(Table, Quality) :-
    stats(Table, Min, Max, Avg),
    MinDiff is Avg - Min,
    MaxDiff is Max - Avg,
    Quality is max(MinDiff, MaxDiff) / Avg.

% test_qualities(+MaxN, -N, -Quality).
test_qualities(MaxN, N, Quality) :-
    numlist(2, MaxN, Ns),
    select(N, Ns, _),
    test_hashtable(N, Table),
    quality(Table, Quality).

%% ?- test_qualities(100, N, Q), Q < 0.2.
%% N = 2,
%% Q = 0.1943127962085308 ;
%% N = 3,
%% Q = 0.037914691943128034 ;
%% N = 5,
%% Q = 0.1469194312796209 ;
%% N = 7,
%% Q = 0.16113744075829387 ;

%% Anscheinend liefern Hashtables mit 2/3/5/7
%% (Primzahlen) buckets die besten Ergebnisse.
