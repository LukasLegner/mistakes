:- module(tgroups6, []).

:- discontiguous intermediate/1, expert/4, buggy/4.
:- use_module(library(i18n)).

% Solution of the problem
intermediate(welch/6).
expert(X, Y, mu, []) :-
    X = welch(Mu_A, S_A, N_A, Mu_B, S_B, N_B),
    Y = welch2(Mu_A - Mu_B, S_A, N_A, S_B, N_B).

intermediate(welch2/5).
expert(X, Y, s2, []) :-
    X = welch2(Mu, S_A, N_A, S_B, N_B),
    Y = welch3(Mu, S_A^2 / N_A + S_B^2 / N_B).

intermediate(welch3/2).
expert(X, Y, sqrt, []) :-
    X = welch3(Mu, Denominator),
    Y = dfrac(Mu, sqrt(Denominator)).

% Mistakes
buggy(X, Y, wrongmu, []) :-
    X = welch(Mu_A, S_A, N_A, Mu_B, S_B, N_B),
    Y = welch2(Mu_B - Mu_A, S_A, N_A, S_B, N_B).

buggy(X, Y, brackets, []) :-
    X = welch3(Mu_A - Mu_B, Denominator),
    Y = Mu_A - dfrac(Mu_B, sqrt(Denominator)).

buggy(X, Y, s2pool, []) :-
    X = welch2(Mu, S_A, N_A, S_B, N_B),
    P = dfrac((N_A - 1) * S_A^2 + (N_B - 1) * S_B^2, N_A + N_B - 2),
    Pool = denote(s2_pool, P, "with ~m denoting the pooled variance."),
    Y = welch3(Mu, dot(Pool, (1 / N_A + 1 / N_B))).

buggy(X, Y, nosqrt, []) :-
    X = welch3(Mu, Denominator),
    Y = dfrac(Mu, Denominator).

% Feedback
praise(en, mu, "You correctly subtracted the mean of Condition B from the mean of Condition A.").

praise(en, s2, "You correctly used the separate sample variances instead of the pooled variance.").

praise(en, sqrt, "You correctly divided each sample variance by its respective sample size.").

blame(en, wrongmu, "Careful, you subtracted the means of the two conditions in the wrong order.").

blame(en, brackets, "Careful, you forgot to put a parenthesis around the numerator.").

blame(en, nosqrt, "Careful, you forgot to take the square root when calculating the standard error.").

blame(en, s2pool, "Careful, you used the pooled-variance formula, which assumes equal population variances.").


