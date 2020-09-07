template = rgb2gray(im2double(imread('template1.png')));
search = rgb2gray(im2double(imread('search.png')));

c = PhaseCorrelation(search, template);
absc = abs(c);

%find peak correlation
[max_c, imax] = max(absc(:));
[ypeak, xpeak] = find(absc == max_c);

tx = size(template, 2); % used for bbox placement
ty = size(template, 1);
figure;

hAx = axes;
imshow(search);

position = [xpeak(1) ypeak(1) tx ty]
h = drawrectangle('Position',position, 'StripeColor','r');
