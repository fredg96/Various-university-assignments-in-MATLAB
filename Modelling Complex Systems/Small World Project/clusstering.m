function [meanClust,clust] = clusstering(net)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
clust = zeros(1,length(net));
for i = 1:length(net)
    sumComm = 0;
    neighborsRow = find(net(i,:));
    neighborsCol = find(net(i,:));
    neighbors = [neighborsRow neighborsCol];
    neighbors = unique(neighbors);
    for j = 1:length(neighbors)
        nCol = find(net(neighbors(j),:));
        nRow = find(net(neighbors(j),:));
        n = [nCol nRow];
        n = unique(n);
        sumComm = sumComm+(numel(intersect(neighbors,n))/2); %Divided by 2 since we get double
    end
    clust(i) = (2*sumComm)/((length(neighbors))*(length(neighbors)-1));
end
meanClust = sum(clust)/length(net);
end