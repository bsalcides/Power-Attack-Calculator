function loadPA()

uiopen('*.mat');

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

end