:- module(confint4, []).

:- discontiguous intermediate/1, expert/4, buggy/4, blame/3, praise/3.
:- use_module(library(i18n)).

% Solution of the problem 
intermediate(confint4/5).
intermediate(stderror/4).

expert(X, Y, stderror, []) :-
    X = confint4(N, D, D0, Q, Sd),
    Y = stderror(D, Q, D0, Sd / sqrt(N)).

expert(X, Y, ci, []) :-
    X = stderror(D, Q, _D0, StandardError),
    Y = interval(D - Q * StandardError, D + Q * StandardError).

% Mistakes

% Reference value mu0 instead of mean
buggy(X, Y, reference, []) :-
    X = stderror(_D, Q, D0, StandardError),
    Y = interval(D0 - Q * StandardError, D0 + Q * StandardError).

% No square root
buggy(X, Y, nosqrt, []) :-
    X = confint4(N, D, D0, Q, Sd),
    Y = stderror(D, Q, D0, Sd / N).

% Feedback
praise(en, stderror, "You correctly calculated the estimated standard error of the mean difference.").

praise(en, ci, "You correctly used the observed mean difference to center the confidence interval.").

blame(en, reference, "Careful, you used the expected reduction instead of the observed mean difference.").

blame(en, nosqrt, "Careful, you used the sample size $N$ 
    instead of the square root of the sample size $N$ to calculate the standard error.").
