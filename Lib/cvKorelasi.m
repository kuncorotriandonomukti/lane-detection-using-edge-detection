function [hasil] = cvKorelasi(citra, kernel)
% Fungsi ini melakukan operasi korelasi kernel dengan citra seperti corl2
% Masukkan :
%   citra : gambar yang akan diolah
%   kernel : kernel yang akan di korelasikan
% Hasil: 
%   hasil : citra hasil korelasi

% Menentukan ukuran B x K Citra dan Kernel
[cb, ck] = size(citra);
[kb, kk] = size(kernel);

% Memastikan kernel berukuran Ganjil
if rem(kk,2) == 0 || rem(kb,2) == 0
    disp('Lebar dan tinggi K harus ganjil');
    return;
end

% Mencari koordinat X,Y (Titik Tengah) pada kernel
tx = floor(kb/2);
ty = floor(kk/2);

% Mengisi sisi citra dengan Zero Padding
CB = zeros(cb+2,ck+2);
CB(2:end-1,2:end-1) = citra;
CB = double(CB);

% Menentukan ukuran B x K Citra dengan Zero Padding
[b, k] = size(CB);

% Menyiaplan Citra hasil dan menghapus Zero Padding
hasil = zeros(b - 2 * tx, k - 2 * ty);

% Perhitungan Korelasi
for y = tx+1 : b-tx
    for x = ty+1 : k-ty
        jum = 0;
        for i = -tx : tx
            for j = -ty : ty
                jum = jum + kernel(i+tx+1,j+ty+1) * CB(y+i, x+j);
            end
        end
        hasil(y - tx, x - ty) = jum;
    end
end

% hasil = uint8(hasil);