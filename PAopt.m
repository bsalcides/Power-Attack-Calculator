function [result1, result2, graphfig] = PAopt(AB, TwoHand, critrange, critmult, critconfirmbonus, multdmg, nonmultdmg, BAB, AC, iterations)

% All variables can be horizontal vectors , each element corrensponds to
% an attack on a multiattack action. The AB vector can be used to specify
% multiple attacks by itself, missing values for extra attacks on other
% vectors will be assumed to be the same as the first attack
% ------------------------------------------------------------------------

pool = gcp('nocreate');
if isempty(pool)
    parpool('threads');
end


PAvalues = (0:-1:-BAB);
numPA = length(PAvalues);
numAtks = length(AB);

for i=2:numAtks
    if (length(TwoHand) < numAtks);           TwoHand(i) = TwoHand(end);                    end
    if (length(critrange) < numAtks);         critrange(i) = critrange(end);                end
    if (length(critmult) < numAtks);          critmult(i) = critmult(end);                  end
    if (length(critconfirmbonus) < numAtks);  critconfirmbonus(i) = critconfirmbonus(end);  end
    if (length(multdmg) < numAtks);           multdmg(i) = multdmg(end);                    end
    if (length(nonmultdmg) < numAtks);        nonmultdmg(i) = nonmultdmg(end);              end 
end

avgdmgperPA = zeros(1,numPA);
med = zeros(1,numPA);
devi = zeros(1,numPA);

for i=1:length(PAvalues)
    dmgFAs = zeros(1, iterations);
    PA = PAvalues(i);
    parfor j=1:iterations
        dmgAtks = zeros(1,numAtks);
        for k=1:numAtks
            actualAB = AB(k) + PA;
            if (TwoHand(k)); actualmultdmg = multdmg(k) - 2*PA; else; actualmultdmg = multdmg(k) - PA; end
            dmgAtks(k) = dmgcalc(actualAB, AC, critrange(k), critmult(k), critconfirmbonus(k), actualmultdmg, nonmultdmg(k));
        end
        dmgFAs(j) = sum(dmgAtks);
    end
    avgdmgperPA(i) = mean(dmgFAs);
    med(i) = median(dmgFAs);
    devi(i) = std(dmgFAs);
    
end

[maxavgdmg,maxavgdmgindex] = max(avgdmgperPA);


graphfig = figure('Name', 'Optimizer Graph', 'NumberTitle', 'off');
% set(graphfig, 'Visible', 'off');
graph = axes(graphfig);
plot(graph, PAvalues, avgdmgperPA,'--ob'); hold(graph, 'on'); plot(graph, PAvalues(maxavgdmgindex), maxavgdmg, 'xr','MarkerSize', 10); grid(graph, 'on'); hold(graph, 'off');
title(graph, "Power Attack Optimizer | " + "Iterations=" + string(int32(iterations)) + " | Max value of " + string(int32(maxavgdmg)) + " at " + string(int32(PAvalues(maxavgdmgindex))));
xlabel(graph, "Power Attack Value"); ylabel(graph, "Average Damage Dealt per Turn");


meanlabels = strings(1,numPA);
addlabels = strings(1,numPA);
for i=1:numPA
    meanlabels(i) = num2str(avgdmgperPA(i), '%.1f');
    addlabels(i) = "Median = " + num2str(med(i), '%.1f') + newline + "Std dev = " + num2str(devi(i), '%.1f');
end

labelpoints(PAvalues, avgdmgperPA, meanlabels, 'N', 0.2, 1, 'FontSize', 10);
labelpoints(PAvalues, avgdmgperPA, addlabels, 'S', 0.2, 1, 'FontSize', 8);


result1 = 'Optimal PA found at ' + string(PAvalues(maxavgdmgindex));
result2 = "Average damage: " + num2str(avgdmgperPA(maxavgdmgindex), '%.1f') + newline + 'Median damage: ' + num2str(med(maxavgdmgindex), '%.1f') + newline + 'Standard deviation: ' + num2str(devi(maxavgdmgindex), '%.1f');

end

function dmg = dmgcalc(AB, AC, critrange, critmult, critconfirmbonus, multdmg, nonmultdmg)
    roll = randi(20);
    atkroll = AB+roll;
    
    if( ((atkroll >= AC)||(roll == 20)) && (roll ~= 1) ) % hit
        if (roll >= critrange) % critcal threat
            critconfirmroll = AB+critconfirmbonus+randi(20);
            if (critconfirmroll >= AC) % crit confirmed
                dmg = multdmg*critmult + nonmultdmg;
            else % crit not confirmed
                dmg = multdmg + nonmultdmg;
            end
        else % regular hit
             dmg = multdmg + nonmultdmg;
        end
    else % miss
        dmg = int32(0);
    end
end