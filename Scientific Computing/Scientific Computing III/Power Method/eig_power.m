function [ x,lamda ] = eig_power(A)
%Calculate largest eigenvalue with the power function to the matrix A 
% and its corresponding eigenvector
tol=1e-4;  %how close before stopping iterations
n=length(A);
x=ones(n,1); %Initial solution
x=x/norm(x);

lamda=0;  %initial eigenvalue
dd=1;     %Value larger than tol to start while loop
counter=0;
while dd>tol
    counter=counter+1; 
    lamdaold=lamda; %Set previous lamda to current value
    xnew=A*x;        %Solve equation
    lamda=norm(xnew); %Update lamda
    x=xnew/lamda;     
    dd= (lamda-lamdaold);
  
end
x = x/norm(x)
lamda
counter

plot(x)


end

