function [hasil] = cvTepiLog(citra, ukuran, sigma)
% Fungsi ini berfungsi untuk mendeteksi tepi objek pada citra
% menggunakan operator Marr-Hildreth
% Masukkan : 
%   citra = gambar berskalan abu
%   ukuran = ukuran untuk kernel LOG
%   sigma = sigma untuk kernel LOG
% Hasil: 
%    hasil = citra hasil deteksi tepi
if nargin < 2
    ukuran = 5;
end
if nargin < 2
    sigma = 0.6;
end
K = cvKernelLog(ukuran, sigma);
G = cvKorelasi(citra, K);

% Proses zero crossing
hasil = zeros(size(G));
[b, k] = size(hasil);
G = double(G);
for y = 2 : b-1
    for x = 2: k-1
        jum = 0;
        for i = x-1 : x
            for j = y-1 : y
                jum = jum + G(j,i);
            end
        end
        rerata0 = jum / 4;
        jum = 0;
        for i = x-1 : x
            for j = y : y+1
                jum = jum + G(j,i);
            end
        end
        rerata1 = jum / 4;
        jum = 0;
        for i = x : x+1
            for j = y-1 : y
                jum = jum + G(j,i);
            end
        end
        rerata2 = jum / 4;
        jum = 0;
        for i = x : x+1
            for j = y : y+1
                jum = jum + G(j,i);
            end
        end
        rerata3 = jum / 4;
        terbesar = max([rerata0 rerata1 rerata2 rerata3]);
        terkecil = min([rerata0 rerata1 rerata2 rerata3]);
        if (terbesar > 0) && (terkecil < 0)
            hasil(y,x) = 1;
        end
    end
end