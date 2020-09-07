clear all;
N=[8 16 32];    %Lattice size                    
L=4000000;   %Number of simulations/temperature after equilibrium                    
J=1;         %Coupling                    
B=1;         %External magnetic field                    
temp = [1.5:0.05:4];    %Temperatures                     


%allocating required memory
grideqm = cell(1,length(temp)); %Store equilibriate states 
plotM = zeros(length(N),length(temp)); %Matrix to plot M
plotX = zeros(length(N),length(temp)); %Matrix to plot X
plotCv = zeros(length(N),length(temp)); %Matrix to plot Cc
plotCummulant = zeros(length(N),length(temp)); %Matrix to plot cummulant


for a = 1:length(N) %Do for each lattice size
    for i=1:length(temp) %Equilibriate system for each temperature
    [grid] = equMetropolis2nd(N(a), temp(i), J, B);

%store equilibrated arrangements with  
    grideqm{i}= grid;
end
disp('equilibration finished!');

%preallocating for speed
Mp=zeros(1,length(temp));
x=zeros(1,length(temp));
C=zeros(1,length(temp));
Ep=zeros(1,length(temp));


%calculating average properties of the model for each temperature step

for j = 1:length(temp)
    [Ms,Es,xs,Cs,Cums] = propCalcMetro2nd(N(a),temp(j),J,L,grideqm{j},B);
    disp(j);
    Mp(1,j)=Ms;
    Ep(1,j)=Es;
    x(1,j) = xs;
    C(1,j) = Cs;
    Cum(1,j) = Cums;
end
plotM(a,:) = Mp;
plotX(a,:) = x;
plotCv(a,:) = C;
plotCummulant(a,:) = Cum;
end

figure()
plot(temp, plotM)
legend('8x8','16x16', '32x32')
xlabel('Temp','FontSize', 16)
ylabel('Magnetization', 'FontSize', 16)

figure()
plot(temp, plotX)
legend('8x8','16x16', '32x32')
xlabel('Temp','FontSize', 16)
ylabel('X', 'FontSize', 16)

figure()
plot(temp, plotCv)
legend('8x8','16x16', '32x32')
xlabel('Temp','FontSize', 16)
ylabel('C_v', 'FontSize', 16)

figure
plot(temp, plotCummulant)
legend('8x8','16x16', '32x32')
xlabel('Temp','FontSize', 16)
ylabel('Cummulant', 'FontSize', 16)




