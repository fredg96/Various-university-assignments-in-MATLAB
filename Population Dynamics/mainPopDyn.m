%% 1.3.1.1
clear all
close all
p = 0.5;
b = [10 18];
n = [10 100 1000 5000];
steps = 100;
init_pop = 10;
n = 1000;
for i = 1:length(b)
    [state population] = popDyn11(n,b(i),p,init_pop,steps);
    pop1(i,:) = population
end    

figure
plot(1:1:steps, population)
%% 1.3.1.2
clear all
clc
b = [1:1:50];
n = 1000;
p = 0.5
steps = 50;
init_pop = 10;
reps = 5000;
max_pop = 10000
hrange=[0:1:max_pop];
histSq=zeros(length(b),length(hrange));
for i = 1:length(b)
    for j = 1:reps
        [state population] = popDyn11(n,b(i),p,init_pop,steps);
        finalSq(i,j)=population(end);
    end
     histSq(i,:)=hist(finalSq(i,:),hrange);
end
figure
imagesc(b,hrange,histSq'/reps,[0 0.01])

title('Phase transition for b')





%% 1.3.3
clear all
close all
n = 1000;
b = [1:1:50];
d = [1:1:n];
reps = 5;
p = 0.5;
steps = 100;
init_pop = 20;
for i = 1:length(b)
    for j = 1:length(d);
        for k = 1:reps
            [state population] = popDyn12(n,b(i),p,d(j),init_pop,steps); 
            pop(k) = population(end);
        end
        plotPop(i,j) = mean(pop);
        stab(i,j) = mean(pop-mean(pop)); 
    end
end


        


