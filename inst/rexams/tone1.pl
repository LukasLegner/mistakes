:- module(tone1, []).
:- encoding(utf8).

:- discontiguous intermediate/1, expert/4, buggy/4.
:- use_module(library(i18n)).

% Solution of the problem
intermediate(tone/4).
expert(X, Y, onesample, []) :-
    X = tone(M, Mu, S, N),
    Y = tratio(M - Mu, S, N).

intermediate(tratio/3).
expert(X, Y, tratio, []) :-
    X = tratio(Numerator, S, N),
    Y = dfrac(Numerator, S / sqrt(N)).

% Mistakes
buggy(X, Y, squareroot, []) :-
    X = tratio(Numerator, S, N),
    Y = dfrac(Numerator, S / N).

buggy(X, Y, df, []) :-
    X = tratio(Numerator, S, N),
    Y = dfrac(Numerator, S / sqrt(N - 1)).

buggy(X, Y, paren, []) :-
    X = tratio(M - Mu, S, N),
    Y = M - dfrac(Mu, S) / sqrt(N).

% Feedback
praise(en, onesample, "You correctly calculated the numerator of the $t$-statistic.").
praise(de, onesample, "Du hast den Zähler der $t$-Statistik korrekt berechnet.").

praise(en, tratio, "You correctly calculated the denominator of the $t$-statistic.").
praise(de, tratio, "Du hast den Nenner der $t$-Statistik korrekt berechnet.").

blame(en, squareroot, "Careful, you forgot to take the square root of $N$ when calculating the standard error.").
blame(de, squareroot, "Vorsicht, du hast beim Standardfehler vergessen, die Wurzel aus $N$ zu ziehen.").

blame(en, df, "Careful, the standard error is ~m. The degrees of freedom $N-1$ are only needed for the $t$-distribution, not for the standard error."-[s_x / sqrt(n)]).
blame(de, df, "Vorsicht, der Standardfehler ist ~m. Die Freiheitsgrade $N-1$ braucht man nur für die $t$-Verteilung, nicht für den Standardfehler."-[s_x / sqrt(n)]).

blame(en, paren, "Careful, you forgot to put parentheses around the numerator and the denominator of the fraction.").
blame(de, paren, "Vorsicht, du hast vergessen, Zähler und Nenner des Bruchs einzuklammern.").
