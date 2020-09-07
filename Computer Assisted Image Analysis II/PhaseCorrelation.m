 function [c] = PhaseCorrelation(f,h)
    %%%
    %
    % Function to calculate the phase correlation between two images, f and
    % h
    %
    %%%
    fs = size(f);
    hs = size(h);
    t = (fs(1:2)-hs(1:2));
    tx = size(h, 2); % used for bbox placement
    ty = size(h, 1);
    h = padarray(h, t , 0, 'post');

    F = fft2(f);
    H = fft2(h);

    CrossPower = (F .* conj(H)) ./ abs(F .* H);
    c = real(ifft2(CrossPower));
 end