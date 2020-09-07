
n = 10000; % Amount of partitions
h = 10/n; %Length of each step

g1 = 40   %Boundary condition
g2 =200   %Boundary Condition  
x = linspace(h, 10-h,n-1)'; % Vector for plotting

%Create b vector with boundary conditions
b1 = 20/n-40*(-1/h+((h)/12));
bj = 20*ones(n-1,1)/n;
bn = 20/n+200*(1/h+((h)/12));

B1=[1,zeros(1,n-3),0]'; %For first element in b vector
B2=[0,ones(1,n-3),0]';  %For every element EXCEPT first and last in b vector
B3=[0,zeros(1,n-3),1]'; %For last element in b vector

B4 = B1.*b1;
B5 = B2.*bj;
B6 = B3.*bn;

B = [B4+B5+B6];

%Create K matrix
e = ones(n-1,1);
K = spdiags([(-e/h)+(h/6) ((2*e)/h)+((2*h)/3) (-e/h)+(h/6)],-1:1, n-1, n-1);

%Solve linear system
u_fem=K\B;

figure(1)
plot([0;x;10],[g1;u_fem;g2], 'x-')
uh = [20 u_fem' 200];

%Solve analytical derived solution with a small enough step to consider
%continous and plot solution
x = [0:0.0000001:10];
u = ((20.*exp(-x)).*(-exp(x)-exp(2.*x)+(9.*exp(2.*(x+5))+exp(x+20)-(9.*exp(10))+exp(20))))/(exp(20)-1);
figure(2)
plot(x,u)


%l2 norm for rate of convergence
iterr = 6 %amount of iterattions
error=[1:1:iterr]
h = [1:1:iterr];
n = 1

%For loop that calculates the error for different step sizes where each
%step has 10^i partitions
for i = 1:iterr

n= 10*n;
h(i) = 10/n;

x = linspace(h(i), 10-h(i),n-1)';

b1 = 20/n-40*(-1/h(i)+((h(i))/12));
bj = 20*ones(n-1,1)/n;
bn = 20/n+200*(1/h(i)+((h(i))/12));

B1=[1,zeros(1,n-3),0]';
B2=[0,ones(1,n-3),0]';
B3=[0,zeros(1,n-3),1]';

B4 = B1.*b1;
B5 = B2.*bj;
B6 = B3.*bn;

B = [B4+B5+B6];

e = ones(n-1,1);
K = spdiags([(-e/h(i))+(h(i)/6) ((2*e)/h(i))+((2*h(i))/3) (-e/h(i))+(h(i)/6)],-1:1, n-1, n-1);
u_fem=K\B;
uh = [20 u_fem' 200];

x = [0:h(i):10];
u = ((20.*exp(-x)).*(-exp(x)-exp(2.*x)+(9.*exp(2.*(x+5))+exp(x+20)-(9.*exp(10))+exp(20))))/(exp(20)-1);

error(i) = sqrt(sum(u-uh).^2*h(i));
end

n= [10^1 10^2 10^3 10^4 10^5 10^];
%loglog plot of error
figure(3)
loglog(n, error, '*')
title("Rate of convergence")
xlabel("Number of partitions")
ylabel("Error")
hold on 
plot(n.^2, error)
hold on
plot(n.^1, error)
%RoC = log(error(6)/error(5))/log(10^6/10^5) %calculate rate of convergence