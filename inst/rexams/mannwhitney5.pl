:- module(mannwhitney5, []).

:- discontiguous intermediate/1, expert/4, buggy/4, blame/3, praise/3.

% Solution of the problem
intermediate(mannwhitney5/4).
intermediate(wins/5).
intermediate(ties/4).

expert(X, Y, wins_a, []) :-
    X = mannwhitney5(A, B, N_A, N_B),
    Y = wins(ustat(A, B, >), A, B, N_A, N_B).

expert(X, Y, ties, []) :-
    X = wins(U, A, B, N_A, N_B),
    Y = ties(U, round(0.5, 1) * ustat(A, B, ==), N_A, N_B).

expert(X, Y, ustat_a, []) :-
    X = ties(U, T, _N_A, _N_B),
    Y = 'as.character'(U + T).


% Mistakes

% Count the pairwise comparisons won by Method B instead of Method A
buggy(X, Y, wins_b, []) :-
    X = mannwhitney5(A, B, N_A, N_B),
    Y = wins(ustat(B, A, >), A, B, N_A, N_B).

% Count one point for tie instead of half point
buggy(X, Y, tie_one, []) :-
    X = wins(U, A, B, N_A, N_B),
    Y = ties(U, ustat(A, B, ==), N_A, N_B).

% Competing proportion
buggy(X, Y, cp, []) :-
    X = ties(U, T, N_A, N_B),
    Y = dfrac(U + T, N_A * N_B).

% Feedback
praise(en, wins_a, "You correctly counted each win of Method A as one point.").
praise(en, ties, "You correctly counted each tie as half point.").
praise(en, ustat_a, "You correctly added up the points for the wins and the ties.").

blame(en, wins_b, "Careful, you counted the wins of Method B instead of Method A.").
blame(en, tie_one, "Careful, you counted each tie as one point instead of half a point.").
blame(en, cp, "Careful, you divided the Mann–Whitney ~m-statistic by the total number of 
      pairwise comparisons. This gives the competing proportion, but the task asks for the ~m-statistic."-['U', 'U']).
      
praise(de, wins_a, "Du hast jeden Sieg von Methode A korrekt mit einem Punkt gezählt.").
praise(de, ties, "Du hast jedes Unentschieden korrekt mit einem halben Punkt gezählt.").
praise(de, ustat_a, "Du hast die Punkte für die Siege und Unentschieden korrekt addiert.").

blame(de, wins_b, "Vorsicht, du hast die Siege von Methode B statt von Methode A gezählt.").
blame(de, tie_one, "Vorsicht, du hast jedes Unentschieden mit einem ganzen statt mit einem halben Punkt gezählt.").
blame(de, cp, "Vorsicht, du hast die Mann-Whitney-~m-Statistik durch die Gesamtzahl der paarweisen Vergleiche dividiert. 
      Dadurch erhältst du die competing proportion, aber gefragt ist die ~m-Statistik."-['U', 'U']).