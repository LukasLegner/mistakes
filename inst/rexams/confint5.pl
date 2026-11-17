:- module(confint5, []).

:- discontiguous intermediate/1, expert/4, buggy/4, blame/3, praise/3.
:- use_module(library(i18n)).

% Solution of the problem 
intermediate(confint5/7).
intermediate(pool/6).
intermediate(stderror1/4).
intermediate(stderror2/4).

expert(X, Y, pool, []) :-
    X = confint5(N_A, N_B, X_A, X_B, Sd_A, Sd_B, Q),
    P = denote(s2_pool, dfrac((N_A - 1) * Sd_A^2 + (N_B - 1) * Sd_B^2, N_A + N_B - 2), "with ~m denoting the pooled variance"),
    Y = pool(N_A, N_B, X_A, X_B, P, Q).

expert(X, Y, stderror1, []) :-
    X = pool(N_A, N_B, X_A, X_B, P, Q),
    Y = stderror1(X_A, X_B, P * (1 / N_A + 1 / N_B), Q).

expert(X, Y, stderror2, []) :-
    X = stderror1(X_A, X_B, P, Q),
    Y = stderror2(X_A, X_B, sqrt(P), Q).

expert(X, Y, ci, []) :-
    X = stderror2(X_A, X_B, S, Q),
    StdError = denote(se, S, "with ~m denoting the standard error"),
    Y = interval(X_A - X_B - dot(Q, StdError), X_A + X_B + dot(Q, StdError)).

% Mistakes

% Standard deviation instead of variance
buggy(X, Y, sd, []) :-
    X = confint5(N_A, N_B, X_A, X_B, Sd_A, Sd_B, Q),
    P = denote(s2_pool, dfrac((N_A - 1) * Sd_A + (N_B - 1) * Sd_B, N_A + N_B - 2), "with ~m denoting the pooled variance"),
    Y = pool(N_A, N_B, X_A, X_B, P, Q).

% No square root
buggy(X, Y, nosqrt, []) :-
    X = stderror1(X_A, X_B, P, Q),
    Y = stderror2(X_A, X_B, P, Q).

% 1/N instead of 1/N_A + 1/N_N
buggy(X, Y, reciprocal, []) :-
    X = pool(N_A, N_B, X_A, X_B, P, Q),
    Y = stderror1(X_A, X_B, P * (1 / (N_A + N_B)), Q).

% Feedback
praise(en, pool, "You correctly calculated the pooled variance using the sample variances and their respective degrees of freedom.").

praise(en, stderror1, "You correctly calculated the estimated standard error of the difference between the group means.").

praise(en, stderror2, na).

praise(en, ci, "You correctly used the observed mean difference to center the confidence interval.").

blame(en, sd, "Careful, you used the standard deviations instead of the variances when calculating the pooled variance.").

blame(en, nosqrt, "Careful, you forgot to take the square root when calculating the standard error.").

blame(en, reciprocal, "Careful, when calculating the standard error, you added the two sample sizes before taking the reciprocal, 
    ~m instead of ~m."-[1/(n_A + n_B), 1/n_A + 1/n_B]).