#include <incmode>.


#program base.

dist(0..24).
rock(0..4).
cell((0..11,0..11)).

%good(0..1). %replaced by target_sample without aggregate (assume that the agent decides based only on the initial condition of the environment)

loc(0, (2,2)).
loc(1, (5,2)).
loc(2, (2,4)).
loc(3, (9,9)).

at((0,0), 1).

guess(0,70).
guess(1,40).
guess(2,90).
guess(3,10).

%dist(R, X) :- ...


#program step(t).




#program check(t).
%:- query(t), t<2.
:- query(t), not sampled(R,t), target_sample(R).



#show east/1.
#show south/1.
#show north/1.
#show west/1.
#show sample/2.
%#show target_sample/1.
%#show dist/2.