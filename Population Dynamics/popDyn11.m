function [state ret_pop] = popDyn11(n,b,p,init_pop,steps)
state = zeros(steps,n);
pop = init_pop;
ret_pop = zeros(1,steps);
mean_val = b*p;
standard_dev = sqrt(b*p*(1-p));
ent = 0;
    for i = 1:steps
        temp_state = zeros(1,n);
        if i == 1
            for j = 1:pop
                place = round(rand*(n-1))+1;
                temp_state(place) = temp_state(place) + 1;
            end
        else 
            for j = 1:pop
                place = round(rand*(n-1))+1;
                temp_state(place) = temp_state(place) + 1;
            end
            for j = 1:n
                if temp_state(j) == 1
                    temp_state(j) = round(standard_dev*randn()+mean_val);
                else
                    temp_state(j) = 0;
                end
            end
        end
        pop = sum(temp_state);
        ret_pop(1,i) = pop;
        state(i,:) = temp_state;
    end
  

end

