function [p] = lpol(n)
if(n<1)
    p = 1;
else
    p = zeros(n+1,n+1);
    p(1,n+1)=1;
    p(2,n:n+1) = [1 0];
    for i = 1:n-1
        p(i+2,n-i:n+1) = 1/(i+1)*((2*i+1)*[p(i+1,n+1-i:n+1) 0]-i*[0 0 p(i,n+2-i:n+1)]);
    end
end
end

