:- module(chisquare1, []).

:- discontiguous intermediate/1, expert/4, buggy/4, blame/3, praise/3.
:- use_module(library(i18n)).

% Solution of the problem
intermediate(chisquare1/6).

expert(X, Y, pooled_success, []) :-
    X = chisquare1(P_A, P_B, N_A, N_B, X_A, X_B),
    lang(pooledvar, Pooled),
    P = denote(p_pool, dfrac(X_A + X_B, N_A + N_B), Pooled),
    Y = pool_success(P, P_A, P_B, N_A, N_B).

lang(Id, Elem),
    lang(L),
    lang(L, Id, Elem0)
 => Elem = Elem0.

lang(en, pooledvar, "with ~m denoting the pooled success rate.").
lang(de, pooledvar, "mit ~m für die gepoolte Erfolgsrate.").

intermediate(pool_success/5).

expert(X, Y, chisquare, []) :-
    X = pool_success(P_pool, P_A, P_B, N_A, N_B),
    Y = chisquare_z(dfrac(P_A - P_B, sqrt(P_pool * (1-P_pool)*(1/N_A+1/N_B)))).

intermediate(chisquare_z/1).

expert(X, Y, square, []) :-
    X = chisquare_z(dfrac(Num, sqrt(Den))),
    Y = dfrac(Num^2, Den).

% Mistakes

% Report the pooled success rate instead of the test statistic
buggy(X, Y, pool, []) :-
    X = pool_success(P_pool, _P_A, _P_B, _N_A, _N_B),
    Y = P_pool.

% Stop at the z-statistic instead of calculating chi-square
buggy(X, Y, stop_z, []) :-
    X = chisquare_z(Z),
    Y = Z.

% Reverse the sign of z instead of squaring it
buggy(X, Y, neg_z, []) :-
    X = chisquare_z(Z),
    Y = -Z.

% Use 1/(N_A+N_B) at the denominator
buggy(X, Y, total_n, []) :-
    X = pool_success(P_pool, P_A, P_B, N_A, N_B),
    Y = chisquare_z(dfrac(P_A - P_B, sqrt(P_pool * (1-P_pool)*(1/(N_A + N_B))))).

% Feedback

praise(en, pooled_success,"You have correctly identified the expression for the pooled success rate.").

praise(en, chisquare,"You have correctly identified the expression for the ~m-statistic."-[z]).

praise(en, square,"You have correctly transformed the ~m-statistic into the ~m-statistic."-[z, chi^2]).

blame(en, pool, "Careful, the result corresponds to the pooled success rate ~m. This is an intermediate result used in the denominator of the ~m-statistic, but the task is not yet finished."-[p_pool, z]).

blame(en, stop_z, "Careful, the result corresponds to the ~m-statistic. The ~m-statistic is obtained by raising it to the square."-[z, chi^2]).

blame(en, neg_z, "Careful, the result corresponds to the negative ~m-statistic. The ~m-statistic is obtained by raising it to the square."-[z, chi^2]).

blame(en, total_n, "Something is wrong in the denominator. Please note that ~m cannot be simplified to ~m."-[frac(1, n_a) + frac(1, n_b), frac(1, n_a + n_b)]).

praise(de, pooled_success,"Du hast den Ausdruck für die gepoolte Erfolgsrate korrekt identifiziert.").

praise(de, chisquare,"Du hast den Ausdruck für die ~m-Statistik korrekt identifiziert."-[z]).

praise(de, square,"Du hast die ~m-Statistik korrekt in die ~m-Statistik umgewandelt."-[z, chi^2]).

blame(de, pool, "Vorsicht, das Ergebnis entspricht der gepoolten Erfolgsrate ~m. Das ist ein Zwischenergebnis, das im Nenner der ~m-Statistik verwendet wird, aber die Lösung ist noch nicht vollständig."-[p_pool, z]).

blame(de, stop_z, "Vorsicht, das Ergebnis entspricht der ~m-Statistik. Die ~m-Statistik erhält man, indem man diesen Wert quadriert."-[z, chi^2]).

blame(de, neg_z, "Vorsicht, das Ergebnis entspricht der negativen ~m-Statistik. Die ~m-Statistik erhält man, indem man diesen Wert quadriert."-[z, chi^2]).

blame(de, total_n, "Vorsicht, im Nenner stimmt etwas nicht. Bitte beachte, dass ~m nicht zu ~m vereinfacht werden kann."-[frac(1, n_a) + frac(1, n_b), frac(1, n_a + n_b)]).