function hasil = cvTepiKirsch(citra,lib)
% Fungsi ini berfungsi untuk mendeteksi tepi objek pada citra
% menggunakan operator Marr-Hildreth
% Masukkan :
%   citra = gambar berskalan abu
%   ukuran = ukuran untuk kernel LOG
%   sigma = sigma untuk kernel LOG
% Hasil:
%    hasil = citra hasil deteksi tepi
citra = double(citra);

% Operator kompas
Kirsch1 = [5 -3 -3;5 0 -3;5 -3 -3];
Kirsch2 = [-3 -3 -3;5 0 -3; 5 5 -3];
Kirsch3 = [-3 -3 -3;-3 0 -3;5 5 5];
Kirsch4 = [-3 -3 -3;-3 0 5;-3 5 5];
Kirsch5 = [-3 -3 5;-3 0 5;-3 -3 -3];
Kirsch6 = [-3 5 5;-3 0 5;-3 -3 -3];
Kirsch7 = [5 5 5;-3 0 -3;-3 -3 -3];
Kirsch8 = [5 5 -3;5 0 -3;-3 -3 -3];
Kirsch(:,:,1) = Kirsch1;
Kirsch(:,:,2) = Kirsch2;
Kirsch(:,:,3) = Kirsch3;
Kirsch(:,:,4) = Kirsch4;
Kirsch(:,:,5) = Kirsch5;
Kirsch(:,:,6) = Kirsch6;
Kirsch(:,:,7) = Kirsch7;
Kirsch(:,:,8) = Kirsch8;
switch lib
    case 1
        % Lakukan proses konvolusi
        [b, k] = size(citra);
        for y = 2 : b-1
            for x = 2 : k-1
                % Pelaksanaan konvolusi
                for i=1 : 8
                    Grad(i) = Kirsch(1,1,i) * citra(y+1, x+1) + ...
                        Kirsch(1,2,i) * citra(y+1, x) + ...
                        Kirsch(1,3,i) * citra(y+1, x-1) + ...
                        Kirsch(2,1,i) * citra(y, x+1) + ...
                        Kirsch(2,2,i) * citra(y, x) + ...
                        Kirsch(2,3,i) * citra(y, x-1) + ...
                        Kirsch(3,1,i) * citra(y-1, x+1) + ...
                        Kirsch(3,2,i) * citra(y-1, x) + ...
                        Kirsch(3,3,i) * citra(y-1, x-1);
                end
                maks = max(Grad);
                hasil(y-1, x-1) = maks;
            end
        end
    case 2
        % Korelasi dengan replicate setiap kernel dengan citra (x)
        x1 = imfilter(citra,Kirsch(:,:,1),'replicate');
        x2 = imfilter(citra,Kirsch(:,:,2),'replicate');
        x3 = imfilter(citra,Kirsch(:,:,3),'replicate');
        x4 = imfilter(citra,Kirsch(:,:,4),'replicate');
        x5 = imfilter(citra,Kirsch(:,:,5),'replicate');
        x6 = imfilter(citra,Kirsch(:,:,6),'replicate');
        x7 = imfilter(citra,Kirsch(:,:,7),'replicate');
        x8 = imfilter(citra,Kirsch(:,:,8),'replicate');
        
        % Mencari nilai terbesar pada setiap arah
        Grad1 = max(x1,x2);
        Grad2 = max(Grad1,x3);
        Grad3 = max(Grad2,x4);
        Grad4 = max(Grad3,x5);
        Grad5 = max(Grad4,x6);
        Grad6 = max(Grad5,x7);
        Grad7 = max(Grad6,x8);
        y = logical(Grad7);
        hasil = y;
end