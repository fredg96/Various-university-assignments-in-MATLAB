%choose N number of integration points. Needs to be a multiple of 4
%choose rstep freely. Stepsize.
function y = HW2main(N,rstep)

r = 0:rstep:30;

ysol = zeros(length(r),1);
exactsol = zeros(length(r),1);

for i =1:length(r)
[ysol(i),exactsol(i)] = HW2(N,r(i));
end
err = abs(exactsol-ysol);
figure
plot(r,ysol,'--',r,exactsol,'-.')
title('Solution of Phi with respect to r')
xlabel('r value')
ylabel('Phi value')
legend('Numerical solution','Exact solution')
figure
plot(r,err)
xlabel('r value')
ylabel('abs(Error)')
title('abs(Error) with respect to r')

end


