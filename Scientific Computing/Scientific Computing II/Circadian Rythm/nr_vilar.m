function nr = nr_vilar( )% nr = nr_vilar()
%
% Stoichiometry matrix, nr, for the vilar oscillator.
% The variables (corresponding to the columns in nr) are ordered as:
%   A  C  D_A  D_A'  D_R  D_R'  M_A  M_R  R
%
% See page 21 (formula 20) in Hellander: Stochastic Simulation and 
% Monte Carlo Methods

nr = zeros(18,9);

nr(1,:) =   [ 0 0 1 -1 0 0 0 0 0];
nr(2,:) =   [-1 0 -1 1 0 0 0 0 0];
nr(3,:) =   [1 0 0 0 1 -1 0 0 0];
nr(4,:) =   [-1 0 0 0 -1 1 0 0 0];
nr(5,:) =   [0 0 0 0 0 0 0 1 0];
nr(6,:) =   [0 0 0 0 0 0 0 1 0];
nr(7,:) =   [0 0 0 0 0 0 0 -1 0];
nr(8,:) =   [0 0 0 0 0 0 1 0 0];
nr(9,:) =   [0 0 0 0 0 0 1 0 0];
nr(10,:) =  [0 0 0 0 0 0 -1 0 0];
nr(11,:) =  [0 0 0 0 0 0 0 0 1];
nr(12,:) =  [0 0 0 0 0 0 0 0 -1];
nr(13,:) =  [0 -1 0 0 0 0 0 0 1];
nr(14,:) =  [1 0 0 0 0 0 0 0 0];
nr(15,:) =  [1 0 0 0 0 0 0 0 0];
nr(16,:) =  [1 0 0 0 0 0 0 0 0];
nr(17,:) =  [-1 0 0 0 0 0 0 0 0];
nr(18,:) =  [-1 1 0 0 0 0 0 0 -1];
    
