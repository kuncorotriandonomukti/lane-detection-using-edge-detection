function hasil = cvErosi(citra, strel, hotx, hoty)
% EROSI Berguna untuk melaksanakan operasi erosi.
% Masukan:
% F = citra yang akan dikenai dilasi
% H = elemen pentruksur
% (hy, hx) koordinat pusat piksel

[th, lh]=size(strel);
[tf, lf]=size(citra);
if nargin < 3
    hotx = round(lh/2);
    hoty = round(th/2);
end
Xh = [];
Yh = [];
jum_anggota = 0;
% Menentukan koordinat piksel bernilai 1 pada H
for baris = 1 : th
    for kolom = 1 : lh
        if strel(baris, kolom) == 1
            jum_anggota = jum_anggota + 1;
            Xh(jum_anggota) = -hotx + kolom;
            Yh(jum_anggota) = -hoty + baris;
        end
    end
end
hasil = zeros(tf, lf); % Nolkan semua pada hasil erosi
% Memproses erosi
for baris = 1 : tf
    for kolom = 1 : lf
        cocok = true;
        for indeks = 1 : jum_anggota
            xpos = kolom + Xh(indeks);
            ypos = baris + Yh(indeks);
            if (xpos >= 1) && (xpos <= lf) && ...
                    (ypos >= 1) && (ypos <= tf)
                if citra(ypos, xpos) ~= 1
                    cocok = false;
                    break;
                end
            else
                cocok = false;
            end
        end
        if cocok
            hasil(baris, kolom) = 1;
        end
    end
end