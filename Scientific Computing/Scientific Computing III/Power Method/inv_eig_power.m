function [ x,lamda ] = inv_eig_power(A)
% Inverse iteration to find smalles eigenvalue to matrix A and 
% the coresponding eigenvector

tol=1e-4; 
n=length(A);
x=ones(n,1);
x=x/norm(x);

lamda=0; %% Initial guess for eigenvalue
dd=1; % Value larger than tol in to start while loop
counter=0;
while dd>tol
    
    lamdaold=lamda;      %Set previous lamda to current value
    xnew=A\x;            %Solve equation
    lamda=norm(xnew);    % Update lamda
    x=xnew/lamda;        % Calculate eigenvector
    dd= (lamda-lamdaold); %Calculate difference between eigenvalues
  counter=counter+1
end
x = x/norm(x)   %Final eigenvector
lamda=1/lamda   %Final eigenvalue
counter         %Number of steps


end

