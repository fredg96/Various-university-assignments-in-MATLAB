function [sites] = sites(n,t,m,p)
sites = ones(1,n);
for i = 1:t
    newSite = 0;
    tempSites = sites;
    for j = 1:m
        if rand() < p
            index = randi(length(tempSites),1);
            tempSites(index) = tempSites(index)+1;
        else
            tot = sum(sites);
            for k = 1:length(tempSites)
                prob(k) = sites(k)./tot;
            end
            index = randsample(1:length(tempSites),1,1,prob);
            tempSites(index) = tempSites(index) + 1;
        end
    end
    sites = tempSites;
    sites = [sites 1];
end
end

