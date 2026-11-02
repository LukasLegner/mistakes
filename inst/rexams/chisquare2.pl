:- module(chisquare2, []).

:- discontiguous intermediate/1, expert/4, buggy/4, blame/3, praise/3.

% Solution of the problem
intermediate(chisquare2/1).

expert(X, Y, chisquare_p, []) :-
    X = chisquare2(Z),
    Y = 2 * pnorm1(abs(Z), tail("upper")).

% Mistakes

% Report one-sided p-value of z-test
buggy(X, Y, one_sided, []) :-
    X = chisquare2(Z),
    Y = pnorm1(abs(Z), tail("upper")).

% Double two-sided p-value of z-test
buggy(X, Y, double_two_sided, []) :-
    X = chisquare2(Z),
    Y = dot(4, (pnorm1(abs(Z), tail("upper")))).

% Report wrong tail of p-value
buggy(X, Y, wrong_tail, []) :-
    X = chisquare2(Z),
    Y = pnorm1(abs(Z), tail("lower")).


% Feedback

praise(en, chisquare_p, "Correct. For one degree of freedom, ~m, and the corresponding ~m-test has the same ~m-value as the two-sided ~m-test."-[chi^2 = z^2, chi^2, p, z]).

blame(en, one_sided, "Careful, the result corresponds to the one-sided ~m-test ~m-value. The ~m-test with one degree of freedom corresponds to the two-sided ~m-test, so both tails of the standard normal distribution must be included." -[z, p, chi^2, z]).

blame(en, double_two_sided, "Careful, the two-sided ~m-test p-value already includes both tails. It should therefore not be doubled again. The corresponding ~m-test has the same ~m-value as the two-sided ~m-test."-[z, chi^2, p, z]).

blame(en, wrong_tail, "Careful, your result corresponds to the one-sided probability in the tail opposite to the observed effect. For the corresponding ~m-test, use the complete two-sided ~m-test ~m-value."- [chi^2, z, p]).

praise(de, chisquare_p, "Richtig. Bei einem Freiheitsgrad ist ~m und der entsprechende ~m-Test hat denselben ~m-Wert wie der zweiseitige ~m-Test."-[chi^2 = z^2, chi^2, p, z]).

blame(de, one_sided, "Vorsicht, das Ergebnis entspricht dem ~m-Wert des einseitigen ~m-Tests. Der ~m-Test mit einem Freiheitsgrad entspricht dem zweiseitigen ~m-Test, daher müssen beide Randbereiche der Standardnormalverteilung berücksichtigt werden." -[p, z, chi^2, z]).

blame(de, double_two_sided, "Vorsicht, der ~m-Wert des zweiseitigen ~m-Tests berücksichtigt bereits beide Randbereiche. Er sollte daher nicht nochmals verdoppelt werden. Der entsprechende ~m-Test hat denselben ~m-Wert wie der zweiseitige ~m-Test."-[p, z, chi^2, p, z]).

blame(de, wrong_tail, "Vorsicht, das Ergebnis entspricht der einseitigen Wahrscheinlichkeit im anderen Randbereich. Verwende für den entsprechenden ~m-Test den vollständigen ~m-Wert des zweiseitigen ~m-Tests."- [chi^2, p, z]).