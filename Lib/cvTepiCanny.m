function [hasil] = cvTepiCanny(citra, t1, t2)
% Fungsi ini digunakan untuk memerolehan tepi objek
% pada citra melalui operator Canny
% Masukkan:
%   t1 = batas bawah untuk ambang histeresis
%   Nilai bawaan 011
%   t2 = batas atas untuk ambang histeresis
%   Nilai bawaan 0,3
% Hasil:
%   hasil = Hasil deteksi tepi Canny

% Menentukan nilai ambang bawaan
if nargin < 2
    t1 = 0.05;
end
if nargin < 2
    t2 = 0.15;
end

% Kernel Gaussians
K = cvKernelGaussian(5,1.4);
[bK, kK] = size(K);
h2 = floor(bK / 2);
w2 = floor(kK / 2);

% Kenakan operasi Gaussian
G = double(cvKorelasi(citra, K));

% Pastikan hasilnya berada antara 0 sampai dengan 255
G = uint8(G);
[m, n] = size(G);
G = double(G);

% Kenakan perhitungan gradien dan arah tepi
Theta = zeros(m, n);
Grad = zeros(m, n);
for i = 1 : m-1
    for j = 1 : n-1
        gx = (G(i,j+1)-G(i,j) + ...
            G(i+1,j+1)-G(i+1,j)) / 2;
        gy = (G(i,j)-G(i+1,j) + ...
            G(i,j+1)-G(i+1,j+1)) / 2;
        Grad(i, j) = sqrt(gx.^2 + gy.^2);
        Theta(i,j) = atan2(gy, gx);
    end
end

% Konversi arah tepi menjadi 0, 45, 90, atau 135 derajat
[r c] = size (Theta);
if Theta < 0
    Theta = Theta + pi; % Jangkauan menjadi 0 s/d pi
end
for i = 1 : r
    for j = 1 : c
        if (Theta(i,j) < pi/8 || Theta(i,j) >= 7/8*pi)
            Theta(i,j) = 0;
        elseif (Theta(i,j)>=pi/8 && Theta(i,j) < 3*pi/8 )
            Theta(i,j) = 45;
        elseif (Theta(i,j) >=3*pi/8 && Theta(i,j) < 5*pi/8 )
            Theta(i,j) = 90;
        else
            Theta(i,j) = 135;
        end
    end
end

% penghilangan non-maksimum
Non_max = Grad;
for i = 1+h2 : r-h2
    for j = 1+w2 : c-h2
        if Theta(i,j) == 0
            if (Grad(i,j) <= Grad(i,j+1)) || ...
                    (Grad(i,j)<= Grad(i,j-1))
                Non_max(i,j) = 0;
            end
        elseif Theta(i,j) == 45
            if (Grad(i,j) <= Grad(i-1,j+1)) || ...
                    (Grad(i,j) <= Grad(i+1,j-1))
                Non_max(i,j) = 0;
            end
        elseif Theta(i,j) == 90
            if (Grad(i,j) <= Grad(i+1,j) ) || ...
                    (Grad(i,j) <= Grad(i-1,j))
                Non_max(i,j) = 0;
            end
        else
            if (Grad(i,j) <= Grad(i+1,j+1)) || ...
                    (Grad(i,j) <= Grad(i-1,j-1))
                Non_max(i,j) = 0;
            end
        end
    end
end

% Pengambangan histeresis
t1 = t1 * max(max(Non_max)); %t1 * nilai tertinggi
t2 = t2 * max(max(Non_max)); %t2 * nilai tertinggi
Histeresis = Non_max;
% ----- Penentuan awal untuk memberikan nilai
% ----- 0, 128, dan 255
for i = 1+h2 : r-h2
    for j = 1+w2 : c-w2
        if (Histeresis(i,j) >= t2)
            Histeresis(i,j) = 255;
        end
        if (Histeresis(i,j) < t2) && (Histeresis(i,j) >= t1)
            Histeresis(i,j)= 128;
        end
        if (Histeresis(i,j) < t1)
            Histeresis(i,j) = 0;
        end
    end
end

% ----- Penggantian angka 128 menjadi 255
% ----- Berakhir kalau tidak ada lagi yang berubah
ulang = true;
while ulang
    ulang = false;
    for i = 1+h2 : r-h2
        for j = 1+w2 : c-w2
            if (Histeresis(i,j) == 128)
                if (Histeresis(i-1, j-1) == 255) && ...
                        (Histeresis(i-1, j) == 255) && ...
                        (Histeresis(i, j+1) == 255) && ...
                        (Histeresis(i, j-1) == 255) && ...
                        (Histeresis(i, j+1) == 255) && ...
                        (Histeresis(i+1, j-1) == 255) && ...
                        (Histeresis(i+1, j) == 255) && ...
                        (Histeresis(i+1, j+1) == 255)
                    Histeresis(i,j) = 255;
                    ulang = true; % Ulang pengujian
                end
            end
        end
    end
end

% ----- Penggantian angka 128 menjadi 0
% ----- untuk yang tersisa
for i = 1+h2 : r-h2
    for j = 1+w2 : c-w2
        if (Histeresis(i,j) == 128)
            Histeresis(i,j) = 0;
        end
    end
end

% Buang tepi
for i = 1+h2 : r-h2
    for j = 1+w2 : c-w2
        hasil(i-1,j-1) = Histeresis(i,j);
    end
end