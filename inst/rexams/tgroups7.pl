:- module(tgroups1, []).
:- encoding(utf8).

:- discontiguous intermediate/1, expert/4, buggy/4.
:- use_module(library(i18n)).

% Solution of the problem
intermediate(tgroups/6).
expert(X, Y, indep, []) :-
    X = tgroups(M_A, S_A, N_A, M_B, S_B, N_B),
    Y = tratio(M_A - M_B, pooled(S_A, N_A, S_B, N_B), ninv(N_A, N_B)).

intermediate(pooled/4).
expert(X, Y, pooled, []) :-
    X = pooled(S_A, N_A, S_B, N_B),
    V = dfrac((N_A - 1) * S_A^2 + (N_B - 1) * S_B^2, N_A + N_B - 2),
    lang(pooledvar, Pooled),
    Y = denote(s_pool^2, V, Pooled).

intermediate(ninv/2).
expert(X, Y, ninv, []) :-
    X = ninv(N_A, N_B),
    Y = 1/N_A + 1/N_B.

intermediate(tratio/3).
expert(X, Y, tratio, []) :-
    X = tratio(Diff, Var, Ninv),
    Y = dfrac(Diff, sqrt(Var * Ninv)).

lang(Id, Elem),
    lang(L),
    lang(L, Id, Elem0)
 => Elem = Elem0.

lang(en, pooledvar, "with ~m denoting the pooled variance.").
lang(de, pooledvar, "mit ~m für die gepoolte Varianz.").

% Mistakes
buggy(X, Y, square, []) :-
    X = pooled(S_A, N_A, S_B, N_B),
    V = dfrac((N_A - 1) * S_A + (N_B - 1) * S_B, N_A + N_B - 2),
    lang(pooledvar, Pooled),
    Y = denote(s_pool^2, V, Pooled).

buggy(X, Y, unweighted, []) :-
    X = pooled(S_A, _N_A, S_B, _N_B),
    V = dfrac(S_A^2 + S_B^2, 2),
    lang(pooledvar, Pooled),
    Y = denote(s_pool^2, V, Pooled).

buggy(X, Y, school, []) :-
    X = ninv(N_A, N_B),
    Y = dfrac(1, N_A + N_B).

% Feedback
praise(en, indep, "You correctly identified this as a $t$-test for independent samples.").
praise(de, indep, "Du hast die Aufgabe korrekt als $t$-Test für unabhängige Stichproben erkannt.").

praise(en, pooled, "You correctly calculated the pooled variance.").
praise(de, pooled, "Du hast die gepoolte Varianz korrekt berechnet.").

praise(en, ninv, "You correctly combined the two sample sizes in the standard error.").
praise(de, ninv, "Du hast die beiden Stichprobengrößen im Standardfehler korrekt kombiniert.").

praise(en, tratio, "You correctly calculated the $t$-ratio.").
praise(de, tratio, "Du hast den $t$-Wert korrekt berechnet.").

blame(en, square, "Careful, the pooled variance is calculated from the variances, not the standard deviations. Remember to square ~m and ~m."-[s_A, s_B]).
blame(de, square, "Vorsicht, die gepoolte Varianz wird aus den Varianzen berechnet, nicht aus den Standardabweichungen. Denke daran, ~m und ~m zu quadrieren."-[s_A, s_B]).

blame(en, unweighted, "Careful, you took the simple average of the two variances. Since the groups differ in size, the variances must be weighted by their degrees of freedom ~m and ~m."-[n_A - 1, n_B - 1]).
blame(de, unweighted, "Vorsicht, du hast den einfachen Mittelwert der beiden Varianzen gebildet. Da die Gruppen unterschiedlich groß sind, müssen die Varianzen mit ihren Freiheitsgraden ~m und ~m gewichtet werden."-[n_A - 1, n_B - 1]).

blame(en, school, "Careful, ~m is not the same as ~m."-[1/n_A + 1/n_B, dfrac(1, n_A + n_B)]).
blame(de, school, "Vorsicht, ~m ist nicht dasselbe wie ~m."-[1/n_A + 1/n_B, dfrac(1, n_A + n_B)]).
