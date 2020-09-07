c = 300; %Number of colors 
N = 300; %Dimension of canvas
steps = 1100000000;
right = [2 3 4 1];
left = [4 1 2 3];

for l = 1:20
    grid = zeros(N,N);
    x = randi(N,1);
    y = randi(N,1);
    dir = randi(4,1);
    
    for i = 1:c
        rules(i) = round(rand());
    end
    %if all rules are 1 or 0 change one so that result is not single color
    %image
    if sum(rules) == c
        rules(randi(c,1)) = 0;
    elseif sum(rules) == 0
        rules(randi(c,1)) = 1;
    end

    for i = 1:steps
        k = mod(grid(x,y),c);
        grid(x,y) = mod(k+1,c);
        if(rules(k+1)==1)
            dir = right(dir);
        else
            dir = left(dir);
        end
        if(dir == 1)
            if( x == 1)
                x = N;
            else
                x = x-1;
            end
        elseif(dir == 2)
            if(y == N)
                y = 1;
            else
                y = y+1;
            end
        elseif(dir == 3)
            if(x == N)
                x = 1;
            else
                x = x+1;
            end
        else
            if(y == 1)
                y = N;
            else
             y = y-1;
            end
        end
    end
    figure()
    imagesc(grid)
end
