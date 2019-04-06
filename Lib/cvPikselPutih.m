function hasil = cvPikselPutih(citra,t)
% Mendapatkan Baris, Kolom dan Channel
[b,k] = size(citra);
% Menyiapkan citra output sesuai dengan uk citra input
hasil = zeros(b,k);
for i = 1:b
    for j = 1:k
        % Mencari warna hitam pada Channel RGB
        % untuk putih mendekati 255, hitam 0
        if citra(i,j) >= t
            % Jika terdapat warna hitam maka (x,y) akan diberi warna Putih
            hasil(i,j) = 255;
        else
            % Selain itu bernilai 0
            hasil(i,j) = 0;
        end
    end
end

