:- module(confint1, []).

:- discontiguous intermediate/1, expert/4, buggy/4, blame/3, praise/3.
:- use_module(library(i18n)).

% Solution of the problem 
intermediate(confint1/4).
intermediate(stderror/3).

expert(X, Y, stderror, []) :-
    X = confint1(Mu, Sigma, N, Perc),
    Y = stderror(Mu, Sigma/sqrt(N), Perc).

expert(X, Y, ci, []) :-
    X = stderror(Mu, StandardError, Perc),
    Q = denote(quant, qnorm(round(0.5, 1) + frac(Perc, 100) / 2), "with ~m denoting the quantile of the Normal distribution."),
    Y = interval(Mu - Q * StandardError, Mu + Q * StandardError).

% Mistakes

% Variance instead of standard deviation
buggy(X, Y, variance, []) :-
    X = confint1(Mu, Sigma, N, Perc),
    Y = stderror(Mu, Sigma^2, Perc).

% No square root
buggy(X, Y, nosqrt, []) :-
    X = confint1(Mu, Sigma, N, Perc),
    Y = stderror(Mu, Sigma/N, Perc).

% Feedback
praise(en, stderror, "You have correctly calculated the standard error of the mean.").

praise(en, ci, "You have correctly used the mean of the population to calculate the central interval.").

blame(en, variance, "Careful, you used the variance instead of the standard deviation to calculate the standard error.").

blame(en, nosqrt, "Careful, you used the sample size $N$ instead of the square root of the sample size $N$
    to calculate the standard error.").
