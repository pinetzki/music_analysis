#include "keys.lp".

% needs: range(R), track(T), key(R, K)
% WIP section
track(0).
keys(0,0,99,(0,(major,ionian))).
% WIP section end

% only velocities, lengths and distances get chosen from the original space; notes get chosen from specified key
velocities(V)   :- notep(_,_,_,_,V,_,_).
lengths(L)      :- notep(_,_,_,_,_,L,_).
distances(D)    :- notep(_,_,_,_,_,_,D).

% generator for note properties
{ chosendist(T, P, D) : distances(D) } 1 :- positions(P), track(T).
{ chosenlength(T, P, L) : lengths(L) } 1 :- positions(P), track(T).
{ chosennote(T, P, N) : inkey(N, K), keys(T,S,E,K), P >= S, P < E } 1 :- positions(P), track(T).
{ chosenvel(T, P, V) : velocities(V) } 1 :- positions(P), track(T). 

%only the first note can happen instantly
:- chosendist(_, P, (0,1)), P > 0.

% combine everything to for notes
1 { note(T,P,0,N,V,L,D) : chosendist(T,P,D), chosenlength(T,P,L), chosennote(T,P,N), chosenvel(T, P, V) } 1 :- positions(P).


% visibility
#show note/7.
#show key(T,S,R,K) : keys(T,S,_,(R,K)).
#show  track/1.
