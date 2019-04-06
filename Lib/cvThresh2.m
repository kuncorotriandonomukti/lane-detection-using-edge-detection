function [hasil] = cvThresh2(citra, t1, t2)
% Pengambanan dengan dua nilai ambang
% F = Citra berskala keabuan
% t1 = nilai ambang bawah
% t2 = nilai ambang atas
%
% Keluaran: G = Citra biner
[b, k] = size(citra);
for i=1 : b
    for j=1:k
        if citra(i,j) <= t1 || citra(i,j) >= t2
            hasil(i,j) = 0;
        else
            hasil(i,j) = 1;
        end
    end
end