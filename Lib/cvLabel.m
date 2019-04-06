function hasil = cvLabel(citra)
% Memberi label pada area di dalam citra biner F
% dengan menggunakan 4-ketetanggan
% Hasil berupa citra G
% Bentuk Antrean awal
Maks_antre = 50000;
Antrean = cell(Maks_antre,1);
depan = 1;
belakang = 1;
hasil = double(citra); % Agar bisa diisi dengan nilai selain 0 dan 1
[m, n] = size(hasil);
label = 2;
for i=1 : m
    for j=1 : n
        if hasil(i, j) == 1
            % Kosongkan antrean
            depan = 1;
            belakang = 1;
            % Bentuk simpul dan masukkan ke dalam antrean
            simpul.y = i;
            simpul.x = j;
            if belakang == Maks_antre
                if depan == 1
                    error('Kapasitas antrian penuh');
                else
                    Antrean{obj.belakang} = simpul;
                    belakang = 1;
                end
            else
                if belakang + 1 == depan
                    error('Kapasitas antrian penuh');
                else
                    Antrean{belakang} = simpul;
                    belakang = belakang + 1;
                end
            end
            while belakang ~= depan % Selama antrean tidak kosong
                %Ambil dan hapus data pada Antrean
                simpul = Antrean{depan};
                if depan == 50000
                    depan = 1;
                else
                    depan = depan + 1;
                end
                if simpul.x > 0 && simpul.x <= n && ...
                        simpul.y > 0 && simpul.y <= m && ...
                        hasil(simpul.y, simpul.x) == 1
                    hasil(simpul.y, simpul.x) = label;
                    x = simpul.x; y = simpul.y;
                    simpul.y = y-1; simpul.x = x;
                    % Sisipkan ke Antrean
                    if belakang == Maks_antre
                        if depan == 1
                            error('Kapasitas antrian penuh');
                        else
                            Antrean{obj.belakang} = simpul;
                            belakang = 1;
                        end
                    else
                        if belakang + 1 == depan
                            error('Kapasitas antrian penuh');
                        else
                            Antrean{belakang} = simpul;
                            belakang = belakang + 1;
                        end
                    end
                    simpul.y = y+1; simpul.x = x;
                    % Sisipkan ke Antrean
                    if belakang == Maks_antre
                        if depan == 1
                            error('Kapasitas antrian penuh');
                        else
                            Antrean{obj.belakang} = simpul;
                            belakang = 1;
                        end
                    else
                        if belakang + 1 == depan
                            error('Kapasitas antrian penuh');
                        else
                            Antrean{belakang} = simpul;
                            belakang = belakang + 1;
                        end
                    end
                    simpul.y = y; simpul.x = x-1;
                    % Sisipkan ke Antrean
                    if belakang == Maks_antre
                        if depan == 1
                            error('Kapasitas antrian penuh');
                        else
                            Antrean{obj.belakang} = simpul;
                            belakang = 1;
                        end
                    else
                        if belakang + 1 == depan
                            error('Kapasitas antrian penuh');
                        else
                            Antrean{belakang} = simpul;
                            belakang = belakang + 1;
                        end
                    end
                    simpul.y = y; simpul.x = x+1;
                    % Sisipkan ke Antrean
                    if belakang == Maks_antre
                        if depan == 1
                            error('Kapasitas antrian penuh');
                        else
                            Antrean{obj.belakang} = simpul;
                            belakang = 1;
                        end
                    else
                        if belakang + 1 == depan
                            error('Kapasitas antrian penuh');
                        else
                            Antrean{belakang} = simpul;
                            belakang = belakang + 1;
                        end
                    end
                end
            end
            label = label + 1;
        end
    end
end