
:- use_module(library(pita)).

:- if(current_predicate(use_rendering/1)).
:- use_rendering(c3).
:- use_rendering(graphviz).
:- use_rendering(table,[header(['Multivalued variable index','Rule index','Grounding substitution'])]).
:- endif.

:- pita.

:- begin_lpad.

a:- b,c.
a:- d,e.

b:0.3.
abducible c.
d:0.6.
abducible e.

0.1 :- c,e.

:- end_lpad.

/** <examples>

?- abd_prob(a,Prob,Exp).
?-abd_bdd_dot_string(a,BDD,Var,VarA,P,Exp).



*/