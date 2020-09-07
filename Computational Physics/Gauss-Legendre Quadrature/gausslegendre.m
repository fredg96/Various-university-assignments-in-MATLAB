function [sol, p, pder,g,val,c] = gausslegendre(f,n)
% Solves integral with legendre polynomials f is function handle and n is
% degree of legendre polynomial
p = lpol(n);
p = p(n+1,:);

%finds roots with companion matrix algorithm from mathworks
A = diag(ones(n-1,1),-1);
A(1,:) = -p(2:n+1)./p(1);
x = eig(A);

%find coefficients of derivative of polynomial
pder = zeros(1,length(p)-1);
for(i = 1:(length(p)-1))
    pder(i)=p(i)*(length(p)-i);
end

%evaluate f at x(roots)
g = zeros(n,1);
for(i = 1:n)
    g(i) = f(x(i));
end

%solves problem with a version of polyval
c = zeros(1,n);
val = zeros(n,1);
for i= 1:n
    for(j = 1:n)
        val(i) = val(i)+pder(j)*x(i)^(length(x)-j);
    end
    c(i) = 2./((1-x(i).^2).*(val(i).^2)); %2 gives -1 to 1 change to 1 for 0 to 1
end
sol = 0;
for(i= 1: n)
    sol = sol+c(i)*g(i);
end
end

