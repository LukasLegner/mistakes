:- module(onesamplet2, []).

:- discontiguous intermediate/1, expert/4, buggy/4, blame/3, praise/3.
:- use_module(library(i18n)).

% Solution of the problem
intermediate(tratio/2).
expert(X, Y, se, []) :-
    X = tratio(Sd, N),
    Y = Sd / sqrt(N).

% Mistakes
buggy(X, Y, sd, []) :-
    X = tratio(Sd, _N),
    Y = Sd.

buggy(X, Y, df, []) :-
    X = tratio(Sd, N),
    Y = Sd / sqrt(N - 1).

buggy(X, Y, nosqrt, []) :-
    X = tratio(Sd, N),
    Y = Sd / N. 

% Feedback
praise(en, se, "You correctly determined the standard error").
blame(en, nosqrt, "Careful, you forgot to take the square root of $N$.").
blame(en, df, "Careful, you divided by the square root of the number of degrees of freedom instead of the square root of the sample size.").
blame(en, sd, "Careful, this is the sample standard deviation. The standard error is given by ~m."-[s_X / sqrt(n)]).

praise(de, se, "Du hast den Standardfehler korrekt bestimmt").
blame(de, nosqrt, "Vorsicht, du hast vergessen, die Wurzel aus $N$ zu ziehen.").
blame(de, df, "Vorsicht, du hast durch die Wurzel der Anzahl der Freiheitsgrade statt durch die Wurzel des Stichprobenumfangs geteilt.").
blame(de, sd, "Vorsicht, das ist die Standardabweichung der Stichprobe. Der Standardfehler wird durch ~m. berechnet"-[s_X / sqrt(n)]).