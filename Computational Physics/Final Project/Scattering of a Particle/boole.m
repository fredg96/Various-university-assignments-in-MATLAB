function [sol] = boole(fun,start,stopend,n)
%bool integration 2*h/45*(7f(x)+32f_1(x)+12*f_2(x)+32*f_3(x)+7*f_4(x)
h = (stopend-start)/(n*4);
sol = 7*fun(start);
x = (start+h);
for i = 1:n-1
    sol = sol+(32*fun(x));
    x=x+h;
    sol = sol +(12*fun(x));
    x=x+h;
    sol = sol +(32*fun(x));
    x=x+h;
    sol = sol +(14*fun(x));
    x=x+h;
end
sol = sol +(32*fun(x));
x=x+h;
sol = sol +(12*fun(x));
x=x+h;
sol = sol +(32*fun(x));
sol = sol +(7*fun(stopend));
sol = sol *(2*h/45);
end

