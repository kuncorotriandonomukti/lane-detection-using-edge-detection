function [hasil] = cvTepiKompas(citra, jenis)
% Fungsi ini melakukan operasi dengan operator kompas
% pada citra
% Masukkan:
%   citra = citra yang akan di olah
%   jenis 
%   1 = Prewitt
%   2 = Kirsch
%   3 = Robinson 3-level
%   4 = Robinson 4-level
% Hasil: 
%   hasil = hasil deteksi tepi kompas

if nargin < 2
    jenis = 2;
end
% Operator kompas
Prewitt1 = [1 1 -1;1 -2 -1;1 1 -1];
Prewitt2 = [1 -1 -1;1 -2 -1;1 1 -1];
Prewitt3 = [-1 -1 -1;1 -2 1;1 1 1];
Prewitt4 = [-1 -1 1;-1 -2 1;1 1 1];
Prewitt5 = [-1 1 1;-1 -2 1;-1 1 1];
Prewitt6 = [1 1 1;-1 -2 1;-1 -1 1];
Prewitt7 = [1 1 1;1 -2 1;-1 -1 -1];
Prewitt8 = [1 1 1;-1 -2 1;-1 -1 1];
Kirsch1 = [5 -3 -3;5 0 -3;5 -3 -3];
Kirsch2 = [-3 -3 -3;5 0 -3; 5 5 -3];
Kirsch3 = [-3 -3 -3;-3 0 -3;5 5 5];
Kirsch4 = [-3 -3 -3;-3 0 5;-3 5 5];
Kirsch5 = [-3 -3 5;-3 0 5;-3 -3 -3];
Kirsch6 = [-3 5 5;-3 0 5;-3 -3 -3];
Kirsch7 = [5 5 5;-3 0 -3;-3 -3 -3];
Kirsch8 = [5 5 -3;5 0 -3;-3 -3 -3];
Robinson3_1 = [1 0 -1;1 0 -1;1 0 -1];
Robinson3_2 = [0 -1 -1;1 0 -1;1 1 0];
Robinson3_3 = [-1 -1 -1;0 0 0;1 1 0];
Robinson3_4 = [1 1 -1;1 -2 -1;1 1 -1];
Robinson3_5 = [-1 0 1;-1 0 1;-1 0 1];
Robinson3_6 = [0 1 1;-1 0 1;-1 -1 0];
Robinson3_7 = [1 1 1;0 0 0;-1 -1 -1];
Robinson3_8 = [1 1 0;1 0 -1;0 -1 -1];
Robinson5_1 = [1 0 -1;2 0 -2;1 0 -1];
Robinson5_2 = [0 -1 -2;1 0 -1;2 1 0];
Robinson5_3 = [-1 -2 -1;0 0 0;1 2 -1];
Robinson5_4 = [-2 -1 0;-1 0 1;0 1 2];
Robinson5_5 = [-1 0 1;-2 0 2;-1 0 1];
Robinson5_6 = [0 1 2;-1 0 1;-2 -1 0];
Robinson5_7 = [1 2 1;0 0 0;-1 -2 -1];
Robinson5_8 = [2 1 0;1 0 -1;0 -1 -2];
Prewitt(:,:,1) = Prewitt1;
Prewitt(:,:,2) = Prewitt2;
Prewitt(:,:,3) = Prewitt3;
Prewitt(:,:,4) = Prewitt4;
Prewitt(:,:,5) = Prewitt5;
Prewitt(:,:,6) = Prewitt6;
Prewitt(:,:,7) = Prewitt7;
Prewitt(:,:,8) = Prewitt8;
Kirsch(:,:,1) = Kirsch1;
Kirsch(:,:,2) = Kirsch2;
Kirsch(:,:,3) = Kirsch3;
Kirsch(:,:,4) = Kirsch4;
Kirsch(:,:,5) = Kirsch5;
Kirsch(:,:,6) = Kirsch6;
Kirsch(:,:,7) = Kirsch7;
Kirsch(:,:,8) = Kirsch8;
Robinson3(:,:,1) = Robinson3_1;
Robinson3(:,:,2) = Robinson3_2;
Robinson3(:,:,3) = Robinson3_3;
Robinson3(:,:,4) = Robinson3_4;
Robinson3(:,:,5) = Robinson3_5;
Robinson3(:,:,6) = Robinson3_6;
Robinson3(:,:,7) = Robinson3_7;
Robinson3(:,:,8) = Robinson3_8;
Robinson5(:,:,1) = Robinson5_1;
Robinson5(:,:,2) = Robinson5_2;
Robinson5(:,:,3) = Robinson5_3;
Robinson5(:,:,4) = Robinson5_4;
Robinson5(:,:,5) = Robinson5_5;
Robinson5(:,:,6) = Robinson5_6;
Robinson5(:,:,7) = Robinson5_7;
Robinson5(:,:,8) = Robinson5_8;
% Tentukan operator yang dipakai
if jenis == 1
    Opr = Prewitt;
elseif jenis == 2
    Opr = Kirsch;
elseif jenis == 3
    Opr = Robinson3;
elseif jenis == 4
    Opr = Robinson5;
else
    error('Operator kedua: 1 s/d 4');
end
% Lakukan proses konvolusi
citra = double(citra);
[b, k] = size(citra);
for y = 2 : b-1
    for x = 2 : k-1
        % Pelaksanaan konvolusi
        for i=1 : 8
            Grad(i) = Opr(1,1,i) * citra(y+1, x+1) + ...
                Opr(1,2,i) * citra(y+1, x) + ...
                Opr(1,3,i) * citra(y+1, x-1) + ...
                Opr(2,1,i) * citra(y, x+1) + ...
                Opr(2,2,i) * citra(y, x) + ...
                Opr(2,3,i) * citra(y, x-1) + ...
                Opr(3,1,i) * citra(y-1, x+1) + ...
                Opr(3,2,i) * citra(y-1, x) + ...
                Opr(3,3,i) * citra(y-1, x-1);
        end
        maks = max(Grad);
        K(y-1, x-1) = maks;
    end
end
hasil = uint8(K);