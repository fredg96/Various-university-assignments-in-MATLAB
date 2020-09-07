clear all
%Problem definition
R = 0.5;
roh = 10;
r = 0.3;
alpha = 0.01
a = -1;
b = 1;

N = 12; %Start number of nodes
nN = 1.e+4; %Maximum allowed nodes
h = abs(a-b)/N;
x = [a:h:b];
eta2 = 1; %Initialize eta2 > tol
tol = 1.e-3;

while sum(eta2) >tol || length(x)> nN 
   
    %Mass, Load, Stiff matrix, and forcing function
    Mass = zeros(length(x),length(x));
    Load = zeros(length(x),1);
    Stiff = zeros(length(x),length(x));
    f = Load;
    %Populate function vector
   
    for i = 1:length(x)-1
        if (abs(x(i))<=0.8&&0.3<=abs(x(i)))
                f(i) = roh;
            else
                f(i) = 0;
        end          
    end
    
    %Assemble matrices
    for i = 1:length(x)-1
        h = x(i+1)-x(i);
        n = [i i+1]; 
        Stiff(n,n) = Stiff(n,n)+[1 -1; -1 1]/h; 
        Load(n) = Load(n)+[f(i);f(i+1)]*(h/2);
        Mass(n,n) = Mass(n,n)+[2 1; 1 2]*h/6;
    end
    
    %Boundary condition
   
    Stiff = alpha*Stiff;
    Stiff(1,1) = 1.e+6;
    Stiff(length(x),length(x)) = 1.e+6;
    Load(1) = 0;    
    Load(length(x)) = 0;
     
    %Solve
    xi = Stiff\Load;
    zeta = -Mass\Stiff*xi;
    px = x; %Store current x vector of node coordinates to plot

    %Mesh refinement
    eta2 = zeros(length(x),1);
    res = zeros(length(x),1);
    res = f+zeta; %Residual
    
    for i = 1:length(x)-1
        h = x(i+1)-x(i);
        f1 = f(i)+zeta(i);
        f2 = f(i+1)+zeta(i+1);
        eta2(i) = h^2*(((f1^2+f2^2)*h/2)); %Trapezoid integration
        
    end
    
    lamda = 0.5; %0 uniform refinement, 1 no refinement
    for i = 1:length(eta2)
        if eta2(i) > lamda*max(eta2) %if large then refine
            x = [x (x(i+1)+x(i))/2];
        end
    end
    x = sort(x);
end
figure
subplot(2,2,1)
plot(px,xi)
title('Solution u_h')
subplot(2,2,2)
plot(px,eta2)
title('eta2')
subplot(2,2,3)
plot(px,res)
title('R(u_h)')
subplot(2,2,4)
plot(px(2:end),1./diff(px))
title('Mesh distribution')
