:- module(tpaired1, []).

:- discontiguous intermediate/1, expert/4, buggy/4, blame/3, praise/3.
:- use_module(library(i18n)).

% Solution of the problem
intermediate(tpaired/6).
expert(X, Y, paired, []) :-
    X = tpaired(D, Mu, Sd, _Sd_T0, _Sd_EOT, N),
    Y = tratio(D - Mu, Sd, N).

intermediate(tratio/3).
expert(X, Y, tratio, []) :-
    X = tratio(Numerator, Sd, N),
    Y = dfrac(Numerator, Sd / sqrt(N)).

% Mistakes
buggy(X, Y, indep, []) :-
    X = tpaired(D, Mu, _Sd, Sd_T0, Sd_EOT, N),
    V = dfrac((N - 1) * Sd_T0^2 + (N - 1) * Sd_EOT^2, N + N - 2),
    lang(pooledvar, Pooled),
    P = denote(s_pool^2, V, Pooled),
    Y = dfrac(D - Mu, sqrt(P * (1/N + 1/N))).

lang(Id, Elem),
    lang(L),
    lang(L, Id, Elem0)
 => Elem = Elem0.

lang(en, pooledvar, "with ~m denoting the pooled variance.").
lang(de, pooledvar, "mit ~m für die gepoolte Varianz.").

buggy(X, Y, mu, []) :-
    X = tpaired(D, _Mu, Sd, _Sd_T0, _Sd_EOT, N),
    Y = tratio(D, Sd, N).

buggy(X, Y, squareroot, []) :-
    X = tratio(Numerator, Sd, N),
    Y = dfrac(Numerator, Sd / N).

buggy(X, Y, paren, []) :-
    X = tratio(D - Mu, Sd, N),
    Y = D - dfrac(Mu, Sd) / sqrt(N).

% Feedback
praise(en, paired, "You correctly calculated the numerator of the $t$-statistic.").

praise(en, tratio, "You correctly calculated the denominator of the $t$-statistic.").

blame(en, indep, "Careful, you used the formula of the $t$-test for independent samples.").

blame(en, mu, 
    "Careful, you forgot to subtract the ~m  in the formula. 
    This is equivalent on running a $t$-test to find any improvement at all, 
    which is often the case due to regression to the mean."-[mu_0]
    ).

blame(en, squareroot, "Careful, you forgot to take the square root of $N$ when calculating the standard error.").

blame(en, paren, "Careful, you forgot to put parentheses around the numerator and the denominator of the fraction.").

praise(de, paired, "Du hast den Zähler der $t$-Statistik korrekt berechnet.").

praise(de, tratio, "Du hast den Nenner der $t$-Statistik korrekt berechnet.").

blame(de, indep, "Vorsicht, du hast die Formel des $t$-Tests für unabhängige Stichproben verwendet.").

blame(de, mu, 
    "Vorsicht, du hast vergessen, ~m in der Formel zu subtrahieren. 
    Das entspricht einem $t$-Test auf irgendeine Verbesserung, 
    die aufgrund der Regression zur Mitte häufig vorliegt."-[mu_0]
    ).

blame(de, squareroot, "Vorsicht, du hast vergessen, bei der Berechnung des Standardfehlers die Wurzel aus $N$ zu ziehen.").

blame(de, paren, "Vorsicht, du hast vergessen, Zähler und Nenner des Bruchs in Klammern zu setzen.").
