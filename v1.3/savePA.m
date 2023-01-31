function savePA(AB, TwoHand, critrange, critmult, critconfirmbonus, multdmg, nonmultdmg, numAtks, BAB, AC, DR, miss, iterations)

assignin('caller', 'AB', AB);
assignin('caller', 'TwoHand', TwoHand);
assignin('caller', 'critrange', critrange);
assignin('caller', 'critmult', critmult);
assignin('caller', 'critconfirmbonus', critconfirmbonus);
assignin('caller', 'multdmg', multdmg);
assignin('caller', 'nonmultdmg', nonmultdmg);
assignin('caller', 'numAtks', numAtks);
assignin('caller', 'BAB', BAB);
assignin('caller', 'AC', AC);
assignin('caller', 'DR', DR);
assignin('caller', 'miss', miss);
assignin('caller', 'iterations', iterations);

uisave({'AB', 'TwoHand', 'critrange', 'critmult', 'critconfirmbonus', 'multdmg', 'nonmultdmg', 'numAtks', 'BAB', 'AC', 'DR', 'miss', 'iterations'},'PAO_template_1.mat')

end