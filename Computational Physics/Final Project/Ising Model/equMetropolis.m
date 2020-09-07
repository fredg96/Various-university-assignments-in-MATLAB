
function [grid] = equMetropolis(N, T, J, B)

grid = sign(0.5-rand(N,N)); %Initialize grid random 1 or -1
numIters = 2^9*N*N;       %Number of steps for equilibration

for iter = 1 : numIters
    % Pick a random spin
    x = randi(N,1);
    y = randi(N,1);
    
    % Find its nearest neighbors with periodic boundary
    if y~=1; left=grid(x,y-1);else left=grid(x,N);end
    if y~=N; right=grid(x,y+1);else right=grid(x,1);end
    if x~=1; up=grid(x-1,y);else up=grid(N,y);end
    if x~=N; down=grid(x+1,y);else down=grid(1,y);end
    
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