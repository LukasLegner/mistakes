:- module(onesamplet1, []).

:- discontiguous intermediate/1, expert/4, buggy/4, blame/3, praise/3.
:- use_module(library(i18n)).

% Solution of the problem
intermediate(tratio/4).
expert(X, Y, numerator, []) :-
    X = tratio(Xbar, Mu0, Sd, N),
    Y = tratio2(Xbar - Mu0, Sd, N).

intermediate(tratio2/3).
expert(X, Y, denominator, []) :-
    X = tratio2(Numerator, Sd, N),
    Y = dfrac(Numerator, Sd / sqrt(N)).

% Mistakes
buggy(X, Y, inverted, []) :-
    X = tratio(Xbar, Mu0, Sd, N),
    Y = tratio2(Mu0 - Xbar, Sd, N).

buggy(X, Y, mu0, []) :-
    X = tratio(Xbar, _Mu0, Sd, N),
    Y = tratio2(Xbar, Sd, N).

buggy(X, Y, nosqrt, []) :-
    X = tratio2(Numerator, Sd, N),
    Y = dfrac(Numerator, Sd / N).

buggy(X, Y, sd, []) :-
    X = tratio2(Numerator, Sd, _N),
    Y = dfrac(Numerator, Sd).

% Feedback
praise(en, numerator, "You correctly calculated the numerator of the $t$-ratio.").
praise(en, denominator, "You correctly calculated the denominator of the $t$-ratio.").
blame(en, inverted, "Careful, you inverted the terms in the numerator, which should be ~m, not ~m."-[xbar-mu_0, mu_0-xbar]).
blame(en, nosqrt, "Careful, you forgot to take the square root of $N$ when calculating the standard error.").
blame(en, mu0, "Careful, you forgot to subtract ~m from ~m."-[mu_0, xbar]).
blame(en, sd, "Careful, you used the standard deviation instead of the standard error in the denominator.").

praise(de, numerator, "Du hast den Zähler der $t$-Statistik korrekt berechnet.").
praise(de, denominator, "Du hast den Nenner der $t$-Statistik korrekt berechnet.").
blame(de, inverted, "Vorsicht, du hast die Terme im Zähler vertauscht. Dort sollte ~m stehen, nicht ~m."-[xbar-mu_0, mu_0-xbar]).
blame(de, nosqrt, "Vorsicht, du hast vergessen, beim Berechnen des Standardfehlers die Wurzel aus $N$ zu ziehen.").
blame(de, mu0, "Vorsicht, du hast vergessen, ~m von ~m abzuziehen."-[mu_0, xbar]).
blame(de, sd, "Vorsicht, du hast im Nenner die Standardabweichung statt des Standardfehlers verwendet.").
