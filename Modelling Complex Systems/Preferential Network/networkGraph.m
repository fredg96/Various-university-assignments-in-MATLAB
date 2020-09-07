function [network] = networkGraph(n,t,m,p)
network = speye(n);
for i = 1:t
    tempNet = network;
    tot = sum(sum(network));
    for k = 1:length(network)
        prob(k) = sum(network(:,k))./tot;
    end
    prob = full(prob);
    tempNet((length(network)+1),(length(network)+1)) = 1;
    for j = 1:m
        if rand() < p
            index = randi(length(network),1);
            tempNet((length(network)+1),index) = tempNet((length(network)+1),index)+1; 

        else
            index = randsample(1:length(network),1,1,prob);
            tempNet((length(network)+1),index) = tempNet((length(network)+1),index)+1; 

        end
    end
    network = tempNet;
end
end

