% for AZ-Prolog

ikimono(X) :- sakana(X).
ikimono(X) :- mizukusa(X).
ikimono(X) :- plankton(X).
ikimono(X) :- bacteria(X).

sakana(kingyo).
sakana(medaka).
sakana(ko_medaka).
sakana(dojo).
/*
sakana(ebi).
sakana(zarigani).

mizukusa(ukikusa).
mizukusa(itogoke).
mizukusa(kanadamo).

plankton(zooplankton).
plankton(phytoplankton).

bacteria(photosynthetic_bacteria).
*/

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


alldifferent([]).
alldifferent([H|T]) :- \+(member(H,T)), alldifferent(T).

doremo_tabenai(X, []).
doremo_tabenai(X, [H|T]) :- \+(taberu(X, H)), doremo_tabenai(X, T).


new_suiso(L1, L2) :- ikimono(X), \+(member(X, L1)), sort([X|L1],L2).


suiso([X]) :- ikimono(X).
suiso([H,H2|T]) :- ikimono(H), ikimono(H2), alldifferent([H,H2|T]), suiso([H2|T]).





