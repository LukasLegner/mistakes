:- module(chisquare5, []).

:- discontiguous intermediate/1, expert/4, buggy/4, blame/3, praise/3.

% Solution of the problem (X_A denotes the number of failures)
intermediate(chisquare5/4).

expert(X, Y, pool, []) :-
    X = chisquare5(N_A, N_B, X_A, X_B),
    Y = dfrac(X_A + X_B, N_A + N_B).

% Mistakes

% Only failures of group A
buggy(X, Y, only_a_fail, []) :-
    X = chisquare5(N_A, N_B, X_A, _X_B),
    Y = dfrac(N_A - X_A, N_A + N_B).

% Only successes of group B
buggy(X, Y, only_b, []) :-
    X = chisquare5(N_A, N_B, _X_A, X_B),
    Y = dfrac(X_B, N_A + N_B).

% Only successes of group B
buggy(X, Y, only_b, []) :-
    X = chisquare5(N_A, N_B, X_A, _X_B),
    Y = dfrac(X_A, N_A + N_B).
    
% Failures of group A instead of successes
buggy(X, Y, mix_failsucc, []) :-
    X = chisquare5(N_A, N_B, X_A, X_B),
    Y = dfrac(N_A - X_A + X_B, N_A + N_B).

% Feedback

praise(en, pool, "You correctly subtracted the treatment failures from ~m to
       calculate ~m. The pooled success rate 
       is therefore ~m." - [n_a, x_a, frac(x_a + x_b, n_a + n_b)]).

blame(en, only_a_fail, "Careful, you counted the failures observed in group A 
    as treatment successes. Subtracting the failures from ~m, the number of successes 
    in group A is ~m."- [n_a, x_a]).

blame(en, only_a, "Careful, the result includes only the successes observed in group A. 
    The pooled success rate must also include the ~m successes from group B." - [x_b]).
    
blame(en, only_b, "Careful, the result includes only the successes observed in group B. 
    The pooled success rate must also include the ~m successes from group A." - [x_a]).

blame(en, mix_failsucc, "Careful, the result adds the failures from group A to the successes 
    from group B. For the pooled success rate, both terms in the numerator 
    must represent successes.").
    
praise(de, pool, "Du hast die Behandlungsfehlschläge korrekt von ~m abgezogen,
    um ~m zu berechnen. Die gepoolte Erfolgsrate beträgt 
    daher ~m." - [n_a, x_a, frac(x_a + x_b, n_a + n_b)]).

blame(de, only_a_fail, "Vorsicht, du hast die in Gruppe A beobachteten Misserfolge
    als Behandlungserfolge gezählt. Zieht man die Misserfolge von ~m ab, erhält
    man ~m, die Anzahl der Erfolge in Gruppe A."- [n_a, x_a]).

blame(de, only_b, "Vorsicht, das Ergebnis berücksichtigt nur die in Gruppe B 
    beobachteten Erfolge. Die gepoolte Erfolgsrate muss auch die ~m 
    Erfolge aus Gruppe A berücksichtigen." - [x_a]).
    
blame(de, only_b, "Vorsicht, das Ergebnis berücksichtigt nur die in Gruppe A 
    beobachteten Erfolge. Die gepoolte Erfolgsrate muss auch die ~m 
    Erfolge aus Gruppe B berücksichtigen." - [x_b]).

blame(de, mix_failsucc, "Vorsicht, das Ergebnis addiert die Misserfolge aus 
    Gruppe A zu den Erfolgen aus Gruppe B. Für die gepoolte Erfolgsrate müssen 
    beide Terme im Zähler Erfolge darstellen.").