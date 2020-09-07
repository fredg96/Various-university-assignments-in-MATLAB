function [net] = popNetworkRandMod(n,k,p,g)
%Returns network with n nodes each being connected to k other nodes.
%Randomly rewires each edge with probability p.
%With probability 1-p rewire to random node with respect to largest
%node network
q = 0.2;
%Set up network
net = sparse(n,n);

for i = 1:n
    for j = 1:k
        net(i,mod((i-1)+j,n)+1) = 1;
    end
end
numlinks = zeros(n,1);    %number of links for each  node including 1 selflink
numlinks(:,1) = k+1;


if p>0
for t = 1:k      %For each link
for i = 1:n     %For each node
    prob = 1/sum(numlinks).*numlinks;  %Weighted probability vector
    
    %Rewire with probability p else do nothing
    %if rand(1,1) < p
        
        %Rewire @ random with probability p, else rewire 
        casE = rand(1,1);
        %with respect to the most popular nodes
        if casE > p+0.5 && casE < 1-g            
            index = find(net(i,:));
            rewireRan = index(t);    %Index for which node to be rewired
            newIndex = randi(n,1);  %Index to which the current node
                                    %will be rewired to

            %Rewire @ random
            while newIndex == rewireRan || newIndex == t || net(i,newIndex)> 0 ||...
                    newIndex == i || net(newIndex,i)>0
                newIndex = randi(n,1);
            end

            %Rewire
            net(i,rewireRan) = 0;
            net(i,newIndex) = 1;
            %Update sum of links in the correct nodes
            numlinks(rewireRan) = numlinks(rewireRan)-1;
            numlinks(newIndex) = numlinks(newIndex)+1;
            %prob = 1/sum(numlinks).*numlinks;   %Update probability vector
        elseif casE< p+0.5 && casE > g
            index = find(net(i,:));
            rewirePop = index(t);    %Index for which node to be rewired
            newIndex = randsample(n,1,true,prob);  %Index to which the current node
            %will be rewired to

            %Rewire with respect to most popular nodes
            while newIndex == rewirePop || newIndex == t || net(i,newIndex)> 0 ||...
                    newIndex == i || net(newIndex,i)>0
                newIndex = randsample(n,1,true,prob);
            end

            %Rewire
            net(i,rewirePop) = 0;
            net(i,newIndex) = 1;
            %Update sum of links in the correct nodes
            numlinks(rewirePop) = numlinks(rewirePop)-1;
            numlinks(newIndex) = numlinks(newIndex)+1;
            %prob = 1/sum(numlinks).*numlinks;   %Update probability vector
        end
    
end
end
end
end
