function [S B R] = memeSpreadGrid(R0,S0,B0,N,p,q,r,steps)

%%Modeling spread of memes on grid with periodic boundary
% 0-Resting, 1-Spreading, -1-Boring
dim = sqrt(N);
population = zeros(dim,dim);


for i = 1:S0
    x = randi(dim,1);
    y = randi(dim,1);
    if population(x,y) ~= 0
        while population(x,y) ~= 0
            x = randi(dim,1);
            y = randi(dim,1);
        end
    end
    population(x,y) = 1;
    s_pos(:,i) =[x;y];
end
for i = 1:B0
    x = randi(dim,1);
    y = randi(dim,1);
    if population(x,y) ~= 0
        while population(x,y) ~= 0
            x = randi(dim,1);
            y = randi(dim,1);
        end
    end
    population(x,y) = -1;
    b_pos(:,i) = [x;y];
end
dir = [-1 1];
R = zeros(1,steps);
B = zeros(1,steps);
S = zeros(1,steps);
R(1) = R0;
S(1) = S0;
B(1) = B0;

for i = 1:steps-1
    k = 1;
    R(i+1) = R(i);
    S(i+1) = S(i);
    B(i+1) = B(i);
    for j = 1:S(i)
        if q > rand() %Will sharer interact
            direction = round((dir(round(rand)+1)));
            if rand()<0.5 %x direction
                if s_pos(1,k) == 1 & direction == -1
                    if population(dim, s_pos(2,k)) == 0
                        population(dim, s_pos(2,k)) = 1;
                        S(i+1) = S(i+1)+1;
                        R(i+1) = R(i+1)-1;
                        s_pos = [s_pos, [dim;s_pos(2,k)]];
                        k = k+1;
                    elseif population(dim, s_pos(2,k)) == -1
                        population(1, s_pos(2,k)) = -1;
                        S(i+1) = S(i+1)-1;
                        B(i+1) = B(i+1)+1;
                        b_pos = [b_pos,[1;s_pos(2,k)]];

                        s_pos(:,k) = [];
                    else
                        k = k+1;
                    end
                elseif s_pos(1,k) == dim & direction == 1
                    if population(1, s_pos(2,k)) == 0
                        population(1, s_pos(2,k)) = 1;
                        S(i+1) = S(i+1)+1;
                        R(i+1) = R(i+1)-1;
                        s_pos = [s_pos, [1;s_pos(2,k)]];
                        k = k+1;
                    elseif population(1, s_pos(2,k)) == -1
                        population(dim, s_pos(2,k)) = -1;
                        S(i+1) = S(i+1)-1;
                        B(i+1) = B(i+1)+1;
                        b_pos = [b_pos,[dim;s_pos(2,k)]];
                        s_pos(:,k) = [];
                        
                    else
                        k = k+1;
                    end
                else
                    if population(s_pos(1,k)+direction, s_pos(2,k)) == 0
                        population(s_pos(1,k)+direction, s_pos(2,k)) = 1;
                        S(i+1) = S(i+1)+1;
                        R(i+1) = R(i+1)-1;
                        s_pos = [s_pos, [s_pos(1,k)+direction;s_pos(2,k)]];
                        k = k+1;
                    elseif population(s_pos(1,k)+direction, s_pos(2,k)) == -1
                        population(s_pos(1,k), s_pos(2,k)) = -1;
                        S(i+1) = S(i+1)-1;
                        B(i+1) = B(i+1)+1;
                        b_pos = [b_pos, [s_pos(1,k); s_pos(2,k)]];

                        s_pos(:,k) = [];
                    else
                        k = k+1;
                    end
                end
            else %y-position
                if s_pos(2,k) == 1 & direction == -1
                    if population(s_pos(1,k),dim) == 0
                        population(s_pos(1,k),dim) = 1;
                        S(i+1) = S(i+1)+1;
                        R(i+1) = R(i+1)-1;
                        s_pos = [s_pos, [s_pos(1,k);dim]];
                        k = k+1;
                    elseif population(s_pos(1,k),dim) == -1
                        population(s_pos(1,k),1) = -1;
                        S(i+1) = S(i+1)-1;
                        B(i+1) = B(i+1)+1;
                        b_pos = [b_pos,[s_pos(1,k);1]];

                        s_pos(:,k) = [];
                    else
                        k = k+1;
                    end
                elseif s_pos(2,k) == dim & direction == 1
                    if population(s_pos(1,k),1) == 0
                        population(s_pos(1,k),1) = 1;
                        S(i+1) = S(i+1)+1;
                        R(i+1) = R(i+1)-1;
                        s_pos = [s_pos, [s_pos(1,k);1]];
                        k = k+1;
                    elseif population(s_pos(1,k),1) == -1
                        population(s_pos(1,k),dim) = -1;
                        S(i+1) = S(i+1)-1;
                        B(i+1) = B(i+1)+1;
                        b_pos = [b_pos,[s_pos(1,k);dim]];

                        s_pos(:,k) = [];
                    else
                        k = k+1;
                    end
                else
                    if population(s_pos(1,k), s_pos(2,k)+direction) == 0
                        population(s_pos(1,k), s_pos(2,k)+direction) = 1;
                        S(i+1) = S(i+1)+1;
                        R(i+1) = R(i+1)-1;
                        s_pos = [s_pos, [s_pos(1,k);s_pos(2,k)+direction]];
                        k = k + 1;
                    elseif population(s_pos(1,k), s_pos(2,k)+direction) == -1
                        population(s_pos(1,k), s_pos(2,k)) = -1;
                        S(i+1) = S(i+1)-1;
                        B(i+1) = B(i+1)+1;
                        b_pos = [b_pos,[s_pos(1,k);s_pos(2,k)]];

                        s_pos(:,k) = [];
                    else
                        k = k+1;
                    end
                end
            end                
        end
    end
    for j = 1:R(i)
        if rand()< p
            S(i+1) = S(i+1)+1;
            R(i+1) = R(i+1)-1;
            while population(x,y) ~= 0
                x = randi(dim,1);
                y = randi(dim,1);
            end
            population(x,y) = 1;
            s_pos = [s_pos,[x;y]];
        end
    end
    k = 1;
    for j = 1:B(i)
        if rand()< r %Boring interacts
            direction = round((dir(round(rand)+1)));
            if rand()<0.5 %x direction
                if b_pos(1,k) == 1 & direction == -1
                    if population(dim, b_pos(2,k)) == 0
                        population(1, b_pos(2,k)) = 0;
                        R(i+1) = R(i+1)+1;
                        B(i+1) = B(i+1)-1;
                        b_pos(:,k) = [];
                    else
                        k = k+1;
                    end
                elseif b_pos(1,k) == dim & direction == 1
                    if population(1, b_pos(2,k)) == 0
                        population(dim, b_pos(2,k)) = 0;
                        R(i+1) = R(i+1)+1;
                        B(i+1) = B(i+1)-1;
                        b_pos(:,k) = [];
                    else
                        k = k+1;
                    end
                else
                    if population(b_pos(1,k)+direction, b_pos(2,k)) == 0
                        population(b_pos(1,k)+direction, b_pos(2,k)) = 0;
                        R(i+1) = R(i+1)+1;
                        B(i+1) = B(i+1)-1;
                        b_pos(:,k) = [];
                    else 
                        k = k+1;
                    end
                end
            else %y-position
                if b_pos(2,k) == 1 & direction == -1
                    if population(b_pos(1,k),dim) == 0
                        population(b_pos(1,k),dim) = 0;
                        R(i+1) = R(i+1)+1;
                        B(i+1) = B(i+1)-1;
                        b_pos(:,k) = [];
                    else
                        k = k+1;
                    end
                elseif b_pos(2,k) == dim & direction == 1
                    if population(b_pos(1,k),1) == 0
                        population(b_pos(1,k),1) = 0;
                        R(i+1) = R(i+1)+1;
                        B(i+1) = B(i+1)-1;
                        b_pos(:,k) = [];
                    else
                        k = k+1;
                    end
                else
                    if population(b_pos(1,k), b_pos(2,k)+direction) == 0
                        population(b_pos(1,k), b_pos(2,k)+direction) = 0;
                        R(i+1) = R(i+1)+1;
                        B(i+1) = B(i+1)-1;
                        b_pos(:,k) = [];
                    else
                        k = k+1;
                    end
                end
            end     
        end
    end
    if i == 1
        figure()
        imagesc(population)
        title('Start')
    elseif i == steps/10
            figure()
        imagesc(population)
        title('steps/10')
    elseif i == 2*steps/10
            figure()
        imagesc(population)
        title('2*steps/10')
    elseif i == 3*steps/10
            figure()
        imagesc(population)
        title('3*steps/10')
    elseif i == 4*steps/10
            figure()
        imagesc(population)
        title('4*steps/10')
    elseif i == 5*steps/10
            figure()
        imagesc(population)
        title('5*steps/10')
    elseif i == 6*steps/10
            figure()
        imagesc(population)
        title('6*steps/10')
    elseif i == 7*steps/10
            figure()
        imagesc(population)
        title('7*steps/10')
    elseif i == 8*steps/10
            figure()
        imagesc(population)
        title('8*steps/10')
    elseif i == 9*steps/10
            figure()
        imagesc(population)
        title('9*steps/10')
    elseif i == steps-1
        figure
        imagesc(population)
        title('Population at end')
    end
      
end
end

