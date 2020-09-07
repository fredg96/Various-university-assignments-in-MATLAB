clear all
tic
x = [0 0 1 0 1 0 0 0 0 ]; % A C D_A D´_A D_R D´_R mRNA_A mRNA_R R
t = 0; %Starttid
Tf = 100; %sluttid
n = nr_vilar();



parametrar = [50 500 0.01 50 50 5 50 100 1 1 2 0.5 10 1 0.2];
    
Tid =[t]
Result = [x]


while t<Tf
    w_r= prop_vilar(x, parametrar);
    a0 = sum(w_r);
    
    u1 = rand;
    u2 = rand;
    
    
    Tao = log(1-u1)/(-a0);
    p = w_r./a0;
    
    r = find(cumsum(p) > u2, 1);
    
    x = x + n(r,:);
    t = t+Tao
    Result = [Result; x];
    Tid = [Tid; t]; 
    
    
end
plot(Tid, Result, '.')
title('Cirkadisk klocka med stokastisk metod');
xlabel('tid [h]');
tid =toc
