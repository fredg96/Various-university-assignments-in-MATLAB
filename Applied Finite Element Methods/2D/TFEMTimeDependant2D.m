%B.3
clear all
close all
t0 = 0.1;
L = 29;
time = [0:t0:L+1/t0];

a = 0.01;
geometry = @circleg;
hmax = 1/32;
[p,e,t] = initmesh(geometry, 'hmax', hmax);
I = eye(length(p));
np = size(p,2);
nt = size(t,2);
roh = 10;
r = 0.3;
R = 0.5;
f = 0;
bc = 0;

Mass = AssembleMass2D(p,t);
Stiff = a*AssembleStiffness2D(p,t);
Load = zeros(size(Stiff,1),1);

bN = unique([e(1,:) e(2,:)]);
iN = setdiff(1:length(p),bN);
for i = 1:length(p)
    if abs(R-sqrt(p(1,i)^2+p(2,i)^2)) <= r
        xi(i) = roh;
    else
        xi(i) = 0;
    end
end
xi = xi';
u_init = xi;
for l = 1:length(time)-1
    k=time(l+1)-time(l);
        pdeplot(p,e,t,'XYData',xi)

    xi = (Mass+t0/2*Stiff)\((Mass-t0/2*Stiff)*xi+(t0*Load/2));
    xi(bN) = 0;
    pause(0.1);
    ml = 0;
    for i = 1:length(t) 
        loc2glb = t(1:3,i);
        x1 = p(1,loc2glb); 
        x2 = p(2,loc2glb); 
        area = polyarea(x1,x2); 
        for i = 1:3 
           m(i) = u_init(loc2glb(i)) - xi(loc2glb(i));
        end
        ml = ml+(sum(m))/3*area;      
    end
    m_loss(l) = ml;
    %m_loss(l) = mass_loss(p,t,u_init,xi);
end
figure
plot([1:length(time)-1],m_loss)
title('Emitted hormone')
ylabel('Mass loss')
xlabel('Time')
figure
subplot(1,2,1),pdeplot(p,e,t,'XYData',u_init)
title('Concentration at t=0')
subplot(1,2,2),pdeplot(p,e,t,'XYData',xi)
title('Concentration at t=30')

