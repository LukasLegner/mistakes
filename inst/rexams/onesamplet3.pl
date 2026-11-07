:- module(onesamplet3, []).

:- discontiguous intermediate/1, expert/4, buggy/4.
:- use_module(library(i18n)).

% Solution of the problem
intermediate(tratio/2).
expert(X, Y, pt, []) :-
    X = tratio(T, N),
    Y = pt(T, N - 1).

% Mistakes
buggy(X, Y, upper, []) :-
    X = tratio(T, N),
    Y = 1 - pt(T, N - 1).

buggy(X, Y, twosided, []) :-
    X = tratio(T, N),
    Y = 2 * pt(-(abs(T)), N - 1).

buggy(X, Y, half, []) :-
    X = tratio(T, N),
    Y = pt(T, N - 1) / 2.

% Feedback
praise(en, pt, "You correctly used the $t$-distribution with ~m degrees of freedom."-[n-1]).

praise(en, pval, "You correctly determined the probability in the lower tail of the $t$-distribution.").

blame(en, nodf, "Careful, you used the sample size instead of the degrees of freedom.").

blame(en, upper, "Careful, you calculated the probability in the upper tail instead of the lower tail.").

blame(en, twosided, "Careful, you calculated a two-sided instead of the requested one-sided $p$-value.").

blame(en, half, "Careful, you divided the one-sided $p$-value by two.").

