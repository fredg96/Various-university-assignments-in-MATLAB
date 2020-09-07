function [origSize, randSize, dirSize] = clusters(net,nToRemove)
%Calculate largest cluster size after directed and random attack
net1 = net;
net2 = net;
for i = 1:nToRemove
    x = randi(length(net1));
    net1(x,:) = 0;
    net1(:,x) = 0;
end
for i = 1:nToRemove
    sums = sum(net2,1);
    maximum = max(sums);
    [x,y] = find(sums == maximum);
    net2(y(1),:) = 0;
    net2(:,y(1)) = 0;
end
[numOrigComp, origComp] = graphconncomp(net,'Directed',false);
[randAttNComp, randAttComp] = graphconncomp(net1,'Directed',false);
[dirAttNComp, dirAttCom] = graphconncomp(net2,'Directed',false);
origBins = histcounts(origComp,1:length(net));
randBins = histcounts(randAttComp,1:length(net));
dirBins = histcounts(dirAttCom,1:length(net));
origSize = max(origBins);
randSize = max(randBins);
dirSize = max(dirBins);
end

