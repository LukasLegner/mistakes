:- module(mannwhitney6, []).

:- discontiguous intermediate/1, expert/4, buggy/4, blame/3, praise/3.

% Solution of the problem
intermediate(mannwhitney6/4).
intermediate(wins/5).
intermediate(ties/4).

expert(X, Y, wins_a, []) :-
    X = mannwhitney6(A, B, N_A, N_B),
    Y = wins(ustat(A, B, <), A, B, N_A, N_B).

expert(X, Y, ties, []) :-
    X = wins(U, A, B, N_A, N_B),
    Y = ties(U, round(0.5, 1) * ustat(A, B, ==), N_A, N_B).

expert(X, Y, cp, []) :-
    X = ties(U, T, N_A, N_B),
    Y = dfrac(U + T, N_A * N_B).


% Mistakes

% Count the pairwise comparisons won by Method B instead of Method A
buggy(X, Y, wins_b, []) :-
    X = mannwhitney6(A, B, N_A, N_B),
    Y = wins(ustat(A, B, >), A, B, N_A, N_B).


% Count one point for tie instead of half point
buggy(X, Y, tie_one, []) :-
    X = wins(U, A, B, N_A, N_B),
    Y = ties(U, ustat(A, B, ==), N_A, N_B).


% Competing proportion
buggy(X, Y, ustat, []) :-
    X = ties(U, T, _N_A, _N_B),
    Y = 'as.character'(U + T).

% Feedback
praise(en, wins_a, na).
praise(en, ties, "You correctly counted each tie as half point.").
praise(en, cp, "You correctly divided the Mann–Whitney ~m-statistic by the total number of pairwise comparisons"-['U']).

blame(en, wins_b, "Careful, you counted the wins of Therapy B instead of Therapy A.").
blame(en, tie_one, "Careful, you counted each tie as one point instead of half a point.").
blame(en, ustat, "Careful, you forgot to divide the Mann-Whitney ~m-statistic by the total number of pairwise comparisons."-['U']).

praise(de, wins_a, na).
praise(de, ties, "Du hast jede Rangbindung korrekt als einen halben Punkt gezählt.").
praise(de, cp, "Du hast die Mann-Whitney-~m-Statistik korrekt durch die Gesamtzahl der paarweisen Vergleiche geteilt."-['U']).

blame(de, wins_b, "Vorsicht, du hast die Siege von Therapie B statt von Therapie A gezählt.").
blame(de, tie_one, "Vorsicht, du hast jede Rangbindung als einen Punkt statt als einen halben Punkt gezählt.").
blame(de, ustat, "Vorsicht, du hast vergessen, die Mann-Whitney-~m-Statistik durch die Gesamtzahl der paarweisen Vergleiche zu teilen."-['U']).