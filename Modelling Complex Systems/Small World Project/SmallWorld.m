clear all
close all
n = 1000;
p = [0.0001 0.00015 0.0003 0.0005 0.0008 0.001 0.0015 0.003 0.004 0.008 0.015 0.02 0.04 0.06 0.1 0.15 0.25 0.3 0.4 0.7 1];%1 [0.001 1]
k = 5; %Half the desired degree in "Small world" they have K = 10, therefore k = K/2 = 5
g = [0.01 0.25 0.5] %[0.0 0.005 0.01 0.015 0.02 0.025 0.03 0.04 0.06 0.08 0.1 0.15 0.2 0.25 0.3 0.35 0.4 0.45 0.5]; %[0.01 0.25 0.5];
crange = [0:0.01:1.6];
histG=zeros(length(g),length(crange));

reps = 100; %150 for comparison
%for m = 1:length(g)
for j = 1:reps
    for i = 1:length(p)
   [net1] = popNetworkRandMod(n,k,p(i),g(1));
    net1 = net1+net1'; % Make graph undirected
    meanCPrefRand(j,i) = clusstering(net1);
    distPrefRand(j,i) = mean(mean(distances(digraph(net1))));
    [net2] = popNetworkRandMod(n,k,p(i),g(2));
    net2 = net2+net2'; % Make graph undirected
    c025(j,i) = clusstering(net2);
    l025(j,i) = mean(mean(distances(digraph(net2))));
    [net3] = popNetworkRandMod(n,k,p(i),g(3));
    net3 = net3+net3'; % Make graph undirected
    c05(j,i) = clusstering(net3);
    l05(j,i) = mean(mean(distances(digraph(net3))));
    
    
     [wsNet] = GenerateNetwork(n,k,p(i));
     wsNet = wsNet+wsNet';
     meanCWS(j,i) = clusstering(wsNet);
     distWS(j,i) =  mean(mean(distances(digraph(wsNet))));
     
%   
    
        end
%         c = meanCPrefRand(2)./meanCPrefRand(1);
%         finalC(m,j) = c;
    end
  
% histG(m,:) = hist(finalC(m,:),crange);

% figure
% imagesc(g,crange,histG'/reps,[0 0.5])
% 
% title('Phase transition for c')

cg0 = mean(meanCPrefRand);
lg0 = mean(distPrefRand);
cg025= mean(c025);
lg025=mean(l025);
cg05=mean(c05);
lg05=mean(l05);
dist = mean(distWS);
meanC = mean(meanCWS);


figure
 semilogx(p,dist./dist(1),'*')
 hold on
 semilogx(p,meanC./meanC(1),'*')
semilogx(p,cg0./cg0(1),'--')
hold on
semilogx(p,cg025./cg025(1),'--')
semilogx(p,cg05./cg05(1),'--')
semilogx(p,lg0./lg0(1))
semilogx(p,lg025./lg025(1))
semilogx(p,lg05./lg05(1))

 legend('WS-L(p)','WS-C(p)','C(p),g = 0', 'C(p),g=0.25','C(p),g=0.5','L(p),g=0','L(p),g=0.25','L(p),g=0.5')
 hold off
%%
clear all
close all
n = 1000;
p = [0.0001 0.00015 0.0003 0.0005 0.0008 0.001 0.0015 0.003 0.004 0.008 0.015 0.02 0.04 0.06 0.1 0.15 0.25 0.3 0.4 0.7 1];%1 [0.001 1]
k = 5; %Half the desired degree in "Small world" they have K = 10, therefore k = K/2 = 5
dissease = 0;
infected = 0;
time = 10000;
r = 0.27;
g = [0.01 0.25 0.5] %[0.0 0.005 0.01 0.015 0.02 0.025 0.03 0.04 0.06 0.08 0.1 0.15 0.2 0.25 0.3 0.35 0.4 0.45 0.5]; %[0.01 0.25 0.5];
crange = [0:0.01:1.6];
histG=zeros(length(g),length(crange));

%if k<log(n/2) % doesn't work since our k is half of strogatz K
 %   k = log(n+1);
%end
reps = 100; %150 for comparison
%for m = 1:length(g)
for i = 1:length(p)
    for j = 1:reps
   [net1] = popNetworkRandMod(n,k,p(i),g(1));
    net1 = net1+net1'; % Make graph undirected
   % meanCPrefRand(i) = clusstering(net);
    %distPrefRand(j,i) = mean(mean(distances(digraph(net))));
    sickG001(j,:) = sirNetwork(net1,1, 100, 0.3, 0.4, 0.3);
    [net2] = popNetworkRandMod(n,k,p(i),g(2));
    net2 = net2+net2'; % Make graph undirected
%     c025(j,i) = clusstering(net);
%     l025(j,i) = mean(mean(distances(digraph(net))));
   sickG025(j,:) = sirNetwork(net2,1, 100, 0.3, 0.4, 0.3);
    [net3] = popNetworkRandMod(n,k,p(i),g(3));
    net3 = net3+net3'; % Make graph undirected
%     c05(j,i) = clusstering(net);
%     l05(j,i) = mean(mean(distances(digraph(net))));
    sickG05(j,:) = sirNetwork(net3,1, 100, 0.3, 0.4, 0.3);
    
    if dissease == 1
        [healthy] = disseaseSpread(net, infected, time,r);
        %figure()
        %plot(graph(net),'Layout','Circle')
        healthy(all(~any( healthy),2 ),:) = []; % removes all rows with all zero
        healthy(:,all(~any( healthy),1)) = [];
    end
     [wsNet] = GenerateNetwork(n,k,p(i));
     wsNet = wsNet+wsNet';
     sickWS(j,:) = sirNetwork(wsNet,1, 100, 0.3, 0.4, 0.3);
%      meanCWS(j,i) = clusstering(wsNet);
%      distWS(j,i) =  mean(mean(distances(digraph(wsNet))));
     
%   
    
        end
%         c = meanCPrefRand(2)./meanCPrefRand(1);
%         finalC(m,j) = c;
    end
    sick01=mean(sickG001);
    sick025 = mean(sickG025);
    sick05= mean(sickG05);
    sickWS=mean(sickWS(j,:));
figure
plot(1:1:100,sick01)
hold on
plot(1:1:100,sick025)
plot(1:1:100,sick05)
plot(1:1:100,sickWS)
hold off 
xlabel('Timestep')
ylabel('Number of Sick')
legend('g=0.01','g=0.25','g=0.5','WS-net')
 

 %%
 clear all
close all
n = 1000;
p = [0.0001 0.00015 0.0003 0.0005 0.0008 0.001 0.0015 0.003 0.004 0.008 0.015 0.02 0.04 0.06 0.1 0.15 0.25 0.3 0.4 0.7 1];%1 [0.001 1]
k = 5; %Half the desired degree in "Small world" they have K = 10, therefore k = K/2 = 5
dissease = 0;
infected = 0;
time = 10000;
r = 0.27;
g = [0.01 0.25 0.5] %[0.0 0.005 0.01 0.015 0.02 0.025 0.03 0.04 0.06 0.08 0.1 0.15 0.2 0.25 0.3 0.35 0.4 0.45 0.5]; %[0.01 0.25 0.5];
crange = [0:0.01:1.6];
histG=zeros(length(g),length(crange));

%if k<log(n/2) % doesn't work since our k is half of strogatz K
 %   k = log(n+1);
%end
reps = 100; %150 for comparison
%for m = 1:length(g)
for i = 1:length(p)
    for j = 1:reps
   [net1] = popNetworkRandMod(n,k,p(i),g(1));
    net1 = net1+net1'; % Make graph undirected
    l001(j) = mean(mean(distances(digraph(net1))));
    sickG001(j) = sirNetwork(net1,1, 100,  0, 1, 0);
    [net2] = popNetworkRandMod(n,k,p(i),g(2));
    net2 = net2+net2'; % Make graph undirected
     l025(j) = mean(mean(distances(digraph(net2))));
   sickG025(j) = sirNetwork(net2,1, 100,  0, 1, 0);
    [net3] = popNetworkRandMod(n,k,p(i),g(3));
    net3 = net3+net3'; % Make graph undirected
     l05(j) = mean(mean(distances(digraph(net3))));
    sickG05(j) = sirNetwork(net3,1, 100,  0, 1, 0);
    
     [wsNet] = GenerateNetwork(n,k,p(i));
     wsNet = wsNet+wsNet';
     sickWS(j) = sirNetwork(wsNet,1, 100, 0, 1, 0);
      distWS(j) =  mean(mean(distances(digraph(wsNet))));
        end
    sick01(i)=mean(sickG001);
    sick025(i) = mean(sickG025);
    sick05(i) = mean(sickG05);
    sickws(i) =mean(sickWS); 
    meanL001(i) = mean(l001);
    meanL025(i) = mean(l025);
    meanL05(i) = mean(l05);
    meanWS(i) = mean(distWS);
    end
   
figure
semilogx(p,meanL001./meanL001(1))
hold on
semilogx(p,meanL025./meanL025(1))
semilogx(p,meanL05./meanL05(1))
semilogx(p,meanWS./meanWS(1))
semilogx(p,sick01./sick01(1),'*')
semilogx(p,sick025./sick025(1),'*')
semilogx(p,sick05./sick05(1),'*')
semilogx(p,sickws./sickws(1),'*')
xlabel('p')
legend('L/L(0),g=0.01','L/L(0),g=0.25','L/L(0),g=0.5','L/L(0),WS','T(p)/T(0),g=0.01','T(p)/T(0),g=0.25','T(p)/T(0),g=0.5','T(p)/T(0),WS')


