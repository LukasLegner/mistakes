:- module(chisquare6, []).

:- discontiguous intermediate/1, expert/4, buggy/4, blame/3, praise/3.
:- use_module(library(i18n)).

% Solution of the problem 
intermediate(chisquare6/3).

expert(X, Y, pooled_success, []) :-
    X = chisquare6(P_A, P_B, N),
    lang(sucavar, SuccessA),
    lang(sucbvar, SuccessB),
    lang(poolvar, Pooled),
    X_A = denote(x_a, dot(P_A, frac(N, 2)), SuccessA),
    X_B = denote(x_b, dot(P_B, frac(N, 2)), SuccessB),
    P = denote(p_pool, dfrac(X_A + X_B, N), Pooled),
    Y = pool_success(P, P_A, P_B, N).

lang(Id, Elem),
    lang(L),
    lang(L, Id, Elem0)
 => Elem = Elem0.

lang(en, sucavar, "with ~m denoting the number of successes in group A").
lang(en, sucbvar, "with ~m denoting the number of successes in group B").
lang(en, poolvar, "with ~m denoting the pooled success rate").

lang(de, sucavar, "wobei ~m die Anzahl der Erfolge in Gruppe A bezeichnet").
lang(de, sucbvar, "wobei ~m die Anzahl der Erfolge in Gruppe B bezeichnet").
lang(de, poolvar, "wobei ~m die gepoolte Erfolgsrate bezeichnet").

intermediate(pool_success/4).

expert(X, Y, chisquare, []) :-
    X = pool_success(P_pool, P_A, P_B, N),
    Y = chisquare_z(dfrac(P_A - P_B, sqrt(P_pool * (1-P_pool)*(frac(1, N/2) + frac(1, N/2))))).

intermediate(chisquare_z/1).

expert(X, Y, square, []) :-
    X = chisquare_z(dfrac(Num, sqrt(Den))),
    Y = dfrac(Num^2, Den).

% Mistakes

% Report the pooled success rate instead of the test statistic
buggy(X, Y, pool, []) :-
    X = pool_success(P_pool, _P_A, _P_B, _N),
    Y = P_pool.

% Use total sample size
buggy(X, Y, total_n, []) :-
    X = pool_success(P_pool, P_A, P_B, N),
    Y = chisquare_z(dfrac(P_A - P_B, sqrt(P_pool * (1-P_pool)*(frac(1, N) + frac(1, N))))).

% Stop at the z-statistic instead of calculating chi-square
buggy(X, Y, stop_z, []) :-
    X = chisquare_z(Z),
    Y = Z.

% Feedback

praise(en, pooled_success,"You have correctly identified the expression for the pooled success rate
    after calculating the number of successes in group A and B.").

praise(en, chisquare,"You have correctly identified the expression for the ~m-statistic."-[z]).

praise(en, square,"You have correctly transformed the ~m-statistic into the ~m-statistic."-[z, chi^2]).

blame(en, pool, "Careful, the result corresponds to the pooled success rate ~m. 
    This is an intermediate result used in the denominator of the ~m-statistic, 
    but the task is not yet finished."-[p_pool, z]).

blame(en, total_n, "Careful, the result was calculated using the total sample size ~m for both groups. 
    Since the groups are equally large, each group contains ~m patients, 
    so the standard error must use ~m rather than ~m." - [n, n/2, frac(1, n/2) + frac(1, n/2), frac(1, n) + frac(1, n)]).

blame(en, stop_z, "Careful, the result corresponds to the ~m-statistic. 
    The ~m-statistic is obtained by raising it to the square."-[z, chi^2]).
    
praise(de, pooled_success,"Du hast den Ausdruck für die gepoolte Erfolgsrate korrekt identifiziert,
    nachdem du die Anzahl der Erfolge in Gruppe A und B berechnet hast.").

praise(de, chisquare,"Du hast den Ausdruck für die ~m-Statistik korrekt identifiziert."-[z]).

praise(de, square,"Du hast die ~m-Statistik korrekt in die ~m-Statistik umgewandelt."-[z, chi^2]).

blame(de, pool, "Vorsicht, das Ergebnis entspricht der gepoolten Erfolgsrate ~m.
    Dies ist ein Zwischenergebnis, das im Nenner der ~m-Statistik verwendet wird,
    aber die Lösung ist noch nicht vollständig."-[p_pool, z]).

blame(de, total_n, "Vorsicht, das Ergebnis wurde mit dem Gesamtstichprobenumfang ~m für beide Gruppen berechnet.
    Da die Gruppen gleich groß sind, umfasst jede Gruppe ~m Patienten.
    Daher muss für den Standardfehler ~m statt ~m verwendet werden." - [n, n/2, frac(1, n/2) + frac(1, n/2), frac(1, n) + frac(1, n)]).

blame(de, stop_z, "Vorsicht, das Ergebnis entspricht der ~m-Statistik.
    Die ~m-Statistik erhält man, indem man diesen Wert quadriert."-[z, chi^2]).