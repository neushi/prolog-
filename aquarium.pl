% for AZ-Prolog
ikimono(X) :- sakana(X).
ikimono(X) :- mizukusa(X).
ikimono(X) :- plankton(X).
ikimono(X) :- bacteria(X).

sakana(kingyo).
sakana(medaka).
sakana(ko_medaka).
sakana(dojo).

sakana(ebi).
sakana(zarigani).

mizukusa(ukikusa).
mizukusa(itogoke).
mizukusa(kanadamo).

plankton(zooplankton).
plankton(phytoplankton).

bacteria(photosynthetic_bacteria).


% -------------------------------
taberu(kingyo, ko_medaka).
taberu(kingyo, ebi).
taberu(kingyo, ukikusa).
taberu(kingyo, zooplankton).
taberu(medaka, ko_medaka).
taberu(medaka, zooplankton).
taberu(ko_medaka, zooplankton).
taberu(ko_medaka, photosynthetic_bacteria).
taberu(zooplankton, phytoplankton).
taberu(zarigani, dojo).
taberu(zarigani, itogoke).
taberu(zarigani, kanadamo).
% -------------------------------

doremo_tabenai(X, []).
doremo_tabenai(X, [H|T]) :- \+(taberu(X, H)), doremo_tabenai(X, T).

dorenimo_taberarenai(X, []).
dorenimo_taberarenai(X, [H|T]) :- \+(taberu(H, X)), dorenimo_taberarenai(X, T).

heiwa([]).
heiwa([_]).
heiwa([H|T]) :- doremo_tabenai(H, T), dorenimo_taberarenai(H, T), heiwa(T).

heiwa_check([],[]).
heiwa_check([H|T],[H|To]) :- heiwa(H), !, heiwa_check(T,To).
heiwa_check([H|T],To) :- !, heiwa_check(T,To).
% heiwa_check([[kingyo,dojo],[kingyo],[ko_medaka,medaka],[kingyo, ko_medaka]],L).


append_each(A, [], []).
append_each(A, [x], [[A|x]]).
append_each(A, [H|T], [[A|H]|NT]) :- append_each(A, T, NT).
% append_each(a, [], L).  is []
% append_each(a, [[]], L). is [[a]]
% append_each(a, [[],[b],[a],[g,h,j]], L).

all_combination([], [[]]).
all_combination([H|T], L) :- all_combination(T, L1), append_each(H, L1, L2), append(L2, L1, L) .
% all_combination([], L).
% all_combination([a], L).
% all_combination([b], L).
% all_combination([a,b,c,d], L).

include(L,[]).
include(L,[H|T]) :- member(H, L), include(L, T).
% include([],[]).
% include([a],[]).
% include([a,b],[]).
% include([a,b],[c]).
% include([a,b,c],[c,b]).
% include([a,b,c],[c,b,x]).

includedByAny(_,[]) :- !,fail.
includedByAny(A,[H|T]) :- include(H,A);includedByAny(A,T).

cut_trivial([], Working, Working).
cut_trivial([H|T], Working, Outs) :-  \+(includedByAny(H, T)), \+(includedByAny(H, Working)), !, cut_trivial(T, [H|Working], Outs).
cut_trivial([H|T], Working, Outs) :- !, cut_trivial(T, Working, Outs).
% cut_trivial([],[],OKL).
% cut_trivial([[a]],[],OKL).
% cut_trivial([[a],[a]],[],OKL).
% cut_trivial([[a],[b]],[],OKL).
% cut_trivial([[a],[b],[b,c]],[],OKL).
% cut_trivial([[a],[b],[b,c],[b,x]],[],OKL).
% cut_trivial([[a],[a,b],[a,c],[a,x],[b,c],[a,b,x],[c, b], [b], [a,c,y]],[],OKL).

print_list([]).
print_list([A|L]):-
	write(A), nl,
	print_list(L).

t :- bagof(X, ikimono(X), L), all_combination(L, CMBs), heiwa_check(CMBs, Heiwas), cut_trivial(Heiwas, [], Outs), 
        sort(Outs, Sorted), print_list(Sorted).


u :- bagof((X,Y), suiso([X,Y]), L), write(L), nl.
