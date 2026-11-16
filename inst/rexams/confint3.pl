:- module(confint3, []).

:- discontiguous intermediate/1, expert/4, buggy/4, blame/3, praise/3.
:- use_module(library(i18n)).

% Solution of the problem 
intermediate(confint3/6).
intermediate(stderror/4).

expert(X, Y, stderror, []) :-
    X = confint3(N_A, N_B, Mu_A, Mu_B, Q, S2_Pool),
    Y = stderror(Mu_A, Mu_B, Q, S2_Pool * (1 / N_A + 1 / N_B)).

expert(X, Y, ci, []) :-
    X = stderror(Mu_A, Mu_B, Q, S),
    StdError = denote(se, sqrt(S), "with ~m denoting the standard error"),
    Y = interval(Mu_A - Mu_B - dot(Q, StdError), Mu_A - Mu_B + dot(Q, StdError)).

% Mistakes

% 1/N instead of 1/N_A + 1/N_N
buggy(X, Y, reciprocal, []) :-
    X = confint3(N_A, N_B, Mu_A, Mu_B, Q, S2_Pool),
    Y = stderror(Mu_A, Mu_B, Q, S2_Pool * (1 / (N_A + N_B))).

% No square root
buggy(X, Y, nosqrt, []) :-
    X = stderror(Mu_A, Mu_B, Q, S),
    StdError = denote(se, S, "with ~m denoting the standard error"),
    Y = interval(Mu_A - Mu_B - dot(Q, StdError), Mu_A - Mu_B + dot(Q, StdError)).

% Feedback
praise(en, stderror, "You correctly calculated the standard error.").

praise(en, ci, "You have correctly used the observed mean difference to center the confidence interval.").

blame(en, reciprocal, "Careful, when calculating the standard error, you added the two sample sizes before taking the reciprocal, 
    ~m instead of ~m."-[1/(n_A + n_B), 1/n_A + 1/n_B]).

blame(en, nosqrt, "Careful, you forgot to take the square root when calculating the standard error.").
