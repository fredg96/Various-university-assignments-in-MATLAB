function [net] = GenerateNetwork(n,k,p)
%Returns network with n nodes each being connected to k other nodes.
%Randomly rewires each edge with probability p.

%Set up network
net = sparse(n,n);

for i = 1:n
    for j = 1:k
        net(i,mod((i-1)+j,n)+1) = 1;    
    end
end

% random rewire with probability p
for i = 1:n
    switchers = rand(k,1) < p;   
    index = find(net(i,:));
    rewire = switchers'.*index;
    rewire(rewire==0) = [];
    for j = 1:length(rewire)
        newIndex = rewire(j);
        while newIndex == rewire(j) || newIndex == j || net(i,newIndex)> 0 || newIndex == i || 0<numel(intersect(i,find(net(newIndex,:))))
            newIndex = randi(n,1);
        end
        net(i,rewire(j)) = 0;
        net(i,newIndex) = 1;
    end
end
end


