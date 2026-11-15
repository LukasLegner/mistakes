:- module(confint2, []).

:- discontiguous intermediate/1, expert/4, buggy/4, blame/3, praise/3.
:- use_module(library(i18n)).

% Solution of the problem 
intermediate(confint2/4).
intermediate(stderror/4).
intermediate(ci/3).

expert(X, Y, stderror, []) :-
    X = confint2(N, Xbar, Sd, Mu0),
    Y = stderror(N, Xbar, Sd/sqrt(N), Mu0).

expert(X, Y, mean, []) :-
    X = stderror(N, Xbar, StandardError, _Mu0),
    Y = ci(N, Xbar, StandardError).

expert(X, Y, ci, []) :-
    X = ci(N, Xbar, StandardError),
    Q = denote(quant, qt(round(0.975, 3), N-1), "with ~m denoting the quantile of the $t$-distribution."),
    Y = interval(Xbar - Q * StandardError, Xbar + Q * StandardError).

% Mistakes

% Reference value mu0 instead of mean
buggy(X, Y, reference, []) :-
    X = stderror(N, _Xbar, StandardError, Mu0),
    Y = ci(N, Mu0, StandardError).

% No square root
buggy(X, Y, nosqrt, []) :-
    X = confint2(N, Xbar, Sd, Mu0),
    Y = stderror(N, Xbar, Sd/N, Mu0).

% Feedback
praise(en, stderror, "You correctly calculated the standard error of the mean 
    by dividing the sample deviation by ~m."-[-sqrt(n)]).

praise(en, mean, "You have correctly used the mean of the population to calculate the central interval.").

praise(en, ci, "You correctly used the given $t$-quantile to calculate the confidence interval.").

blame(en, reference, "Careful, you centered the confidence interval around the reference value, 
    instead of using the observerd sample mean.").

blame(en, nosqrt, "Careful, you used the sample size $N$ instead of the square root of the sample size $N$
    to calculate the standard error.").
