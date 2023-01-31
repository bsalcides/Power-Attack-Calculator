% All variables can be horizontal vectors , each element corrensponds to
% an attack on a multiattack action. The AB vector can be used to specify
% multiple attacks by itself, missing values for extra attacks on other
% vectors will be assumed to be the same as the first attack
% ------------------------------------------------------------------------

AB = [54, 49, 54, 45, 45, 48];                                                  % Attack Bonus
TwoHand = [true, true, true, false, false, false];                              % Two Handed attack
critrange = [18, 18, 18, 20, 20 20];                                            % Critical range (1-20)
critmult = [4, 4, 4, 2, 2, 2];                                                  % Critical multiplier
critconfirmbonus = [1, 1, 1, 0, 0, 0];                                          % Critical confirmation bonus
multdmg = [3*d(6)+66, 3*d(6)+66, 3*d(6)+66, 2*d(6)+20, 2*d(6)+20, 3*d(6)+20];   % Damage multiplied on critical hit
nonmultdmg = [3*d(6), 3*d(6), 3*d(6), d(6), d(6), d(6)];                        % Damage NOT multiplied on critical hit
% ------------------------------------------------------------------------
BAB = 10;                   % Base attack bonus
AC = 47;                    % Estimated enemy AC
iterations = 10e5;
% ------------------------------------------------------------------------


[result1, result2, graphfig] = PAopt(AB, TwoHand, critrange, critmult, critconfirmbonus, multdmg, nonmultdmg, BAB, AC, iterations);