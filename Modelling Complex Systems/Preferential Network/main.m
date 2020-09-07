%%
clear all
close all
n = 100;
t = 10000;
m = 1;
p = 1;
net = sites(n,t,m,p);

figure
hist(net,100)
xlabel('Number of links')
ylabel('Number of sites')

bins = histcounts(net, 1:t);
figure()
loglog(1:t-1,bins,'.')
ylabel('Number of sites')
xlabel('Number of links')

%alpha = 1+length(mNet)*(1/sum(log(mNet./min(mNet))));
%%
clear all
close all
n = 100;
t = 15000;
m = 100;
p = 0.0;
reps = 100;
for i = 1:reps
    net(i,:) = sites(n,t,m,p);
end
%mNet = mean(net);
%net = mNet;
figure
hist(net(:),100)
xlabel('Number of links')
ylabel('Number of sites')

bins = histcounts(net(:), 1:t);
figure()
loglog(1:t-1,bins,'.')
ylabel('Number of sites')
xlabel('Number of links')

%alpha = 1+length(mNet)*(1/sum(log(mNet./min(mNet))));

%%
clear all
close all
n = 100;
t = 12000;
m = [1 10 100];
p = [0.1 0.5 0.75];
nToRemove = 100
for i = 1:length(m)
    for j = 1: length(p)
        net = networkGraph(n,t,m(i),p(j));
        [o(i,j) r(i,j) d(i,j)] = clusters(net,nToRemove);
    end
end
