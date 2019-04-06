function [hasil] = cvKonvolusi(citra,kernel)
% Fungsi ini seperti function conv2 'valid' atau mengabaikan border
% Masukkan :
%   citra : citra yang akan diolah
%   kernel : kernel yang akan dikonvolusikan
% Keluaran :
%   hasil : hasil konvolusi

% Menentukan ukuran B x K Citra dan Kernel
[bc,kc] = size(citra);
[bk,kk] = size(kernel);

% Memastikan kernel berukuran Ganjil
if rem(kk,2) == 0 || rem(bk,2) == 0
    disp('Lebar dan tinggi K harus ganjil');
    return;
end

ty = floor(bk/2);
tx = floor(kk/2);

% Mengisi sisi citra dengan Zero Padding
CB = zeros(bc+2,kc+2);
CB(2:end-1,2:end-1) = citra;
CB = double(CB);

% Menentukan ukuran B x K Citra dengan Zero Padding
[b, k] = size(CB);

% Menyiaplan Citra hasil dan menghapus Zero Padding
hasil = zeros(b - 2 * tx, k - 2 * ty);

for y = ty + 1 : b - ty
    for x = tx + 1 : k - tx
        jum = 0;
        for p = -ty : ty
            for q = -tx : tx
                jum = jum + kernel (p + ty + 1,q + tx + 1) * CB(y - p,x - q);
            end
        end
        hasil(y - ty,x - tx) = jum;
    end
end

hasil = uint8(hasil);