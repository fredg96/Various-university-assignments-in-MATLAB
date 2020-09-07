
function [grid] = equMetropolis2nd(N, T, J, B)

grid = sign(0.5-rand(N,N)); %Initialize grid random 1 or -1
numIters = 2^9*N*N;       %Number of steps for equilibration

for iter = 1 : numIters
    % Pick a random spin
    x = randi(N,1);
    y = randi(N,1);
    
    % Find its nearest neighbors with periodic boundary
    if y == 1;
        left = grid(x,N)-grid(x,N-1);
    elseif y == 2;
            left = grid(x,1)-grid(x,N);
    else
        left = grid(x,y-1)-grid(x,y-2);
    end   
    if y == N;
        right = grid(x,1)-grid(x,2);
    elseif y == N-1;
            right = grid(x,N)-grid(x,1);
    else
        right = grid(x,y+1)-grid(x,y+2);
    end
     if x == 1;
        up = grid(N,y)-grid(N-1,y);
    elseif x == 2;
            up = grid(1,y)-grid(N,y);
    else
        up = grid(x-1,y)-grid(x-2,y);
     end
    if x == N;
        down = grid(1,y)-grid(2,y);
    elseif x == N-1;
            down = grid(N,y)-grid(1,y);
    else
        down = grid(x+1,y)-grid(x+2,y);
    end
    
    neighbors = up+down+left+right;
    
    % Calculate energy change if this spin is flipped
    dE = 2 *(J*grid(x, y)*sum(neighbors)-(grid.*B));
    
    % Spin flip condition
    if dE <= 0 
        grid(x, y) = - grid(x, y);
    else
        prob = exp(-dE / T); %save calculations to here due to comp. expensive.
        if rand(1) <= prob
        grid(x, y) = - grid(x, y);
        end
    end
    
    end
end