clear all
close all
N = 150; %Dimension of canvas
grid = zeros(N,N);
steps = 11000;
right = [2 3 4 1];
left = [4 1 2 3];
x = randi(N,1);
y = randi(N,1);
dir = randi(4,1);
for i = 0:steps
    if(grid(x,y) == 0)
        grid(x,y) = 1;
        dir = right(dir);
    else
        grid(x,y) = 0;
        dir = left(dir);
    end
    %To create continous boundary i.e when stepping over from 1 we get to N
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
colormap('gray')
imagesc(imcomplement(grid))
    