:- module(tpaired5, []).

:- discontiguous intermediate/1, expert/4, buggy/4, blame/3, praise/3.
:- use_module(library(i18n)).

% Solution of the problem
intermediate(tpaired/3).
expert(X, Y, sigma, []) :-
    X = tpaired(Mu_D, Mu_0, S_T0),
    Y = sigma(Mu_D, Mu_0, dot(round(0.63, 2), S_T0)).

intermediate(sigma/3).
expert(X, Y, effsize, []) :-
    X = sigma(Mu_D, Mu_0, Sd),
    Y = effsize(dfrac(Mu_D - Mu_0, Sd)).

intermediate(effsize/1).
expert(X, Y, sample, []) :-
    X = effsize(D),
    lang(cohensd, Cohensd),
    A = denote(d, D, Cohensd),
    Y = 'as.character'(ceiling(dfrac(9, A^2))).

lang(Id, Elem),
    lang(L),
    lang(L, Id, Elem0)
 => Elem = Elem0.
 
lang(en, cohensd, "with ~m denoting the standardized effect size.").
lang(de, cohensd, "mit ~m für die standardisierte Effektstärke.").

% Mistakes
buggy(X, Y, sdt0, []) :-
    X = tpaired(Mu_D, Mu_0, S_T0),
    Y = sigma(Mu_D, Mu_0, S_T0).

buggy(X, Y, brackets, []) :-
    X = sigma(Mu_D, Mu_0, Sd),
    Y = effsize(Mu_D - dfrac(Mu_0, Sd)).

buggy(X, Y, mu0, []) :-
    X = sigma(Mu_D, _Mu_0, Sd),
    Y = effsize(dfrac(Mu_D, Sd)).

buggy(X, Y, nosquare, []) :-
    X = effsize(D),
    lang(cohensd, Cohensd),
    A = denote(d, D, Cohensd),
    Y = 'as.character'(ceiling(dfrac(9, A))).

buggy(X, Y, indep, []) :-
    X = effsize(D),
    lang(cohensd, Cohensd),
    A = denote(d, D, Cohensd),
    Y = 'as.character'(ceiling(dfrac(42, A^2))).

% Feedback
praise(en, sigma, "You have correctly calculated the standard deviation of the change score.").
praise(en, effsize, "You have correctly estimated the effect size.").
praise(en, sample, "You have correctly used the approximation formula for the sample size.").
blame(en, sdt0, "Careful, you used the standard deviation of the T0 measurements instead of calculating the $s_D$ of the change scores.").
blame(en, brackets, "Careful, you forgot the parenthesis around the numerator/denominator of the $d$-fraction.").
blame(en, mu0, "Careful, you forgot to subtract ~m."-[mu_0]).
blame(en, nosquare, "Careful, you forgot to square the effect size in the formula.").
blame(en, indep, "Careful, you used the approximation formula $N = 42/d^2$ suitable for an independent groups $t$-test."). 

praise(de, sigma, "Du hast die Standardabweichung der Differenzwerte korrekt berechnet.").
praise(de, effsize, "Du hast die Effektstärke korrekt geschätzt.").
praise(de, sample, "Du hast die Näherungsformel für den Stichprobenumfang korrekt verwendet.").
blame(de, sdt0, "Vorsicht, du hast die Standardabweichung der T0-Messungen verwendet, anstatt die $s_D$ der Differenzwerte zu berechnen.").
blame(de, brackets, "Vorsicht, du hast die Klammern um den Zähler bzw. den Nenner des $d$-Bruchs vergessen.").
blame(de, mu0, "Vorsicht, du hast vergessen, ~m zu subtrahieren."-[mu_0]).
blame(de, nosquare, "Vorsicht, du hast vergessen, die Effektstärke in der Formel zu quadrieren.").
blame(de, indep, "Vorsicht, du hast die Näherungsformel $N = 42/d^2$ für einen $t$-Test für unabhängige Gruppen verwendet.").
