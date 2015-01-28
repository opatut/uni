%
% Aufgabenblatt 01 - SE3-LP WS1415
% 
% Carolin Konietzny 6523939
% Paul Bienkowski 6415133
% Julian Deinert 6535880
%


%%% Aufgabe 1 %%%

[familie].

% listing(mutter_von).

% assert(mutter_von(marie, peter)).
% asserta(mutter_von(marie, detlef)).
% assertz(mutter_von(marie, susanne)).

% Unterschied: `asserta` fügt am Anfang ein, `assertz` am Ende



%%% Aufgabe 2 %%%

% 1.a) Ist Charlotte die Mutter von Barbara?
mutter_von(charlotte, barbara).
% -> true

% 1.b) Heißt der Vater von Andrea Walter?
vater_von(walter, andrea).
% -> false

% 1.c) Wie heißt die Mutter von Andrea?
mutter_von(Name, andrea).
% -> barbara

% 1.d) Wie heißt die Mutter von Johannes?
mutter_von(Name, johannes)
% -> false

% 1.e) Welche Kinder hat Charlotte?
mutter_von(charlotte, K).
% dann N drücken für alle Ergebnisse
% -> K = barbara ;
%    K = magdalena.

% 1.f) Wer hat welche Kinder?
vater_von(A, B); mutter_von(A, B).

% 1.g) Hat Helga keine Kinder?
\+ mutter_von(helga, K).

% 1.h) Hat Barbara keine Kinder?
\+ mutter_von(barbara, K).

% 1.i) Hat Barbara Kinder?
\+ \+ mutter_von(barbara, K).


% 2.) Wie muessten Sie die Frage formulieren, wenn Sie die Enkelkinder von Char-
% lotte ermitteln wollen?

mutter_von(charlotte, K), (mutter_von(K, EK); vater_von(K, EK)
% -> K = barbara,
%    EK = klaus ;
%    K = barbara,
%    EK = andrea ;
%    false.

% 3.) ...
% Der Trace zeigt Einzelschritte an, welche von Prolog durchgeführt werden.
% - Call: Sucht eine Mögliche Belegung für Variablen in einer Relation.
% - Exit: Rückgabe einer möglichen Belegung.
% - Redo: Nächste mögliche Belegung anfordern.
% - Fail: Keine Belegung gefunden.
% Im Prinzip sehen wir die Tiefensuche in Einzelschritten, mit der die Ergebnisse nach und nach produziert werden.
