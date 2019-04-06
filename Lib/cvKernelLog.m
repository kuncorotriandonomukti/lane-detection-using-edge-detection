function [hasil] = cvKernelLog(ukuran, sigma)
% Fungsi ini menghasilkan kernel LoG berdasarkan Nixon dan Aguido (2002)
% Masukan:
%   ukuran : ukuran cadar
%   sigma : Deviasi standar
% Keluaran : 
%   hasil = kernel LoG
tx = floor(ukuran/2);
ty = tx;
jum = 0;
hasil = zeros(ukuran, ukuran);
for y=0 : ukuran-1
    for x=0 : ukuran-1
        nx = x - tx;
        ny = y - ty;
        nilai = 1 / (sigma ^ 2) * ...
            ((nx^2 + ny^2)/(sigma^2)-2) * ...
            exp((-nx^2 - ny^2) / (2 * sigma^2));
        hasil(y+1, x+1) = nilai;
        jum = jum + nilai;
    end
end
figure,
plot(hasil)