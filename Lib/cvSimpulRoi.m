function cvSimpulRoi(x)
[baris,kolom,~] = size(x);
x1 = 0;
y1 = 0.755*baris; %0.765 if error, 80km 0.755, normal 0.725
x2 = kolom;
y2 = 0.755*baris; %0.765 if error, 80km 0.755, normal 0.725
figure(1);
imshow(x);
hold on;
line([x1 x2],[y1 y2])
title('Untuk menyimpan silahkan close figure');
xlabel('Garis biru merupakan batas marka terdeteksi yang akan dihitung','Color','r');
[b,k] = ginputc('ShowPoints', true,'ConnectPoints', true, 'Color', 'r', 'LineWidth', 1);
if isempty(b) && isempty(k)
    msgbox({'simpul_roi.mat gagal dibuat!';'Silakan lakukan pengaturan ulang.'},'Pemberitahuan','error')
    return
else
    save simpul_roi.mat b k
    msgbox('simpul_roi.mat berhasil dibuat!','Pemberitahuan','help')
end