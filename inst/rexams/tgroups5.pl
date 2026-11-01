:- module(tgroups5, []).

:- discontiguous intermediate/1, expert/4, buggy/4.
:- use_module(library(i18n)).

% Solution of the problem
intermediate(tgroups/5).
expert(X, Y, mu, []) :-
    X = tgroups(N_A, Mu_A, N_B, Mu_B, S2_Pool),
    Y = tstat1(Mu_A - Mu_B, N_A, N_B, S2_Pool).

intermediate(tstat1/4).
expert(X, Y, sqrt, []) :-
    X = tstat1(Mu, N_A, N_B, S2_Pool),
    Denominator = sqrt(dot(S2_Pool, (1 / N_A + 1 / N_B))),
    T = denote(t, dfrac(Mu, Denominator), "with ~m denoting the $t$-statistic."),
    Y = pval(T, N_A + N_B - 2).

intermediate(pval/2).
expert(X, Y, twotailed, []) :-
    X = pval(T, Df),
    Y = 2 * pt(-(abs(T)), Df).

% Mistakes
buggy(X, Y, nosqrt, []) :-
    X = tstat1(Mu, N_A, N_B, S2_Pool),
    Denominator = dot(S2_Pool, (1 / N_A + 1 / N_B)),
    T = denote(t, dfrac(Mu, Denominator), "with ~m denoting the $t$-statistic."),
    Y = pval(T, N_A + N_B - 2).

buggy(X, Y, oppositetail, []) :-
    X = pval(T, Df),
    Y = 1 - pt(-(abs(T)), Df).

buggy(X, Y, onetailed, []) :-
    X = pval(T, Df),
    Y = pt(-(abs(T)), Df).

% Feedback
praise(en, mu, "You correctly subtracted the mean of Therapy B from the mean of Therapy A.").

praise(en, sqrt, "You correctly calculated the standard error of the difference between two independent group means.").

praise(en, twotailed, "You correctly doubled the tail probability to obtain the two-tailed $p$-value.").

blame(en, nosqrt, "Careful, you forgot to take the square root when calculating the standard error.").

blame(en, oppositetail, "Careful, you used the tail opposite to the sign of the $t$-statistic.").

blame(en, onetailed, "Careful, you calculated the probability in only one tail. For a two-tailed test, the one-tailed probability must be doubled.").




