% Blatt 09 - Konietzny, Bienkowski, Deinert

% Regel-Format:
% rule(Patterns, Responses, Conditions).
% Pattern:  [Variable, Variable, [fixed1, fixed2], Variable, [fixed3]]
% Response: ['Some stuff to say about ', Variable, ', and more stuff!']
% Conditions: Anything that has to apply to all Variables. Can generate new variables (transform).
% Beispiele siehe "RULES".

%%%%%%%%%%%%%%%%% CONDITIONS %%%%%%%%%%%%%%%%%%%

max_length(V, L) :-
    length(V, VL),
    VL =< L.

replace([], [], _, _).
replace([I|In], [O|Out], Before, After) :-
    ((
        nth0(Index, Before, I),
        nth0(Index, After, O)
    ); (
        \+ member(I, Before),
        I = O
    )),
    replace(In, Out, Before, After).


replace_swap(In, Out, One, Two) :-
    append(One, Two, Left),
    append(Two, One, Right),
    replace(In, Out, Left, Right).

shift_perspective(In, Out) :-
    replace_swap(In, Out,
        [i, my, me, mine, am],
        [you, your, you, yours, are]).

%%%%%%%%%%%%%%%%% RULES %%%%%%%%%%%%%%%%%%%

% Greetings
rule([
        [[my,name,is],Name,_],
        [_, [my,name,is],Name,_],
        [[i,am,called],Name,_],
        [[call,me],Name,_]
    ], [
        ['Hello ',Name,', nice to meet you!']
    ], [
        max_length(Name, 1)
    ]).

% Yes
rule([
        [[yes], _],
        [[indeed], _],
        [[hell,yeah], _],
        [[ok], _],
        [[okay], _]
    ], [
        ['Alright then.'],
        ['Good.'],
        ['Okay.'],
        ['Fine.'],
        ['Yes?']
    ], []).

% No
rule([
        [[no], _],
        [[nope], _],
        [[never], _],
        [[nein], _]
    ], [
        ['Why not?'],
        ['So...?'],
        ['Too bad.'],
        ['Would you explain why you don''t think so?']
    ], []).

% 'I am' can either be a name or some state the person is in, so be generic :)
rule([
        [[i,am],Thing,Punctuation]
    ], [
        ['So you are ', Thing2, '?'],
        ['Are you 100% sure about that?']
    ], [
        shift_perspective(Thing,Thing2),
        max_length(Punctuation, 1)
    ]).

% Say hello
rule([
        [[hello],_],
        [[good,morning],_],
        [[good,day],_],
        [[hi],_],
        [[hey],_]
    ], [
        ['Hi!'],
        ['Hello there!'],
        ['Good day, sir or madam!']
    ], []).

% Someone is shouting! :)
rule([
        [StatementMe,['!']]
    ], [
        ['Are you sure that ', StatementYou, '?'],
        ['Really? I didn''t know ', StatementYou, '.']
    ], [
        shift_perspective(StatementMe, StatementYou)
    ]).

% Generic reply to anything that looks like a question
rule([
        [_,['?']]
    ], [
        ['That depends...'],
        ['Maybe, maybe not.']
    ], []).

% Say bye properly
rule([
        [[goodbye], _],
        [[bye], _],
        [[quit], _],
        [[exit], _]
    ], [
        ['See you!'],
        ['Bye bye!'],
        ['Cheers!']
    ], []).

% Foo -> Bar
rule([[[foo],_]], [[bar]], []).

% Nothing matched?
rule([[_]], [
        ['What are you saying?'],
        ['Sorry, what are you trying to tell me?'],
        ['I didn''t quite catch that.']
    ], []).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RULES DONE, LOGIC FOLLOWS                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% List type check
list([]).
list([_|_]).

run :-
    write_sentence(['You may now talk to me! Tell me ''goodbye'' if you want to go.\n']),
    write_sentence(['Remember to use punctuation to finish your sentence, so I know when you''re done talking.\n']),
    loop.

loop :-
    read_sentence(Input),
    process(Input, Output),
    write_sentence(Output),
    print('\n'),
    % possibly repeat
    !, \+ is_goodbye(Input), loop.

write_sentence([]).

write_sentence([W|S]) :-
    list(W),
    write_words(W),
    write_sentence(S).

write_sentence([W|S]) :-
    \+ list(W),
    print(W),
    write_sentence(S).

write_words([]).
write_words([W]) :-
    print(W).
write_words([W|[A|B]]) :-
    print(W),
    print(' '),
    write_words([A|B]).

is_goodbye(Input) :- nth0(0, Input, bye).
is_goodbye(Input) :- nth0(0, Input, goodbye).
is_goodbye(Input) :- nth0(0, Input, quit).
is_goodbye(Input) :- nth0(0, Input, exit).


fulfill([]).
fulfill([C|Conditions]) :-
    C, fulfill(Conditions).

process(Input, Output) :-
    % Try each rule
    rule(Patterns, Responses, Conditions),

    % Try each pattern
    member(Pattern, Patterns),

    % Check pattern match
    match_full(Input, Pattern, []),

    % Fulfill conditions
    fulfill(Conditions),

    % Get a random response
    random_permutation(Responses, RandomResponses),
    RandomResponses = [Output|_],

    % Only one response each time.
    !.

%split_before(List, Index, Before, After).
%% split_before([], 0, [], []).
%% split_before(List, 0, [], List).
%% split_before([First|Remain], Index, [First|Before], After) :-
%%     NewIndex is Index - 1,
%%     split_before(Remain, NewIndex, Before, After).

split_before(List, Index, Before, After) :-
    append(Before, After, List),
    length(Before, Index).

% match_fixed(Input, Pattern, Before, After).
% match_fixed([a,b, c,d,e], [c,d], [a,b], [e]).

match_fixed(Input, Pattern, Before, After) :-
    Pattern = [First|_],
    nth0(FirstIndex, Input, First),
    split_before(Input, FirstIndex, Before, FromFirstIndex),
    length(Pattern, PatternLength),
    split_before(FromFirstIndex, PatternLength, Pattern, After).



match_var([], []).
match_var(Input, [V|Vars]) :-
    split_before(Input, Index, V, More),
    Index > 0,
    match_var(More, Vars).

%
match_full([], [], []).

match_full(Input, [], Vars) :-
    match_var(Input, Vars).

match_full(Input, [First|Pattern], BeforeVars) :-
    % this is a variable pattern part
    var(First),
    % skip it for now, remember the variable tho
    append(BeforeVars, [First], NewBeforeVars),
    match_full(Input, Pattern, NewBeforeVars).

match_full(Input, [First|Pattern], BeforeVars) :-
    % this is a fixed pattern part, e.g. [c,d]
    nonvar(First),
    match_fixed(Input, First, Before, After),
    match_full(After, Pattern, []),
    match_var(Before, BeforeVars).



%% Usage:
%% [read_sent].
%% [blatt09_konietzny_bienkowski_deinert].
%% run.

%% Der Bot kann nicht viel, aber die Logik dahinter ist schon relativ stark.
%% Mit mehr Zeit könnte man ihn wesentlich erweitern, sodass noch mehr verschiedene
%% Dialoge möglich sind.

%% Beispiel-Dialog:
%%
%% You may now talk to me! Tell me 'goodbye' if you want to go.
%% Remember to use punctuation to finish your sentence, so I know when you're done talking.
%% |: Hello, World.
%% Hello there!
%% |: How are you?
%% That depends...
%% |: My name is Paul.
%% Hello paul, nice to meet you!
%% |: Have we met before?
%% Maybe, maybe not.
%% |: I am sure we have.
%% Are you 100% sure about that?
%% |: Yes.
%% Alright then.
%% |: Bye.
%% See you!
