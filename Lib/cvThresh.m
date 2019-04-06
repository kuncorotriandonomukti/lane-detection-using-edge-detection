function [hasil] = cvThresh(citra, t)
% AMBANG Menentukan nilai ambang yang digunakan
% untuk melakukan pengambangan
% F = Citra berskala keabuan
% t = nilai ambang
%
% Keluaran: G = Citra biner
[b, k] = size(citra);
for i=1 : b
    for j=1:k
        if citra(i,j) <= t
            hasil(i,j) = 0;
        else
            hasil(i,j) = 1;
        end
    end
end