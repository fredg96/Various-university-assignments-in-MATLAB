clear all
clc
close all
%Skapar matris A som används i miniproject 1
n=80 %antal columner
h=1/n

a=ones(1,n-1); %vektor med ettor för övre och under diagonal

b=ones(1,n) ;
%diagonal
for i=1:n-1;
   b(i)=2;
end
b(n)= 1;

c=diag(b); %diagonal K matris

d=ones(1,n);
for i=1:n-1;
   d(i)=4;
end
d(n)= 2;
 %diagonal M matris
K=1/h.*(diag(-a,1)+diag(-a,-1)+diag(b));

M=h/6.*(diag(a,1)+diag(a,-1)+diag(d));

A=M^(-1)*K;
