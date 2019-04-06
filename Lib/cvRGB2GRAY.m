function hasil = cvRGB2GRAY(citra,nr,ng,nb)
% rgb2g melakukan proses konversi citra RGB ke Grayscale
% Masukkan :
%   C = Citra yang akan diolah
%   nr = Nilai bobot untuk merah, Bawaan 0.2989
%   ng = Nilai bobot untuk hijau, Bawaan = 0.5870
%   nb = Nilai bobot untuk biru, Bawaan = 0.1140
% Keluaran :
%   CG = Citra Grayscale

if nargin < 2
    nr = 0;
    ng = 0;
    nb = 0;
end

[baris,kolom,c] = size(citra);
if c<3
    disp('! Citra sudah dalam skala Abu')
    hasil = uint8(citra);
else
    % Mempersiapkan proses rgb2g
    R = double(citra(:,:,1)); % Channel warna Merah
    G = double(citra(:,:,2)); % Channel warna Hijau
    B = double(citra(:,:,3)); % Channe; warna Biru
    
    for b = 1:baris
        for k = 1:kolom
            if (nr ~= 0) && (ng~= 0) && (nb~=0)
                % metode 1. Bobot tergantung pengguna
                hasil(b,k) = (nr * R(b,k) + ng * G(b,k) + nb * B(b,k));
            else
                % metode 2
                % Rumus berdasarkan kebanyakan Imager processor pada aplikasi
                % (0.2989 * R + 0.5870 * G + 0.1140 * B)/3
                hasil(b,k)= (0.2989 * R(b,k) + 0.5870 * G(b,k) + 0.1140 * B(b,k));
            end
        end
        hasil = uint8(hasil);
    end
end
