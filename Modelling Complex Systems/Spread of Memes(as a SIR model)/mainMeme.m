%% 1.2.1
clear all

N = 1000;
steps = 4000;
q = 0.01;
p = 0.001;
B0 = 1;
S0 = 1;
R0 = N-B0-S0;
runs = 1000;
plotS = zeros(runs,steps);
plotB = zeros(runs,steps);
plotR = zeros(runs,steps);
for i = 1:runs
    [S B R] = memeSpread1(R0,S0,B0,N,p,q,steps);
    plotS(i,:) = S;
    plotB(i,:) = B;
    plotR(i,:) = R;
end
figure
hold on
plot(1:1:steps,plotS,'k')
pr = plot(1:1:steps, mean(plotS),'r')
set(pr,'LineWidth',2)

%Mean field equations
Smf(1) = S0;
Bmf(1) = B0;
Rmf(1) = R0;

for i = 1:steps-1
    Smf(i+1) = Smf(i)+p*Rmf(i)-q*Smf(i)*Bmf(i)/N+q*Smf(i)*Rmf(i)/N;
    Bmf(i+1) = Bmf(i)+q*Smf(i)*Bmf(i)/N;
    Rmf(i+1) = Rmf(i)-p*Rmf(i)-q*Smf(i)*Rmf(i)/N;
end
figure
hold on
plot(1:1:steps,plotS,'k')
plot(1:1:steps, mean(plotS),'r')
plot(1:1:steps, Smf, 'b')
ylabel('Number of sharer','FontSize',16)
xlabel('Step','FontSize',16)
%legend('','Mean value of simulation', 'Mean-Field equation')
%xlabe
%set(pr,'LineWidth',2)

%% 1.2.2.1
clear all
close all
N = 1000;
steps = 10000;
%Cycles B0 = 10, S0 = 100, q= 0.02, p = 0, r = 0.01 
q = 0.02; % sort of neverending cycles
p = 0.02; % sort of neverending cycles
r = 0.02; % sort of neverending cycles
B0 = 10;
S0 = 70;
R0 = N-B0-S0;
runs = 1;
plotS = zeros(runs,steps);
plotB = zeros(runs,steps);
plotR = zeros(runs,steps);
for i = 1:runs
    [S B R] = memeSpread2(R0,S0,B0,N,p,q,r,steps);
    plotS(i,:) = S;
    plotB(i,:) = B;
    plotR(i,:) = R;
end
figure
hold on
plot(1:1:steps,plotS)
plot(1:1:steps,plotB)
plot(1:1:steps,plotR)
legend('Sharer','Bored','Resting');



%Mean field model
Smf(1) = S0;
Bmf(1) = B0;
Rmf(1) = R0;
for i = 1:steps-1
    Smf(i+1) = Smf(i)+p*Rmf(i)-(q*Smf(i)*Bmf(i)/N)+(q*Smf(i)*Rmf(i)/N);
    Bmf(i+1) = Bmf(i)+q*Smf(i)*Bmf(i)/N-(r*Bmf(i)*Rmf(i)/N);
    Rmf(i+1) = Rmf(i)-(p*Rmf(i))-(q*Smf(i)*Rmf(i)/N)+(r*Bmf(i)*Rmf(i)/N);
end
figure
hold on
plot(1:1:steps,Smf)
plot(1:1:steps,Bmf)
plot(1:1:steps,Rmf)
hold off
legend('Sharer','Bored','Resting');
%% 1.2.2.2
clear all
N = 1000;
steps = 10000;
q = 0.2; %0.01 sort of neverending cycles
p = 0.001; %0.001 sort of neverending cycles
r = 0.6; %0.09 sort of neverending cycles
B0 = 1;
S0 = 70;
R0 = N-B0-S0;
Smf(1) = S0;
Bmf(1) = B0;
Rmf(1) = R0;
p =[0.001:0.001:1];
reps = 40;
hrange=[0:1:N];
histSp=zeros(length(r),length(hrange));
for k = 1:length(p)
    for j = 1:reps
       
        [S B R] = memeSpread2(R0,S0,B0,N,p(k),q,r,steps);
        [Sm, L] = bounds(S(10:end-20));
        finalSp(k,j)= L - Sm;
    end
     histSp(k,:)=hist(finalSp(k,:),hrange);
end
figure
imagesc(p,hrange,histSp'/reps,[0 0.1])
title('Phase transition for r')
q = 0.2; %0.01 sort of neverending cycles
p = 0.001; %0.001 sort of neverending cycles
r = 0.6; %0.09 sort of neverending cycles
B0 = 1;
S0 = 70;
R0 = N-B0-S0;
Smf(1) = S0;
Bmf(1) = B0;
Rmf(1) = R0;
r =[0.001:0.001:1];
reps = 40;
hrange=[0:1:N];
histSr=zeros(length(r),length(hrange));
for k = 1:length(r)
    for j = 1:reps
      
        [S B R] = memeSpread2(R0,S0,B0,N,p,q,r(k),steps);
        [Sm, L] = bounds(S(10:end-20));
        finalSr(k,j)= L - Sm;
    end
     histSr(k,:)=hist(finalSr(k,:),hrange);
end
figure
imagesc(r,hrange,histSr'/reps,[0 0.1])
title('Phase transition for r')
q = 0.2; %0.01 sort of neverending cycles
p = 0.001; %0.001 sort of neverending cycles
r = 0.6; %0.09 sort of neverending cycles
B0 = 1;
S0 = 70;
R0 = N-B0-S0;
Smf(1) = S0;
Bmf(1) = B0;
Rmf(1) = R0;
q =[0.001:0.001:1];
reps = 40;
hrange=[0:1:N];
histSq=zeros(length(r),length(hrange));
for k = 1:length(q)
    for j = 1:reps
        
        [S B R] = memeSpread2(R0,S0,B0,N,p,q(k),r,steps);
        [Sm, L] = bounds(S(10:end-20));
        finalSq(k,j)= L - Sm;
    end
     histSq(k,:)=hist(finalSq(k,:),hrange);
end
figure
imagesc(q,hrange,histSq'/reps,[0 0.1])
title('Phase transition for q')
r = 0.01;
%% 1.2.3
clear all
close all
N = 32^2;
steps = 1000;
q = 0.01;
p = 0.001;
r = 0.04;
B0 = 100;
S0 = 100;
R0 = N-B0-S0;
runs = 1;
plotS = zeros(runs,steps);
plotB = zeros(runs,steps);
plotR = zeros(runs,steps);
for i = 1:runs
    [S B R] = memeSpreadGrid(R0,S0,B0,N,p,q,r,steps);
    plotS(i,:) = S;
    plotB(i,:) = B;
    plotR(i,:) = R;
end



