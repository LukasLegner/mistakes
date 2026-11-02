:- module(tone2, []).
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
    T = denote(t, dfrac(Numerator, S / sqrt(N)), "with ~m denoting the $t$-ratio."),
    Y = pval(T, N).

intermediate(pval/2).
expert(X, Y, pval, []) :-
    X = pval(T, N),
    Y = 2 * pt(-abs(T), N - 1).

% Mistakes
buggy(X, Y, lowertail, []) :-
    X = pval(T, N),
    Y = pt(T, N - 1).

buggy(X, Y, uppertail, []) :-
    X = pval(T, N),
    Y = 1 - pt(T, N - 1).

buggy(X, Y, normal, []) :-
    X = pval(T, _N),
    Y = 2 * pnorm(-abs(T)).

% Feedback
praise(en, onesample, "You correctly calculated the numerator of the $t$-statistic.").
praise(de, onesample, "Du hast den Zähler der $t$-Statistik korrekt berechnet.").

praise(en, tratio, "You correctly calculated the denominator of the $t$-statistic.").
praise(de, tratio, "Du hast den Nenner der $t$-Statistik korrekt berechnet.").

praise(en, pval, "You correctly calculated the two-tailed $p$-value.").
praise(de, pval, "Du hast den zweiseitigen $p$-Wert korrekt berechnet.").

blame(en, lowertail, "Careful, you have calculated the one-tailed $p$-value for the lower tail. The question asks for the two-tailed $p$-value.").
blame(de, lowertail, "Vorsicht, du hast den einseitigen $p$-Wert für das untere Ende berechnet. Gefragt ist der zweiseitige $p$-Wert.").

blame(en, uppertail, "Careful, you have calculated the one-tailed $p$-value for the upper tail. The question asks for the two-tailed $p$-value.").
blame(de, uppertail, "Vorsicht, du hast den einseitigen $p$-Wert für das obere Ende berechnet. Gefragt ist der zweiseitige $p$-Wert.").

blame(en, normal, "Careful, you used the standard normal distribution. Since the standard deviation is estimated from the sample, the $t$-distribution with $N-1$ degrees of freedom is needed.").
blame(de, normal, "Vorsicht, du hast die Standardnormalverteilung verwendet. Da die Standardabweichung aus der Stichprobe geschätzt wird, braucht man die $t$-Verteilung mit $N-1$ Freiheitsgraden.").
