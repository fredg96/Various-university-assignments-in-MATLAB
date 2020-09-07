function [Ms,Es,xs,Cs, Cum] = propCalcMetro2nd(N,T,J,L,grid,B)
Mmean=zeros(1,L);
Emean=zeros(1,L);
for iter = 1 : L
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
    dE = 2 * (J * grid(x, y) * neighbors+(grid.*B));
    
    % Spin flip condition
    if dE <= 0
        grid(x, y) = - grid(x, y);
    else
        prob = exp(-dE / T);          % Boltzmann probability of flipping
        if rand(1) <= prob
        grid(x, y) = - grid(x, y);
        end
    end
    
%calculating magnetisation per spin
Mmean(1,iter) = abs(mean(grid(:))/numel(N));

%calculating energy per spin
sumOfNeighbors = ...
      circshift(grid, [ 0  1]) ...
    + circshift(grid, [ 0 -1]) ...
    + circshift(grid, [ 1  0]) ...
    + circshift(grid, [-1  0]) ...
    - circshift(grid, [0  2]) ...
    - circshift(grid, [0  -2]) ...
    - circshift(grid, [2  0]) ...
    - circshift(grid, [-2  0]) ;
Em = - J * grid .* sumOfNeighbors-B*grid;
E  = 0.5 * sum(Em(:));
Emean(1,iter) = E / numel(grid);



end

Ms=mean(Mmean);% Ms is a scalar with average of all the elements in array Mag_avg;
Es=mean(Emean); % Es is a scalar with average of all the elements in array Energy_avg;
xs=(mean(Mmean.^2)-mean(Mmean)^2)/T;
Cs=(mean(Emean.^2)-mean(Emean)^2)/T^2;
Cum = 1-((mean(Mmean.^4)/(3*mean(Mmean.^2)^2)));
end