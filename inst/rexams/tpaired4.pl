:- module(tpaired4, []).

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
    lang(tvar, Tstat),
    T = denote(t, dfrac(Numerator, Sd / sqrt(N)), Tstat),
    Y = pval(T, N).

lang(Id, Elem),
    lang(L),
    lang(L, Id, Elem0)
 => Elem = Elem0.

lang(en, tvar, "with ~m denoting the $t$-ratio.").
lang(de, tvar, "mit ~m für die $t$-Statistik.").

intermediate(pval/2).
expert(X, Y, pval, []) :-
    X = pval(T, N),
    Y = 2 * pt(-abs(T), N - 1).

% Mistakes
buggy(X, Y, lowertail, []) :-
    X = pval(T, N),
    Y = pt(T, N - 1) .

buggy(X, Y, uppertail, []) :-
    X = pval(T, N),
    Y = 1 - pt(T, N - 1).

% Feedback
praise(en, paired, "You correctly calculated the numerator of the $t$-statistic.").
praise(en, tratio, "You correctly calculated the denominator of the $t$-statistic.").
praise(en, pval, "You correctly calculated the two-tailed $p$-value.").
blame(en, lowertail, "Careful, you have calculated the one-tailed $p$-value of having less than a ~m unit increase."-[mu_0]).
blame(en, uppertail, "Careful, you have calculated the one-tailed $p$-value of having more than a ~m unit increase."-[mu_0]).

praise(de, paired, "Du hast den Zähler der $t$-Statistik korrekt berechnet.").
praise(de, tratio, "Du hast den Nenner der $t$-Statistik korrekt berechnet.").
praise(de, pval, "Du hast den zweiseitigen $p$-Wert korrekt berechnet.").
blame(de, lowertail, "Vorsicht, du hast den einseitigen $p$-Wert für eine Zunahme von höchstens ~m Einheiten berechnet."-[mu_0]).
blame(de, uppertail, "Vorsicht, du hast den einseitigen $p$-Wert für eine Zunahme von mindestens ~m Einheiten berechnet."-[mu_0]).
