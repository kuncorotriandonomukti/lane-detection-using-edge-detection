function [nilai] = cvMSE(F1, F2)
% MSECITRA Digunakan untuk menghitung MSE (mean square error)
% citra F1 dan F2.
[a1, b1] = size(F1);
[a2, b2] = size(F2);
if (a1 == a2) || (b1 == b2)
    Fa = double(F1); Fb = double(F2);
    m = a1;
    n = b1;
else
    deltaA = abs(a1-a2);
    deltaB = abs(b1-b2);
    if rem(deltaA,2)==1 || rem(deltaB,2)==1
        error('Ukuran kedua citra tidak cocok');
    end
    deltaA = abs(floor((a1-a2) / 2));
    deltaB = abs(floor((b1-b2) / 2));
    if (a1-a2 > 0) && (b1-b2 > 0)
        m = a2; n = b2;
        Fa = double(F1(1+deltaA:a1-deltaA, ...
        1+deltaB:b1-deltaB));
        Fb = double(F2);
    else
        m = a1; n = b1;
        Fa = double(F1);
        Fb = double(F2(1+deltaA:a2-deltaA, ...
        1+deltaB:b2-deltaB));
    end
end
nilai = 0;
for i=1 : m
    for j=1 : n
        nilai = nilai + (Fa(i,j) - Fb(i,j))^2;
    end
end
nilai = nilai / (m * n);