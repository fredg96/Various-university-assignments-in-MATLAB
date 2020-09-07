function plotWave(u)
%Plot the solution u to FDM method for wave on a string

close all;
[nt,nx]=size(u);
figure

hold on;
for i = 3 : nt %Starting at third row of u, since the earlier one was fillled in by hand
    plot(u(i,:));
    axis([0 nx -0.1 0.1]); %Scale of axis, 0 nx is x-axis, -0.1 0.1 is amplitude on y-axis
    pause(0.000800); %in order to see each step
    hold off;
end

end