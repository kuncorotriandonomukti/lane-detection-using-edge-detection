function [hasil] = cvHisteq(citra)
% EKUALISASI Contoh untuk melakukan ekualisasi histogram
[b, k] = size(citra);
L = 256;
H = zeros(L, 1);
for i=1 : b
    for j=1 : k
        H(citra(i, j)+1) = ...
            H(citra(i, j)+1) + 1;
    end
end
a = (L-1) / (b * k);
citra(1) = a * H(1);
for i=1 : L-2
    citra(i+1) = citra(i) + round(a * H(i+1));
end
for i=1 : b
    for j=1 : k
        hasil(i, j) = citra(citra(i, j));
    end
end
hasil = uint8(hasil);
end