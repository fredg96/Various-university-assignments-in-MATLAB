function [S B R] = memeSpread1(R0,S0,B0,N,p,q,steps)
R = zeros(steps,1);
S = zeros(steps,1);
B = zeros(steps,1);
R(1) = R0;
S(1) = S0;
B(1) = B0;

for i = 1:steps-1
    R(i+1) = R(i);
    S(i+1) = S(i);
    B(i+1) = B(i);
    for j = 1:S(i)
        if q > rand()
            if rand() < R(i+1)/N
                R(i+1) = R(i+1)-1;
                S(i+1) = S(i+1)+1;                
            else
                S(i+1) = S(i+1)-1;
                B(i+1) = B(i+1)+1;    
            end
        end
    end
    if rand()< p
        if S(i+1) ~= 0
            S(i+1) = S(i+1)+1;
            R(i+1) = R(i+1)-1;
        end
    end
end

