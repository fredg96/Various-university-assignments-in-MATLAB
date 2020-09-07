function [state, ret_pop] = popDyn12(n,b,p,d,init_pop,steps)
state = zeros(steps,n);
test_state = state; 
pop = init_pop;
mean_val = b*p;
standard_dev = sqrt(b*p*(1-p));
dir = [-1 1];
for i = 1:steps
    temp_state = zeros(1,n);
    if i == 1
        for j = 1:pop
            place = round(rand*(n-1))+1;
            temp_state(place) = temp_state(place) + 1;
        end
    else 
        for j = 1:n
            if state(i-1,j) ~= 0
                number = state(i-1,j);
                for k = 0:number
                    place = j+round((dir(round(rand)+1))*rand*d);
                    if place < 1
                        place = n + place;
                    elseif place > n
                        place = place - n;
                    end
                    temp_state(place) = temp_state(place)+1; 
                end
            end
        end
        test_state(i,:) = temp_state;
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




