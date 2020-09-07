function [ lamda,x ] = mypower( A )
%Power method to find eigenvalues of matrix A
lamda=0
n=length(A)
x=ones(n,1)
tol=1e-12
while(1)
    mold=lamda
    x=A*x
    lamda=max(x)
    x=x/lamda
    if(lamda-mold)<tol
        break;
    end
end
    
end

