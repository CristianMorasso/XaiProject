rocks(0..3). %ids of rocks
ranges_dist(0..24). %12x12 grid
guess_value(0). %possible probabilities of goodness of rocks
guess_value(10).
guess_value(20).
guess_value(30).
guess_value(40).
guess_value(50).
guess_value(60).
guess_value(70).
guess_value(80).
guess_value(90).
guess_value(100).


%#modeb( var(ranges_dist) < const(const_value)).
%#modeb( var(ranges_dist) > const(const_value)).
%#modeb( var(guess_value) < const(const_guess_value)).
%#modeb( var(guess_value) > const(const_guess_value)).
%#modeb(dist(var(rocks), var(ranges_dist))).

%dist(rocks(r), ranges_dist(a)+ranges_dist(b)) :- delta_x(rocks(r), ranges_dist(a)), delta_y(rocks(r), ranges_dist(b)).
%min_dist(rocks(r)) :- dist(rocks(r), X), X < 2.
%max_dist(rocks(r)) :- dist(rocks(r), X), X > 2.

%best_guess(rocks(r)) :- guess(rocks(r), guess_value(a)), guess_value(a) > 50.
%worst_guess(rocks(r)) :- guess(rocks(r), guess_value(a)), guess_value(a) < 50.

%main atom for head: target_sample (use aggregate)
%main atoms for body: guess(rocks, guess_value); dist(rocks, ranges_dist)
%use (positive) flag and remove constraints from search space
%max rule length = 6, max body length = 4
%it is possible to introduce arithmetic comparison in body

%#pos(one,{target_sample(rocks),min_dist(rocks), best_guess(rocks)}, {}).
%#pos(one,{target_sample(0)}, {target_sample(1),target_sample(2)}, {dist(0,cd). guess(0,cg).}).
%#pos(one,{target_sample(1)}, {target_sample(0),target_sample(2)}, {dist(1,cd). guess(1,cg).}).
%#pos(one,{target_sample(2)}, {target_sample(1),target_sample(0)}, {dist(2,cd). guess(2,cg).}).


%5 ~ 1 {target_sample(V1) } 1 :- guess(V1,V2); dist(V1,V3); V3 < 1; V2 > 50.
%6 ~ 0 {target_sample(V1) } 1 :- guess(V1,V2); dist(V1,V3); V3 < 1; V2 > 50.
#pos(two,{target_sample(0)}, {}, {guess(0,3). dist(0,2).}).
#pos(one,{target_sample(0)}, {}, {guess(0,2). dist(0,3).}).
%#neg(none, {target_sample(0)},{},{})
%#modeh(sample(var(rocks), var(t))).
%#modeh(sampled(var(rocks), var(t))).
#modeha(target_sample(var(rocks))).


#constant(const_value, 0..6).
#constant(const_guess_value, 50).


%dist(1,7). delta_x(1,-1). delta_y(1,-6)
%#modeh(target_sample(var(rocks))).
%#modeh(max_dist(var(rocks))).
%#modeh(min_dist(var(rocks))).
%#modeb(min_dist(var(rocks))).
%#modeb(1,max_dist(var(rocks))).

#modeb(1, guess(var(rocks), var(guess_value)),(positive)).
%#modeb( best_guess(var(rocks))).
#modeb(1,dist(var(rocks), var(ranges_dist)),(positive)).
%#modeb( delta_x(var(rocks), var(ranges_dist))).
%#modeb( delta_y(var(rocks), var(ranges_dist))).
#modeb(1, var(ranges_dist) < const(const_value),(positive)).
%#modeb( var(ranges_dist) > const(const_value)).
%#modeb( var(guess_value) < const(const_guess_value)).
#modeb(1, var(guess_value) > const(const_guess_value),(positive)).


%this will generate body atoms as V < 0, V < 1, ...
%We expect rule which state: select a rock with distance less than... and value higher than... Define the search space accordingly
%You will still have to clean the search space
%0{target_sample(R) : dist(R,V)}1. is meaningless...

#maxv(3). %maximum number of variables per rule
#maxhl(1). %maximum length of aggregate axioms. This will generate both 0{}1 and 1{}1, but we are interested only in 0{}1
%#disallow_multiple_head_variables.

