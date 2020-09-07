function [i] = sirNetwork(net,initialInfected, time, r, s, h)
%Typ SIR modellen inparametrar netvärk, lista med ursprungliga infekterade,
%antal tidssteg, rand < r är chans att sjuk blir frisk och imun, tänk bored,
%rand < h chans att "bored" blir normal och kan bli sjuk igen. s är chans
%att sjukdom sprids, rand < s

infected = initialInfected;
spread = s;
recover = r;
recovered = 0;
i = 0;
cont = 1;
while cont == 1
    for j = 1:length(infected)
        neighbors = find(net(infected(j),:));
        neighbors = unique(setdiff(neighbors,recovered));
        neighbors = unique(setdiff(neighbors,infected));
        
        for k = 1:length(neighbors)
            if rand < spread
                infected(end+1) = neighbors(k);
            end
        end
        if  rand < recover
            recovered(end+1) = infected(j);
            infected(j) = 0;
        end
    end
    for j = 1: length(recovered)
        if rand < h
            recovered(j) = 0;
        end
    end
    infected = infected(infected~= 0);
    infected = unique(infected);
    recovered = recovered(recovered~= 0);
    recovered = unique(recovered);
    %sickAtTime(i) = length(infected);
    %imuneAtTime(i) = length(recovered);
    %healthyAtTime(i) = length(net)-sickAtTime(i)-imuneAtTime(i);
    i = i+1;
    if length(infected) == length(net)
        cont = 0;
    end
end

