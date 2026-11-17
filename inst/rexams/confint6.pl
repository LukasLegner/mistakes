:- module(confint6, []).

:- discontiguous intermediate/1, expert/4, buggy/4, blame/3, praise/3.
:- use_module(library(i18n)).

% Solution of the problem 
intermediate(confint6/6).
intermediate(quant/4).
intermediate(stderror/6).

expert(X, Y, stderror, []) :-
    X = confint6(N, Xbar, Mu0, Sd, Q90, Q95),
    Y = stderror(N, Xbar, Mu0, Sd / sqrt(N), Q90, Q95).

expert(X, Y, quant, []) :-
    X = stderror(_N, Xbar, Mu0, StandardError, Q90, _Q95),
    Y = quant(Xbar, Mu0, StandardError, Q90).

expert(X, Y, ci, []) :-
    X = quant(Xbar, _Mu0, S, Q),
    StdError = denote(se, S, "with ~m denoting the standard error"),
    Y = interval(Xbar - dot(Q, StdError), Xbar + dot(Q, StdError)).

% Mistakes

% No square root
buggy(X, Y, nosqrt, []) :-
    X = confint6(N, Xbar, Mu0, Sd, Q90, Q95),
    Y = stderror(N, Xbar, Mu0, Sd / N, Q90, Q95).

% 95% instead of 90% interval
buggy(X, Y, wrongci, []) :-
    X = stderror(_N, Xbar, Mu0, StandardError, _Q90, Q95),
    Y = quant(Xbar, Mu0, StandardError, Q95).

% Reference value mu0 instead of mean
buggy(X, Y, reference, []) :-
    X = quant(_Xbar, Mu0, S, Q),
    StdError = denote(se, S, "with ~m denoting the standard error"),
    Y = interval(Mu0 - dot(Q, StdError), Mu0 + dot(Q, StdError)).

% Feedback
praise(en, stderror, "You correctly calculated the estimated standard error of the mean 
    by dividing the sample standard deviation by ~m."-[sqrt(n)]).

praise(en, quant, "You used the correct quantile of the $t$-distribution.").

praise(en, ci, "You correctly used the sample mean to center the confidence interval.").

blame(en, wrongci, "Careful, you calculated the ~m confidence interval 
    instead of the ~m confidence interval."-[q95, q90]).

blame(en, nosqrt, "Careful, you used the sample size $N$ instead of the square root 
 of $N$ to calculate the standard error.").

blame(en, reference, "Careful, you centered the confidence interval around the reference value,
    instead of using the observed sample mean.").