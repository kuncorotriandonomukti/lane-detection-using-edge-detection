function [hasil] = cvGraythresh(citra)
% graythresh Menentukan nilai ambang yang digunakan
% untuk melakukan pengambangan
% F = Citra berskala keabuan
% Keluaran: G = Citra biner
[m, n] = size(citra);
citra = double(citra);
t0 = 127;
while true
    rata_kiri = 0;
    rata_kanan = 0;
    jum_kiri = 0;
    jum_kanan = 0;
    for i=1 : m
        for j=1 : n
            if citra(i, j) <= 127
                rata_kiri = rata_kiri + citra(i,j);
                jum_kiri = jum_kiri + 1;
            else
                rata_kanan = rata_kanan + citra(i,j);
                jum_kanan = jum_kanan + 1;
            end
        end
    end
    rata_kiri = rata_kiri / jum_kiri;
    rata_kanan = rata_kanan / jum_kanan;
    hasil = (rata_kiri + rata_kanan) / 2.0;
    if (t0 - hasil) < 1
        break; % Keluar dari while
    end
    t0 = hasil;
end
hasil = floor(hasil);