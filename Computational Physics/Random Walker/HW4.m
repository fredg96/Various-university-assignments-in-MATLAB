n = [1 5 10 15 25  35     60 65 75 100];
factor = [1 0.990 1.0017 1.003 0.9987 1.0007 0.9998 0.9973 1 1.0014]%100000 walks
 %           0.9983 0.9966 N = 11 error]
           %n = [4:10:104]
            %factor = zeros(1,length(n));
            %for i = 1:length(n)
             %   factor(i) = randwalk2(n(i),100000)
            %end
figure()
plot(n,factor,'*')
xlabel('N')
ylabel('Factor')