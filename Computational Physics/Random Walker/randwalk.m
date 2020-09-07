%Home exercise 4
%N = length of the random walk.
%M = amount of random walks made. Do a lot to get a good average, test about 100 to 100000 

function z = randwalk(N,M)
x_t = zeros(N+1,1);
y_t = zeros(N+1,1);
Rsquare = zeros(N+1,1);
%% Loops through all M random walks. Then per random walk do all the N steps to make one random walk

for m=1:M
    
  for n = 1:N % Looping all values of N into x_t(n) and y_t(n)
    A = sign(randn); % Generates either +1 or -1 
    x_t(n+1) = x_t(n) + A;
    A = sign(randn); % Generates either +1 or -1 
    y_t(n+1) = y_t(n) + A;
  end
  
  x_t(1) = 0; %resets element 1 to 0, so that next random walk starts at origin
  y_t(1) = 0; %resets element 1 to 0, so that next random walk starts at origin
  Rsquare(m) = x_t(N+1)^2 + y_t(N+1)^2;
  
  %% Plot all the random walks in one figure to illustrate how they look
  %plot(x_t, y_t);
  %hold on
  %grid on;
  %Enlarge figure to full screen.
  %set(gcf, 'Units', 'Normalized', 'Outerposition', [0, 0.05, 1, 0.95]);
  %axis square;
end

%% Calculate the values and information that are of interest
dist = sqrt(mean(Rsquare)) % sqrt(<R^2>)
sqrtN = sqrt(N) 
factor = dist/sqrtN %factor that comes from sqrt(N)/sqrt(<R^2>)
z = factor;
end
