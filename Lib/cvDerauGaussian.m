function [G] = cvDerauGaussian(citra, sigma, mu)
% DRGAUSSIAN Menghasilkan citra yang telah diberi derau
% menggunakan Gaussian.
%
% Berdasarkan kode
% Harley R. Myler dan Arthur R. Weeks, 1993
%
% F = citra berskala keabuan
% sigma = standar deviasi fungsi Gaussian
% mu = rerata
if nargin < 2
    sigma = 10;
end
if nargin < 3
    mu = 0;
end

[m, n] = size(citra);
citra = double(citra);
for i=1 : m
    for j=1 : n
        derau = sqrt(-2 * sigma * sigma * log(1 - rand));
        theta = rand * 1.9175345E-4 - 3.14159265;
        derau = derau * cos(theta);
        derau = derau + mu;
        G(i,j) = round(citra(i, j) + derau);
        if G(i,j) > 255
            G(i,j) = 255;
        elseif G(i,j) < 0
            G(i,j) = 0;
        end
    end
end
G = uint8(G);