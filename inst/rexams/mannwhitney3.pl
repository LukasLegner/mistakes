:- module(mannwhitney3, []).

:- discontiguous intermediate/1, expert/4, buggy/4, blame/3, praise/3.
:- use_module(library(i18n)).

% Solution of the problem
intermediate(mannwhitney3/3).
intermediate(lower_crit/2).

expert(X, Y, lower, []) :-
    X = mannwhitney3(U_Crit, N_A, N_B),
    lang(ulowvar, Ulower),
    U_Lower = denote(u_lower, N_A * N_B - U_Crit, Ulower),
    Y = lower_crit(U_Crit, U_Lower).

lang(Id, Elem),
    lang(L),
    lang(L, Id, Elem0)
 => Elem = Elem0.

lang(en, ulowvar, "with ~m denoting the lower critical value.").
lang(de, ulowvar, "mit ~m für den unteren kritischen Wert.").

expert(X, Y, critical_region, []) :-
    X = lower_crit(U_Crit, U_Lower),
    Y = critical(U_Lower, U_Crit).

% Mistakes

% Use only the upper tail
buggy(X, Y, uppert_only, []) :-
    X = mannwhitney3(U_Crit, _N_A, _N_B),
    Y = upper_only(U_Crit).

% Use the upper critical value also as the lower critical value
buggy(X, Y, same_cutoff, []) :-
    X = mannwhitney3(U_Crit, _N_A, _N_B),
    Y = lower_crit(U_Crit, U_Crit).

% Reverse the lower and upper critical values
buggy(X, Y, reversed, []) :-
    X = lower_crit(U_Crit, U_Lower),
    dif(U_Crit, U_Lower),
    Y = critical(U_Crit, U_Lower).

% Shift the lower critical value by one
buggy(X, Y, plus_one, []) :-
    X = mannwhitney3(U_Crit, N_A, N_B),
    lang(ulowvar, Ulower),
    U_Lower = denote(u_lower, N_A * N_B - U_Crit, Ulower),
    Y = lower_crit(U_Crit, U_Lower + 1).

% Feedback

praise(en, lower,
    "You correctly calculated the lower critical value from the symmetry of the ~m-distribution."-[u]).

praise(en, critical_region,
    "You correctly identified the lower and upper critical rejection region.").

blame(en, uppert_only,
    "Careful, this includes only the upper tail.").

blame(en, same_cutoff,
    "Careful, the upper critical value cannot be used directly as the lower critical value.").

blame(en, reversed,
    "Careful, the lower and upper critical values have been interchanged.").

blame(en, plus_one,
    "Careful, the lower critical value has been shifted by 1. Determine the value from the symmetry of the ~m-distribution."-[u]).
    
praise(de, lower,
    "Du hast den unteren kritischen Wert mithilfe der Symmetrie der ~m-Verteilung korrekt berechnet."-[u]).

praise(de, critical_region,
    "Du hast den unteren und oberen kritischen Bereich korrekt identifiziert.").

blame(de, uppert_only,
    "Vorsicht, das ist nur der obere kritische Bereich.").

blame(de, same_cutoff,
    "Vorsicht, der obere kritische Wert kann nicht als unterer kritischer Wert verwendet werden.").

blame(de, reversed,
    "Vorsicht, der untere und der obere kritische Wert wurden vertauscht.").

blame(de, plus_one,
    "Vorsicht, der untere kritische Wert wurde um 1 verschoben. Bestimme den Wert mithilfe der Symmetrie der ~m-Verteilung."-[u]).    