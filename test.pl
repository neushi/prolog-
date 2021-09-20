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


% reconsult('C:\Users\a3kur\Desktop\保存\test.pl').
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
alldifferent([]).
alldifferent([H|T]) :- \+(member(H,T)), alldifferent(T).
% -------------------------------

doremo_tabenai(X, []).
doremo_tabenai(X, [H|T]) :- \+(taberu(X, H)), doremo_tabenai(X, T).

dorenimo_taberarenai(X, []).
dorenimo_taberarenai(X, [H|T]) :- \+(taberu(H, X)), dorenimo_taberarenai(X, T).

heiwa([]).
heiwa([_]).
heiwa([H|T]) :- doremo_tabenai(H, T), dorenimo_taberarenai(H, T), heiwa(T).

tsuika(L, [New|L]) :- ikimono(New), heiwa([New|L]).

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

heiwa_check([],[]).
heiwa_check([H|T],[H|To]) :- heiwa(H), !, heiwa_check(T,To).
heiwa_check([H|T],To) :- !, heiwa_check(T,To).

t(O) :- bagof(X, ikimono(X), L), all_combination(L, CMBs), heiwa_check(CMBs, O).


u :- bagof((X,Y), suiso([X,Y]), L), write(L), nl.
