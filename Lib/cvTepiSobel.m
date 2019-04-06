function [hasil] = cvTepiSobel(citra)
% Fungsi ini digunakan untuk mendapatkan tepi pada citra mengugnakan
% Operator sobel
% Masukkan :
%   citra = citra yang akan diolah
% Keluaran :
%   hasil = hasil deteksi tepi

% Deklarasi kernel pada gradien X dan Y
Gx = [1 +2 +1; 0 0 0; -1 -2 -1]; 
Gy = Gx';

temp_x = imfilter(citra, Gx,'corr');
temp_y = imfilter(citra, Gy,'corr');
hasil = sqrt(temp_x.^2 + temp_y.^2);