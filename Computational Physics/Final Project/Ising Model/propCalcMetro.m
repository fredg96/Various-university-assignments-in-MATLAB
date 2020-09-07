function [Ms,Es,xs,Cs, Cum] = propCalcMetro(N,T,J,L,grid,B)
Mmean=zeros(1,L);
Emean=zeros(1,L);
for iter = 1 : L
    % Pick a random spin

x = randi(N,1);
y = randi(N,1);
    
    % Find its nearest neighbors
    if y~=1; left=grid(x,y-1);else left=grid(x,N);end
    if y~=N; right=grid(x,y+1);else right=grid(x,1);end
    if x~=1; up=grid(x-1,y);else up=grid(N,y);end
    if x~=N; down=grid(x+1,y);else down=grid(1,y);end
    
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
    + circshift(grid, [-1  0]);
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