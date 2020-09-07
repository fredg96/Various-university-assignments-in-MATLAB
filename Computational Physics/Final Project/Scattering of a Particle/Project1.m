%Project 1
%Numerical and analytical solution

close all;
clear all;

%% Define varialbes and parameters
N = 500 ; %could take less integration points, but 500 gives a really nice resolution
rmax = 1 ;
b = linspace( 0 , rmax , N);
E = 1 ; %set as constant E = 1 
theta = zeros(length(b),1);
analyticsol = zeros(length(b),1);

%take one of the V vectors below, to observe when V<0 |E|>|V|, V<0
%|V|>|E|, V>0 E > V, V>0 E < V

%V = -[ 0.01 0.10 0.5 0.95 0.99 0.9999 ]; % V<0 |E|>|V|
%V = -[1.1 5 10 50 100]; % V<0 |V|>|E|
V = [ 0.01 0.10 0.5 0.95 0.99 0.9999 ]; % V>0 E > V
%V = [1.1 5 10 50 100 150]; % V>0 E < V

%% Numerical solution 

for i=1:length(V)

for j =1:length(b)

rmin = b(j) /sqrt(1 - (V( i )/E)) ; %rmin, comes from analytical solution

integral1 = @( x ) 1/((x^2 + b(j))*(sqrt(x^2 + 2*b(j)))) ;
integral2 = @( x ) 1/((x^2 + b(j))*(sqrt(x^2 + 2*b(j)))) ;

rtop1 = sqrt(rmax-b(j));
rlow1 = 0;
rtop2 = sqrt((sqrt(1-(V(i)/E))*rmax) - b(j));
rlow2 = sqrt((sqrt(1-(V(i)/E))*rmin) - b(j));

integral1 = boole( integral1 , rlow1 , rtop1 , N) ;
integral2 = boole( integral2 ,rlow2, rtop2 , N) ;

theta(j) = 4*b(j)*real( integral1 - integral2 ) ;

end
plotTheta(i,:) = theta;

figure(1);
plot(b/rmax , theta );
hold on ;

end
title (' Numerical solution square well , E>V_0 ' ) ;
xlabel ( 'b/ r_{max} ' ) ;
ylabel(' Scattering angle (rad)' );
legend ( 'V/E = 0.01 ' , 'V/E = 0.1 ' , 'V/E = 0.5 ' , 'V/E = 0.95 ',' V/E = 0.99 ' , ' V/E = 0.9999 ') ;

%% Analytical solution

for i=1:length(V)

for j =1:length(b)

rmin = b(j) / sqrt (1 - (V(i)/E));

figure(2);
x1 = b(j) / rmax ;
x2 = b(j) / rmin ;
analyticsol(j) = - 2*real( ( ( asin( x1 )- asin( 1 ) ) - asin(x1/ sqrt(1 - (V(i)/E)) ) + asin( x2/ sqrt(1 - (V(i)/E)) ) ) ) ;
end
plotAnalytic(i,:) = analyticsol;
plot (b/rmax , analyticsol ) ;
hold on
end
title (' Analytical solution square well , E>V_0 ' ) ;
ylabel( ' Scattering angle ( rad ) ' ) ;
xlabel ( 'b/ r_{max} ' ) ;
legend ( 'V/E = 0.01 ' , 'V/E = 0.1 ' , 'V/E = 0.5 ' , 'V/E = 0.95 ',' V/E = 0.99 ' , ' V/E = 0.9999 ') ;

figure(3)
plot(b/rmax, plotAnalytic-plotTheta)

ylabel('Error')
xlabel('b/r_{max}')
legend ( 'V/E = 0.01 ' , 'V/E = 0.1 ' , 'V/E = 0.5 ' , 'V/E = 0.95 ',' V/E = 0.99 ' , ' V/E = 0.9999 ') ;

