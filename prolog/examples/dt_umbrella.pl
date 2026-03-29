% From [Van den Broeck et al., 2010].

:- use_module(library(pita)).

:- pita.

:- begin_lpad.

0.3::rain.
0.5::wind.

% decision facts
? :: umbrella.
? :: raincoat.

broken_umbrella :- rain,umbrella,wind.
dry :- rain, raincoat.
dry :- rain, umbrella, \+(broken_umbrella).
dry :- \+(rain).

% utility facts
utility(broken_umbrella,-40).
utility(raincoat,-20).
utility(umbrella,-2).
utility(dry,60).

:- end_lpad.

/*
 * ?- dt_solve(Strategy,Value).
 * Expected result:
 * Strategy = [umbrella]
 * Value = 43.0
*/
