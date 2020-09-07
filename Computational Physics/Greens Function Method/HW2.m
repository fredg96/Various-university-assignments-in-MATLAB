function [phi,exact] = HW2(N,r)
%Function returns calcualted phi and exact solution of phi

a = 4; %given value in exercise instructions
rmax = 30; %given value in exercise instructions. Used as infinity r value

%source term of equation
source = @(r)-r/2*exp(-r); 

%left part of solution
phi1 = @(r)1/(sqrt(2*4))*(exp(4*r)-exp(-4*r));
phileft = @(r)phi1(r)*source(r);

%right part of solution
phi2 = @(r)-1/(sqrt(2*4))*exp(-4*r);
phiright = @(r)phi2(r)*source(r);

%exact analytical solution. Used as reference
exact = (1/(1-a^2))^2*(exp(-a*r)-exp(-r)*(1+(1/2)*(1-a^2)*r));

%calculated solution. Boole function used for integration
phi = phi2(r)*boole(phileft,0,r,N)+phi1(r)*boole(phiright,r,rmax,N);

end

