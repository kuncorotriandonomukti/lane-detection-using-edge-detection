function [hasil] = cvKernelGaussian(ukuran, sigma)
% Fungsi ini menghasilkan kernel Gaussian
% Masukkan : 
%   ukuran = ukuran kernel yang akan dibuat
%   sigma = standar deviasi
% Keluaran : 
%   hasil = kernel gaussian
tx = (ukuran+1)/2;
ty = tx;
g=zeros(ukuran,ukuran);
for i = -(ukuran-1)/2:(ukuran-1)/2
    for j = -(ukuran-1)/2:(ukuran-1)/2
        x = i + tx; %baris
        y = j + ty; %kolom
        %Persamaan Gaussian
        g(y,x) = exp(-((x-tx)^2+(y-ty)^2)/2/sigma/sigma); 
    end
end
% Normalisasi Gaussian Filter
pembilang = (sum(sum(g)));
hasil = g/pembilang;
end