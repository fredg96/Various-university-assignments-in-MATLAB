L =0.63; %Bounded by xl, longer gives one wavefront moving while shorter gives two that interfere more
roh = 7800; %unstable for roh<24 when taking 1000 time steps, higher roh gives slower propagation
T = 440; %lower decrease speed T=139550 or more unstable 
d = 0.75*10^-3; %0.5-1, lower increase speed, unstable for d<0.045*10^-3
c = sqrt(T/(pi*d^2/4*roh));
uh = 0.01; %distance lifted, amplitude of wave
xl = 0.1; %distance from end, closer to zero gives more resonance, wave won't die out at end, min 0.004

time = 1; %simuleringstid
nx = 100; %antal noder i rumet
nt = 1000000; % antal steg i tid
dx = L/(nx-1); % steglängd i rum
dt = time/(nt-1); % steglängd i tid
xld = round(xl/dx); %Discretisering för brytpunkt för BV

r = (c*(dt/dx))^2;

%Solution matrix
rx=ceil(L/dx)+1;
rt = ceil(time/dt)+1;
u=zeros(rt,rx);

%Implement BV non derivatives
for i =1:xld
    u(1,i) = uh*(i-1)*dx/xl;     
end

for i = xld:nx
    u(1,i) = uh*(((i-1)*dx-L)/(xl-L));
end

%Implemend BV derivative
for i =2:nx-1
    u(2,i) = u(1,i)+1/2*r*(u(1,i+1)-2*u(1,i)+u(1,i-1)); %Solution first time step
end

%Populate Matrix
for i = 3:nt
    for j = 2:nx-1
        u(i,j)=2*u(i-1,j)-u(i-2,j)+r*(u(i-1,j+1)-2*u(i-1,j)+u(i-1,j-1));
    end
end

%Visualize
plotWave(u)

