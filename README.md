# XaiProject

## TODO:
* Understand Highway best OBSERVATION type
* Train a net PPO?
* Perform 1k runs and save Obs, action pair

# ILASP Tokens 
## env observation
| | Presence | X | Y | delta X | delta Y |
|-|-|-|-|-|-|
|Ego| - | - | - | - |  -|
|V1| - | - | - | - |  -| 
|...| - | - | - | - |  -| 
|Vn| - | - | - | - |  -| 

other vericles obs are relative so:<br>
X < 0 -> ahead then ego.<br>
delta X < 0 -> slower then ego.

## env Actions
DiscreteMetaAction
|value|Action|
|-|-|
|0| 'LANE_LEFT'|
|1| 'IDLE'|
|2| 'LANE_RIGHT'|
|3| 'FASTER'|
|4| 'SLOWER'|
## ILASP Tokens
### Action: 0 LANE LEFT
**free_lane(L+1, t)** :- ego(X,L,D_X), closer(L+1,V,X1), (X - X1) > const(free_lane), L < const(number_of_lanes)<br>
**not free_lane(L, t)** :- ego(X,L,D_X), closer(L,V,X1), (X - X1) > const(free_lane)

### Action: 1 IDLE (should no be done )
--

### Action: 2 LANE RIGHT
**free_lane(L-1, t)** :- ego(X,L,D_X), closer(L-1,V,X1), (X - X1) > const(free_lane), L < const(min_number_of_lanes) (0)<br>
~~**not free_lane(L, t)** :- ego(X,L,D_X), closer(L,V,X1), (X - X1) > const(free_lane)~~ (right should be prioritized then stand)

### Action: 3 FASTER
**free_lane(L+1, t)** :- ego(X,L,D_X), closer(L+1,V,X1), (X - X1) > const(free_lane), L < const(min_number_of_lanes) (0)<br>
**not free_lane(L-1, t)** :- ego(X,L,D_X), closer(L-1,V,X1), (X - X1) > const(free_lane), L < const(min_number_of_lanes) (0)


### Action: 4 SLOWER
**not free_lane(L+1, t)** :- ego(X,L,D_X), closer(L+1,V,X1), (X - X1) > const(free_lane), L < const(min_number_of_lanes) (0)<br>
**not free_lane(L-1, t)** :- ego(X,L,D_X), closer(L-1,V,X1), (X - X1) > const(free_lane), L < const(min_number_of_lanes) (0)<br>
**not free_lane(L, t)** :- ego(X,L,D_X), closer(L,V,X1), (X - X1) > const(free_lane)