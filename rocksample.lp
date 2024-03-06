#include <incmode>.


#program base.

rock(0..4).
cell((0..10,0..10)).

good(0).
good(1).

loc(0, (2,5)).
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


0 { sample(R,t): at((X,Y),t), loc(R, (X,Y));
    east(t) ; % : at((X,Y),t) , X < 10; 
    west(t) ; % : at((X,Y),t) , X > 0; 
    north(t); % : at((X,Y),t) , Y > 0;
    south(t) % : at((X,Y),t) , Y < 10
    } 1.

at((X+1,Y),t+1) :- east(t), at((X,Y),t).

at((X-1,Y),t+1) :- west(t), at((X,Y),t).

at((X,Y-1),t+1) :- north(t), at((X,Y),t).

at((X,Y+1),t+1) :- south(t),at((X,Y),t).

at((X,Y),t+1) :- sample(R, t), at((X,Y),t).
sampled(R, t+1) :- sample(R,t).
sampled(R, t+1) :- sampled(R, t).

#program check(t).
% :- query(t), t>2. %debug purpose
:- query(t), not sampled(R,t), rock(R), good(R). %all good rocks must be sampled



#show east/1.
#show south/1.
#show north/1.
#show west/1.
#show sample/2.
#show sampled/2.
% #show at/2.
% #show loc/2.
