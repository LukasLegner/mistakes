:- module(chisquare4, []).

:- discontiguous intermediate/1, expert/4, buggy/4, blame/3, praise/3.

% Solution of the problem
intermediate(chisquare4/1).

expert(X, Y, square, []) :-
    X = chisquare4(Z),
    Y = Z^2.

% Mistakes

% Report the original z-statistic
buggy(X, Y, only_z, []) :-
    X = chisquare4(Z),
    Y = Z.

% Absolute value of z-statistic
buggy(X, Y, abs_z, []) :-
    X = chisquare4(Z),
    Y = abs(Z).

% Negative of squared z-statistic
buggy(X, Y, neg_square, []) :-
    X = chisquare4(Z),
    Y = -Z^2.  

% Feedback

praise(en, square, "Correct. The ~m-square statistic is obtained 
    by squaring the ~m-statistic."- [chi^2, z]).

blame(en, only_z, "Careful, the result corresponds to the original ~m-statistic. 
    To obtain the ~m statistic, the ~m-statistic must be squared." - [z, chi^2, z]).

blame(en, abs_z, "Careful, you simply removed the the sign of the ~m-statistic.
    The ~m-statistic is obtained by squaring the ~m-statistic." - [z, chi^2, z]).

blame(en, neg_square, "Careful, value of the ~m-statistic has been squared, 
      but you kept the minus."- [z]).
    
praise(de, square, "Richtig. Die ~m-Statistik erhält man,
    indem man die ~m-Statistik quadriert."- [chi^2, z]).

blame(de, only_z, "Vorsicht, das Ergebnis entspricht der ursprünglichen ~m-Statistik.
    Um die ~m-Statistik zu erhalten, muss die ~m-Statistik quadriert werden." - [z, chi^2, z]).

blame(de, abs_z, "Vorsicht, du hast nur das Vorzeichen der ~m-Statistik entfernt.
    Die ~m-Statistik erhält man, indem man die ~m-Statistik quadriert" - [z, chi^2, z]).

blame(de, neg_square, "Vorsicht, die ~m-Statistik wurde quadriert, aber du
    hast das Minus behalten."- [z]).