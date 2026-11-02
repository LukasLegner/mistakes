:- module(chisquare2, []).

:- discontiguous intermediate/1, expert/4, buggy/4, blame/3, praise/3.

% Solution of the problem
intermediate(chisquare2/1).

expert(X, Y, chisquare_p, []) :-
    X = chisquare2(Z),
    Y = 1 - pchisq(Z^2, 1).

% Mistakes

% Report wrong tail of pchisq
buggy(X, Y, one_sided, []) :-
    X = chisquare2(Z),
    Y = pchisq(Z^2, 1).

% Report chisq(z) without squaring
buggy(X, Y, forgotsquare, []) :-
    X = chisquare2(Z),
    Y = pchisq(Z, 1).

% Used pnorm instead
buggy(X, Y, usedpnorm, []) :-
    X = chisquare2(Z),
    Y = pnorm(abs(Z)).

% Feedback

praise(en, chisquare_p, "Correct. Also, for one degree of freedom, ~m, and the corresponding ~m-test has the same ~m-value as the two-sided ~m-test."-[chi^2 = z^2, chi^2, p, z]).

blame(en, one_sided, "Careful, the result corresponds the wrong tail of the ~m-test. Don't forget to subtract the result from 1." -[chi^2]).

blame(en, forgotsquare, "Careful, you forgot squaring the ~m-value for the ~m-test."-[z, chi^2]).

blame(en, usedpnorm, "Careful, your result corresponds to the value in the normal distribution table. Subtract this value from one and multiply the result by 2 to reach the ~m-value."-[p]).

praise(de, chisquare_p, "Richtig. Bei einem Freiheitsgrad ist ~m und der entsprechende ~m-Test hat denselben ~m-Wert wie der zweiseitige ~m-Test."-[chi^2 = z^2, chi^2, p, z]).

blame(de, one_sided, "Vorsicht, das Ergebnis entspricht dem falschen Randbereich des ~m-Tests. Vergiss nicht, das Ergebnis von 1 abzuziehen." -[chi^2]).

blame(de, forgotsquare, "Vorsicht, du hast vergessen, den ~m-Wert für den ~m-Test zu quadrieren."-[z, chi^2]).

blame(de, usedpnorm, "Vorsicht, dein Ergebnis entspricht dem Wert aus der Normalverteilungstabelle. Ziehe diesen Wert von 1 ab und multipliziere das Ergebnis mit 2, um den ~m-Wert zu erhalten."-[p]).