#include <incmode>.


#program base.

rock(0..4).
cell((0..10,0..10)).

good(0).
good(1).

guess(0, 60).
guess(1, 80).
guess(2, 30).
guess(3, 20).

loc(0, (1,0)).
loc(1, (5,2)).
loc(2, (8,6)).
loc(3, (1,9)).

at((0,0), 1). %location (0,0) at time 1


#program step(t).
%tO BE COMPLEtED (action preconditions as aggregates, 
%effects and constraints...)
%possible actions are east/north/south/west(t) + sample(R, t)

% 1
% { action : precondition }
% 2
% action(t)     :- precondition(t)
% effects(t+1)  :- action(t)


1 { 
	%target_sample(R, t) :  d < 4, dist(R, d, t);
	target_sample(R, t) :  guess(R, X), X > 50,Y < 4, dist(R, Y, t);
    east(t) ; % : 
    west(t) ; % :  
    north(t); % 
    south(t) % 
    } 1.

at((X,Y),t+1) :- target_sample(R), at((X,Y),t).
at((X+1,Y),t+1) :- east(t), at((X,Y),t).

at((X-1,Y),t+1) :- west(t), at((X,Y),t).

at((X,Y-1),t+1) :- north(t), at((X,Y),t).

at((X,Y+1),t+1) :- south(t), at((X,Y),t).

dist(R, |X-Z|+|Y-J|, t+1) :- at((X,Y), t), loc(R,(Z,J)).

at((X,Y),t+1) :- target_sample(R, t), at((X,Y),t).
sampled(R,t+1) :- target_sample(R,t).
sampled(R, t+1) :- sampled(R, t).

#program check(t).
%:- query(t), t<30. %debug purpose
:- query(t), not sampled(R,t), rock(R), good(R). %all good rocks must be sampled



#show east/1.
#show south/1.
#show north/1.
#show west/1.
%#show sample/2.
#show sampled/2. 
#show at/2.
#show loc/2.
%#show dist/2.
#show target_sample/2.
