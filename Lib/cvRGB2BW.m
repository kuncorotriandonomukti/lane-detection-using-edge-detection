function x = cvRGB2BW(citra, t)
% c2bw Digunakan untuk mengonversi file
% Skala yang digunakan 0-255
% Masukkan :
%   C = Citra
%   T = Batas ambang
% Keluaran :
%   CB = Citra Biner

[b, k] = size(citra);
x = zeros(b, k);
for i = 1 : b
    for j = 1 : k
        if citra(i, j) >= t
            x(i, j) = 0;
        else
            x(i, j) = 1;
        end
    end
end
end