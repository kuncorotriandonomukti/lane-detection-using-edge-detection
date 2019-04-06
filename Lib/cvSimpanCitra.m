function cvSimpanCitra(citra,nama_proses,lokasi,iterasi)
% Fungsi ini berguna untuk menyimpan suatu gambar
namafile = sprintf('%s-%d.jpg',nama_proses,iterasi);
lokasi = fullfile(lokasi, namafile);
imwrite(citra,lokasi);
end
