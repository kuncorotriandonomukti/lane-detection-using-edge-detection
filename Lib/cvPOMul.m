function [hasil] = cvPOMul(x, y)
% Fungsi ini berguna seperti immultiply pada matlab
% Masukkan :
%   x = matriks yang akan dikali
%   y = pengali
% Hasil :
%   hasil = matriks hasil perkalian

[b,k,c] = size(x);
hasil = zeros(b,k);
if c ~= 1
    disp('Citra harus dalam skala abu.')
    return;
end
if nargin < 2
    error('Masukkan nilai pengali.')
    return;
end

for i = 1:b
    for j = 1:k
        hasil(i,j) = x(i,j)*y;
    end
end