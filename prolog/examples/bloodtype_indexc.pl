/*
Program describing the Mendelian rules of inheritance of the bloodtype of 
people. 
The problem is to predict the probability of the bloodtype of a person.

From
http://dtai.cs.kuleuven.be/cplve/ilp09/
Reference:
Wannes Meert, Jan Struyf, and Hendrik Blockeel. "CP-Logic theory inference with
contextual variable elimination and comparison to BDD based inference methods."
Inductive Logic Programming. Springer Berlin Heidelberg, 2010. 96-109.
*/
:- use_module(library(pitaind)).

:- if(current_predicate(use_rendering/1)).
:- use_rendering(c3).
:- endif.

:- pitaind.

:- set_pitaind(or,exc).
:- begin_lpad.


% mchrom(Person,C) means that the chromosome of Person inherited from his mother
% (or mother chromosome) has allele C. The alleles are a, b and null
% pchrom(Person,C) means that the chromosome of Person inherited from his father
% (or father chromosme) has allele C. The alleles are a, b and null
% bloodtype(Person,B) means that Person has bloodtype B

% rules for determining the allele of the mother chromosome of a Person on the 
% basis of those of his mother 
mchrom(Person,a):0.90 ; mchrom(Person,b):0.05 ; mchrom(Person,null):0.05 :- mother(Mother,Person), pchrom(Mother,a   ), mchrom(Mother,a   ).
% if both chromosome of Person's mother have allele a, then the mother 
% chromosome of Person is a with probability 0.90, b with probability 0.05 and
% null with probability 0.05
mchrom(Person,a):0.49 ; mchrom(Person,b):0.49 ; mchrom(Person,null):0.02 :- mother(Mother,Person), pchrom(Mother,b   ), mchrom(Mother,a   ).
mchrom(Person,a):0.49 ; mchrom(Person,b):0.02 ; mchrom(Person,null):0.49 :- mother(Mother,Person), pchrom(Mother,null), mchrom(Mother,a   ).
mchrom(Person,a):0.49 ; mchrom(Person,b):0.49 ; mchrom(Person,null):0.02 :- mother(Mother,Person), pchrom(Mother,a   ), mchrom(Mother,b   ).
mchrom(Person,a):0.05 ; mchrom(Person,b):0.90 ; mchrom(Person,null):0.05 :- mother(Mother,Person), pchrom(Mother,b   ), mchrom(Mother,b   ).
mchrom(Person,a):0.02 ; mchrom(Person,b):0.49 ; mchrom(Person,null):0.49 :- mother(Mother,Person), pchrom(Mother,null), mchrom(Mother,b   ).
mchrom(Person,a):0.49 ; mchrom(Person,b):0.02 ; mchrom(Person,null):0.49 :- mother(Mother,Person), pchrom(Mother,a   ), mchrom(Mother,null).
mchrom(Person,a):0.02 ; mchrom(Person,b):0.49 ; mchrom(Person,null):0.49 :- mother(Mother,Person), pchrom(Mother,b   ), mchrom(Mother,null).
mchrom(Person,a):0.05 ; mchrom(Person,b):0.05 ; mchrom(Person,null):0.90 :- mother(Mother,Person), pchrom(Mother,null), mchrom(Mother,null).
                                                                                                                                           
% rules for determining the allele of the father chromosome of a Person on the 
% basis of those of his father 
pchrom(Person,a):0.90 ; pchrom(Person,b):0.05 ; pchrom(Person,null):0.05 :- father(Father,Person), pchrom(Father,a   ), mchrom(Father,a   ).
% if both chromosome of Person's father have allele a, then the father 
% chromosome of Person is a with probability 0.90, b with probability 0.05 and
% null with probability 0.05
pchrom(Person,a):0.49 ; pchrom(Person,b):0.49 ; pchrom(Person,null):0.02 :- father(Father,Person), pchrom(Father,b   ), mchrom(Father,a   ).
pchrom(Person,a):0.49 ; pchrom(Person,b):0.02 ; pchrom(Person,null):0.49 :- father(Father,Person), pchrom(Father,null), mchrom(Father,a   ).
pchrom(Person,a):0.49 ; pchrom(Person,b):0.49 ; pchrom(Person,null):0.02 :- father(Father,Person), pchrom(Father,a   ), mchrom(Father,b   ).
pchrom(Person,a):0.05 ; pchrom(Person,b):0.90 ; pchrom(Person,null):0.05 :- father(Father,Person), pchrom(Father,b   ), mchrom(Father,b   ).
pchrom(Person,a):0.02 ; pchrom(Person,b):0.49 ; pchrom(Person,null):0.49 :- father(Father,Person), pchrom(Father,null), mchrom(Father,b   ).
pchrom(Person,a):0.49 ; pchrom(Person,b):0.02 ; pchrom(Person,null):0.49 :- father(Father,Person), pchrom(Father,a   ), mchrom(Father,null).
pchrom(Person,a):0.02 ; pchrom(Person,b):0.49 ; pchrom(Person,null):0.49 :- father(Father,Person), pchrom(Father,b   ), mchrom(Father,null).
pchrom(Person,a):0.05 ; pchrom(Person,b):0.05 ; pchrom(Person,null):0.90 :- father(Father,Person), pchrom(Father,null), mchrom(Father,null).
                                                                                                                                            
                                                                                                                                            
% rules for determining the bloodtype of a Person on the basis of the two 
% alleles on his chromosomes
bloodtype(Person,a):0.90 ; bloodtype(Person,b):0.03 ; bloodtype(Person,ab):0.03 ; bloodtype(Person,null):0.04 :- pchrom(Person,a   ),mchrom(Person,a   ).
% if both chromosomes of Person have allele a, then the bloodtype of Person
% is a with probability 0.90, b with probability 0.03, ab with probability 0.03
% and null with probability 0.04
bloodtype(Person,a):0.03 ; bloodtype(Person,b):0.03 ; bloodtype(Person,ab):0.90 ; bloodtype(Person,null):0.04 :- pchrom(Person,b   ),mchrom(Person,a   ).
bloodtype(Person,a):0.90 ; bloodtype(Person,b):0.04 ; bloodtype(Person,ab):0.03 ; bloodtype(Person,null):0.03 :- pchrom(Person,null),mchrom(Person,a   ).
bloodtype(Person,a):0.03 ; bloodtype(Person,b):0.03 ; bloodtype(Person,ab):0.90 ; bloodtype(Person,null):0.04 :- pchrom(Person,a   ),mchrom(Person,b   ).
bloodtype(Person,a):0.04 ; bloodtype(Person,b):0.90 ; bloodtype(Person,ab):0.03 ; bloodtype(Person,null):0.03 :- pchrom(Person,b   ),mchrom(Person,b   ).
bloodtype(Person,a):0.03 ; bloodtype(Person,b):0.09 ; bloodtype(Person,ab):0.04 ; bloodtype(Person,null):0.03 :- pchrom(Person,null),mchrom(Person,b   ).
bloodtype(Person,a):0.90 ; bloodtype(Person,b):0.03 ; bloodtype(Person,ab):0.03 ; bloodtype(Person,null):0.04 :- pchrom(Person,a   ),mchrom(Person,null).
bloodtype(Person,a):0.03 ; bloodtype(Person,b):0.90 ; bloodtype(Person,ab):0.04 ; bloodtype(Person,null):0.03 :- pchrom(Person,b   ),mchrom(Person,null).
bloodtype(Person,a):0.03 ; bloodtype(Person,b):0.04 ; bloodtype(Person,ab):0.03 ; bloodtype(Person,null):0.90 :- pchrom(Person,null),mchrom(Person,null).

% the alleles of the parents' chromosomes are chosen randomly
mchrom(p_m,a):0.3 ; mchrom(p_m,b):0.3 ; mchrom(p_m,null):0.4.
% the mother chromosome of p_m is a with probability 0.3, b with probability 0.3
% and null with probability 0.4
pchrom(p_m,a):0.3 ; pchrom(p_m,b):0.3 ; pchrom(p_m,null):0.4.			
mchrom(p_f,a):0.3 ; mchrom(p_f,b):0.3 ; mchrom(p_f,null):0.4.
pchrom(p_f,a):0.3 ; pchrom(p_f,b):0.3 ; pchrom(p_f,null):0.4.

% family with 3 people
father(p_f, p).
mother(p_m, p).			

:- end_lpad.

/** <examples>

?- prob(bloodtype(p,a),Prob). % what is the probability that the p's bloodtype is a?
% expected result 0.1957737927437685
?- prob(bloodtype(p,b),Prob). % what is the probability that the p's bloodtype is b?
% expected result 0.22385005085999995
?- prob(bloodtype(p,ab),Prob). % what is the probability that the p's bloodtype is ab?
% expected result 0.193292577
?- prob(bloodtype(p,null),Prob). % what is the probability that the p's bloodtype is 0?
%  expected result 0.1375200361199999
?- prob_bar(bloodtype(p,a),Prob). % what is the probability that the p's bloodtype is a?
% expected result 0.1957737927437685
?- prob_bar(bloodtype(p,b),Prob). % what is the probability that the p's bloodtype is b?
% expected result 0.22385005085999995
?- prob_bar(bloodtype(p,ab),Prob). % what is the probability that the p's bloodtype is ab?
% expected result 0.193292577
?- prob_bar(bloodtype(p,null),Prob). % what is the probability that the p's bloodtype is 0?
%  expected result 0.1375200361199999
*/
 
