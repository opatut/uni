% draw(Size)
% draws a graphics with a given Size

draw(Size) :-
   % prepare a Display to draw the object on
   % generate a new display name
   gensym(w,Display),
   free('@'Display),
   % define size of the display (picture size + scroll bar area)
   SizeD is Size+20,
   % create a new display and open it
   new('@'Display,picture('*** Your picture''s name ***',size(SizeD,SizeD))),
   send('@'Display,open),
   send('@'Display,background,colour(white)), %* MK: ggf. Farbe auf 'white' stellen

   % draw the object on the display
   (
        draw_object('@'Display,Size,Size /* , ***add additional parameters if needed *** */),
        draw_fibonacci('@'Display,Size);
        true
   ),
   % if desired save the display as .jpg
   write_ln('Save the graphics (y/n): '),
   get_single_char(A),
   put_code(A),nl,
   (A=:=121 ->
     (write_ln('enter file name: '),
      read_line_to_codes(user_input,X),
      atom_codes(File,X),
      atom_concat(File,'.jpg',FileName),
      get('@'Display,image,Image),
      send(Image,save,FileName,jpeg) ) ; true ),

   !.


% draw_object(Display,Size,CurrentSize,*** add additional parameters here, if needed ***)
% draws a gradient graphics of size Size into Display
% CurrentSize is decreased recursively fom Size to 0
draw_object(_,_,0 /* , *** add additional parameters here, if needed *** */). 
draw_object(Name,Size,CSize /* , *** add additional parameters here, if needed *** */) :- 
   CSize > 0 ,        % only for positive integers


    %free(@box),
    gensym(w,XBox),
    new('@'XBox, box(Size, CSize)),
    send(Name, display, '@'XBox),
    %%%%%%%Erstellen von eigenen Farben scheint nicht zu funktionieren.
    %%%%%%%Zum erstellen eines monochromen Verlaufs wählt man jedoch einfach für R,G 
    %%%%%%%und B CSize als Wert.
  % decrement CurrentSize and call draw_object recursively
  CSizeNew is CSize - 2,
% writeln(CSizeNew),
  draw_object(Name,Size,CSizeNew).

draw_fibonacci(Name,Size) :-
    Mid is Size / 2,
    Bottom is Mid + 1,
    draw_step(Name, 0, 1, box(Mid, Mid, Mid, Bottom), top).

% Get the next direction from the previous one
rotate_right(left, bottom).
rotate_right(bottom, right).
rotate_right(right, top).
rotate_right(top, left).

% expand_box(Before, Direction, Size, After).
expand_box(box(L, T, R, B), left,   Size, box(L2, T, R, B)) :- L2 is L - Size.
expand_box(box(L, T, R, B), top,    Size, box(L, T2, R, B)) :- T2 is T - Size.
expand_box(box(L, T, R, B), right,  Size, box(L, T, R2, B)) :- R2 is R + Size.
expand_box(box(L, T, R, B), bottom, Size, box(L, T, R, B2)) :- B2 is B + Size.

draw_step(Name, PrevSize, Size, Box, Direction) :-
    Size < 400,

    Box = box(L, T, R, B),
    W is R - L,
    H is B - T,
    print(Size),
    print(' '),
    print(Box),
    print('\n'),
    gensym(w,XName),
    new('@'XName, box(W, H)),
    send(Name, display, '@'XName, point(L, T)),

    % Next step
    NextSize is PrevSize + Size,
    rotate_right(Direction, NextDirection),
    expand_box(Box, Direction, Size, NewBox),
    draw_step(Name, Size, NextSize, NewBox, NextDirection).


% Call the program and see the result


% Call the program and see the result
:- draw( 400 ).   % specify the desired display size in pixel here (required argument)   




% ========== Tests from XPCE-guide Ch 5 ==========

% destroy objects
mkfree :-
   free(@p),
   free(@bo),
   free(@ci),
   free(@bm),
   free(@tx),
   free(@bz).

% create picture / window
mkp :-
   new( @p , picture('Demo Picture') ) ,
   send( @p , open ).

% generate objects in picture / window
mkbo :-
   send( @p , display , new(@bo,box(100,100)) ).
mkci :-
   send( @p , display , new(@ci,circle(50)) , point(25,25) ).
mkbm :-
   send( @p , display , new(@bm,bitmap('32x32/books.xpm')) , point(100,100) ).
mktx :-
   send( @p , display , new(@tx,text('Hello')) , point(120,50) ).
mkbz :-
   send( @p , display , new(@bz,bezier_curve(
	 point(50,100),point(120,132),point(50,160),point(120,200))) ).

% modify objects
mkboc :-
   send( @bo , radius , 10 ).
mkcic :-
   send( @ci , fill_pattern , colour(orange) ).
mktxc :-
   send( @tx , font , font(times,bold,18) ).
mkbzc :-
   send( @bz , arrows , both ).

