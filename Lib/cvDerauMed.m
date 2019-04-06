function [hasil] = cvDerauMed(citra, ukuran)
% Fungsi ini melakukan penghilangan derau dengan menggunakan filter median.
% Masukkan :
%   citra = Citra berskala keabuan
%   ukuran = ukuran jendela
% Keluaran :
%   hasil = Citra hasil pemrosesan
if nargin < 2
    ukuran = 3;
end
[m, n] = size(citra);
setengah = floor(ukuran / 2);
citra = double(citra);
hasil = zeros(m-2*setengah, n-2*setengah);
Nilai = zeros(1,ukuran * ukuran);
for i=1+setengah : m-setengah
    for j=1+setengah: n-setengah
        indeks = 1;
        for p = -setengah : setengah
            for q = -setengah : setengah
                Nilai(indeks) = citra(i+p, j+q);
                indeks = indeks + 1;
            end
        end
        indeks = indeks - 1; % jumlah data
        % Urutkan data pada array Nilai
        for p = 2: indeks
            x = Nilai(p);
            % Sisipkan x ke dalam data[1..p-1]
            q = p - 1;
            ketemu = 0;
            while ((q >= 1) && (~ketemu))
                if (x < Nilai(q))
                    Nilai(q+1) = Nilai(q);
                    q = q - 1;
                else
                    ketemu = 1;
                end
                Nilai(q+1) = x;
            end
        end
        % Gunakan nilai median
        hasil(i-setengah, j-setengah) = ...
            Nilai(floor(ukuran * ukuran/2) + 1);
    end
end
hasil = uint8(hasil);