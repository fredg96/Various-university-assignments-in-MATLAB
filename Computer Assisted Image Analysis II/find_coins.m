image = im2double(imread('coins.png'));
imshow(image)
edges = edge(image,'canny',[0.18 0.65], 1);
imshow(image+edges)
%%
s = size(image);
radii = 20:0.1:35; %Look for radii between 20 and 35 with steps 0.1 limit to speed up algorithm
accumulator = zeros(s(1),s(2),length(radii)); %matrix to store counts
for x = 1:s(1) %For dimension 1
    for y = 1:s(2) %For dimension 2
        if edges(x,y) == 1 %If canny edge detector found an edge
            for rID = 1:length(radii) %For each radii
                r = radii(rID); 
                for theta = 0:360 %PErform circular hough transform
                    a = round(x-r*cos(theta*pi/180));
                    b = round(y-r*sin(theta*pi/180));
                    if a>0 && b>0 && a<s(1) && b<s(2)
                        accumulator(a,b,rID) = accumulator(a,b,rID)+1;
                    end
                end
            end
        end
    end
end
maximum = zeros(length(radii),1); 
for r = 1:length(radii)
    maximum(r) = max(max(accumulator(:,:,r)));
end

[mm, idxs] = findpeaks(maximum, 'SortStr', 'descend', 'MinPeakWidth', 5);
figure(2);
imshow(image);
title('Coins and radii found')
hold on
for i=1:numel(idxs) % limit the number of maxima, we only want to find two coin sizes
   idx = idxs(i);
   % expand the peaks with a large dilate
   base = accumulator(:,:,idx);
   dse = strel('disk', 10);
   im = imdilate(base, dse);
   rad = 0.1 * idx + 20;
   for x=1:size(im,1)
       for y=1:size(im,2)
           % if the im(x,y) was unchanged from the dilate, 
           % it's the center of a circle!
           if im(x,y) == base(x,y) && im(x,y) > 150
               % rad+1 to compansate for the width of the circle stroke
               viscircles([y,x], rad+1, 'Color', 'w');
               text(y,x, num2str(rad), ...
                    'Color', 'black', 'HorizontalAlignment', 'center');
           end
       end
   end
end
hold off
