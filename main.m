% PERBANDINGAN OPERATOR CANNY, LOG, KIRSCH PADA METODE DETEKSI TEPI UNTUK
% MENDETEKSI MARKA JALAN.
% TUGAS AKHIR 2017-2018 SISTEM KOMPUTER
% ALGORITMA UMUM & MODIFIKASI : VIDEO
%
%   TARGET
%       Precision & Recall Sistem mencapai >= 80%
%
%   BATASAN MASALAH
%       1. Kecepatan 30,50 dan 80 km/j
%       2. Cuaca Cerah
%       3. Marka Garis putus - putus
%       4. Pada jalan Raya/ Toll
%       5. Hanya mendeteksi marka pada jalur yang dilewati (kanan dan kiri)
%       6.
%       7.
%       8.
%       9.
%       10. Modifikasi hanya menggunakan Opperasi titik, Operasi
%       ketetanggaan, Image enhancement, Image Restoration, dll.
%
%   RANCANG SISTEM
%       Sistem bertujuan untuk mendeteksi marka garis pada jalan
%       terdapat 2 algoritma yang disediakan pada sistem ini, dimana yang
%       pertama merupakan "My Toolbox" atau merupakan toolbox yang dibuat
%       sendiri menggunakan teori dasar dari setiap metode. dan yang
%       lainnya yaitu "MATLAB Toolbox" merupakan library yang telah
%       disediakan oleh MATLAB.
%
%   METPDE YANG DIGUNAKAN
%       1. Grayscale atau konversi citra RGB menjadi Grayscale.
%       2. Perbaikan citra menggunakan filter median
%       3. Penerapan Deteksi Tepi menggunakan operator Canny/LOG/Kirsch
%       4. Citra hasil deteksi tepi diolah menggunakan Hough Transform
%       untuk mendapatkan garis tepi yang tepat.
%
%   PARAMETER GLOBAL -----------------------------------------------------
%                       1. Grayscale / Skala Abu
% ------------------------------------------------------------------------
%	My Toolbox >
%       GS = cvRGB2Gray(citra) melakukan proses Grayscaling dengan nilai
%       bobot RGB yang telah ditentukan sebagai berikut (0.2989*R + ...
%       0.5870*G + 0.1140*B)/3.
%
%       GS = cvRGB2GRAY(citra,nilai r, nilai g, nilai b) Nilai r/g/b dapat
%       ditentukan sendiri sebagai bobot perhitungan (R*wR + G*wG + ...
%       B*wB)/3. dimana w merupakan weight(bobot).
%	MATLAB Toolbox >
%       GS = rgb2gray(citra) melakukan proses Grayscale sama seperti
%       (1*R+1*G+1*B)/3.
% ------------------------------------------------------------------------
%               2. Noise Reduction / Menghilangkan Derau
% ----------------------------- MEDIAN FILTER ----------------------------
%   My Toolbox >
%       Derau = cvDerauMed(citra) melakukan operasi median filter dengan
%       nilai bawaan ukuran jendela/ kernel yaitu [3 3] atau 3x3.
%
%       Derau = cvDerauMed(citra,ukuran) melakukan operasi median filter
%       dengan nilai ukuran jendela/ kernel sesuai dengan yang telah
%       ditentukan.
%
%	MATLAB Toolbox >
%       Derau = medfilt2(citra) melakukan operasi median filter
% ----------------------------- GAUSSIAN LPF -----------------------------
%	My Toolbox >
%       Derau = cvDerauGaussian(citra) melakukan operasi gaussian filter
%       dengan nilai bawaan sigma yaitu 10 dan mu 0.
%
%       Derau = cvDerauGaussian(citra, sigma, mu) melakukan operasi
%       gaussian filter berdasarkan nilai sigma dan mu yang telah
%       ditentukan.
%
%	MATLAB Toolbox >
%       Derau = imgaussfilt(citra) melakukan operasi gaussan smoothing
%       dengan nilai sigma bawaan yaitu 0.5.
% ------------------------------------------------------------------------
%                    3. EDGE DETECTION / DETEKSI TEPI
% ---------------------------- OPERATOR CANNY ----------------------------
%	My Toolbox >
%       tepi = cvTepiCanny(citra) menggunakan nilai bawaan untuk t1 dan t2
%       yaitu 0.05 (t1) dan 0.15 (t2)
%
%	MATLAB Toolbox >
%       tepi = edge(citra,'Canny')
% --------------------- OPERATOR LOG / MARR-HILDRETH ---------------------
%	My Toolbox >
%       tepi = cvTepiLog(citra) menggunakan nilai bawaan untuk ukuran
%       jendela atau pembuatan kernel log yaitu 5x5 dan sigma 0.6.
%
%	MATLAB Toolbox >
%       tepi = edge(citra,'log')
% ------------------------ OPERATOR KOMPAS KIRSCH ------------------------
%	My Toolbox >
%       tepi = cvTepiKirsch(citra) menggunakan operator kompas kirsch untuk
%       mendeteksi tepi.
%
%	MATLAB Toolbox >
%       Syntax tidak tersedia
% ------------------------------------------------------------------------
%                            4. HOUGH TRANSFORM
% ------------------------------------------------------------------------
%	MATLAB Toolbox >
%       [H,T,R] = hough(citra) Menggunakan toolbox hough transform
% ------------------------------------------------------------------------
%
%   INISIALISASI NILAI PARAMETER
%       GRAYSCALE : default MATLAB
%       NOISE REDUCTION : default MATLAB
%       EDGE DETECTION : default MATLAB
%       HOUGH TRANSFORM : default MATLAB
%
% By Kuncoro Triandono Mukti
% for Final Task 2017 - 2018
% S1 Computer Engineering

function varargout = main(varargin)
% MAIN MATLAB code for main.fig
%      MAIN, merupakan GUI Utama
%
% Lihat Juga: Kamera, cara, tentang

% Last Modified by GUIDE v2.5 01-Jul-2018 21:33:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @main_OpeningFcn, ...
    'gui_OutputFcn',  @main_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% --- Executes just before main is made visible.
function main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main (see VARARGIN)

memuat = waitbar(0,'Mempersiapkan... 0%');
clc; cla;
disp('Mempersiapkan...');
waitbar(0.13,memuat,'Mempersiapkan... 13%');
set(handles.status,'String','Mempersiapkan...');
waitbar(0.35,memuat,'Mempersiapkan... 35%');

% Persiapan Kamera
cam = imaqhwinfo;
cam_adaptor = (cam.InstalledAdaptors);
set(handles.pupadaptor,'string',cam_adaptor);

waitbar(0.47,memuat,'Mempersiapkan... 47%');
cam_adaptor = get(handles.pupadaptor,'string');
cam = imaqhwinfo(char(cam_adaptor));
cam_name = {cam.DeviceInfo.DeviceName};
set(handles.pupkamera,'string',cam_name);

waitbar(0.69,memuat,'Mempersiapkan... 69%');
cam_id = get(handles.pupkamera,'value');
cam_res = cam.DeviceInfo(cam_id).SupportedFormats;
cam_id_name = cam_name{cam_id};

set(handles.pupresolusi,'string',{char(cam_res)});
res_id = get(handles.pupresolusi,'value');
cam_resolusi = cam_res{res_id};
waitbar(0.86,memuat,'Mempersiapkan... 86%');

if exist('layout_tr.png') && exist('layout.png') && exist('ginputc.m')...
        && exist('cvTepiLog.m') && exist('cvTepiCanny.m')...
        && exist('cvTepiKirsch.m') && exist('cvSimpulRoi.m')...
        && exist('cvSimpanCitra.m') && exist('cvRGB2GRAY.m')...
        && exist('cvPOMul.m') && exist('cvPikselPutih.m')...
        && exist('cvKorelasi.m') && exist('cvKonvolusi.m')...
        && exist('cvKernelLog.m') && exist('cvKernelGaussian.m')...
        && exist('cvKamera.m') && exist('cvGetPos.m')...
        && exist('cvKKamera.m') && exist('cvDerauMed.m')...
        && exist('cvDerauGaussian.m')
    waitbar(0.90,memuat,'Mempersiapkan... 90%');
else
    msgbox('Terdapat file yang tidak tersedia!','Pemberitahuan','error');
    close(memuat);
    close();
    disp('Gagal mempersiapkan!');
    return
end

% Mempersiapkan Layout untuk FIGHASIL dan FIGPRATAMPIL
layout1 = imread('layout_tr.png');
layout2 = imread('layout.png');

% Mempersiapkan Layout pada FIGPRATAMPIL
axes(handles.figpratampil);
imshow(layout2, [], 'XData', [0 1], 'YData', [0 .5]);

% Mempersiapkan Layout pada FIGPRATAMPIL
axes(handles.fighasil);
imshow(layout1);

% Mempersiapkan Opsi
opsi_operator = [{'Operator Canny'} {'Operator Marr-Hildreth (LOG)'} {'Operator Kirsch'}];
opsi_algoritma = [{'Algoritma Umum'} {'Algoritma Modifikasi'}];
opsi_toolbox = [{'My Toolbox'} {'MATLAB Toolbox'}];
opsi_frame = [{'Batasi Frame'} {'Jangan dibatasi'}];
opsi_jalur = [{'Tampilkan Garis Terdeteksi'} {'Tampilkan Jalur & Arah'}];

% Mengisi Pengaturan
set(handles.panelkamera,'visible','on');
set(handles.txtnamakam,'string','Kamera');
set(handles.txtinfo,'string','Tidak tersedia');
set(handles.btnkamera,'Cdata',imread('configTA.png'),'enable','inactive');
set(handles.btnclose,'Cdata',imread('closeA.png'),'enable','on');
set(handles.btnpratampil,'Cdata',imread('eyeTA.png'),'enable','inactive');
set(handles.btnrun,'Cdata',imread('runTA.png'),'enable','inactive');
set(handles.btnstop,'Cdata',imread('stopTA.png'),'value',0,'enable','inactive');
set(handles.btnreset,'Cdata',imread('resetTA.png'),'enable','inactive');
set(handles.pupadaptor,'value',1);
set(handles.pupkamera,'value',2);
set(handles.pupresolusi,'value',24);
set(handles.pupoperator,'string',opsi_operator,'enable','off');
set(handles.pupalgoritma,'string',opsi_algoritma,'enable','off');
set(handles.puptoolbox,'string',opsi_toolbox,'enable','off');
set(handles.pupframe,'string',opsi_frame,'enable','off');
set(handles.pupjalur,'string',opsi_jalur,'enable','off');
set(handles.tbsimpulroi,'value',0,'enable','off');
set(handles.tbsimpan,'value',0,'enable','off');
set(handles.txtlmtfrm,'enable','off');
set(handles.txtfrmdeteksi,'String','0');
set(handles.txttotalfrm,'String','0');
set(handles.txtfrmke,'String','0');
set(handles.waktuproses,'String','0');
waitbar(0.92,memuat,'Mempersiapkan... 92%');

% Persiapan Variabel
vid = 0; vidRes = 0; pratampil = false;
waitbar(1,memuat,'Mempersiapkan... 100%');

% Choose default command line output for main
handles.cam_id = cam_id;
handles.res_id = res_id;
handles.cam_res = cam_res;
handles.cam_resolusi = cam_resolusi;
handles.adaptor = cam_adaptor;
handles.cam = cam;
handles.cam_name = cam_name;
handles.cam_id_name = cam_id_name;
handles.opsi_operator = opsi_operator;
handles.opsi_algoritma = opsi_algoritma;
handles.opsi_toolbox = opsi_toolbox;
handles.opsi_frame = opsi_frame;
handles.opsi_jalur = opsi_jalur;
handles.pratampil = pratampil;
handles.vidRes = vidRes;
handles.vid = vid;
handles.layout1 = layout1;
handles.layout2 = layout2;
handles.output = hObject;
clc;
disp('Ready');
set(handles.status,'String','Ready');
close(memuat);

% Update handles structure
guidata(hObject, handles);


function varargout = main_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in tbsimpulroi.
function tbsimpan_Callback(hObject, eventdata, handles)
% hObject    handle to tbsimpulroi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in tbsimpulroi.
function tbsimpulroi_Callback(hObject, eventdata, handles)
% hObject    handle to tbsimpulroi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.status,'string','[PROSES] Membuat simpul ROI...');
pilih = get(hObject,'value');
if pilih == 1
    start(handles.vid);
    pause(1);
    im_roi = getsnapshot(handles.vid);
    stop(handles.vid);
    cvSimpulRoi(im_roi);
    set(hObject,'value',0);
    set(handles.status,'string','Ready');
end


% --- Executes on button press in onoff.
function onoff_Callback(hObject, eventdata, handles)
% hObject    handle to onoff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of onoff
if get(hObject,'value') == 1
    set(hObject,'Cdata',imread('on.png'));
    msgbox('Tampilkan hasil ON','Pemberitahuan','help');
else 
    set(hObject,'Cdata',imread('off.png'));
    msgbox('Tampilkan hasil OFF','Pemberitahuan','help');
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over btnhelp.
function btnhelp_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to btnhelp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btnback.
function btnback_Callback(hObject, eventdata, handles)
% hObject    handle to btnback (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btnshadow.
function btnshadow_Callback(hObject, eventdata, handles)
% hObject    handle to btnshadow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btnkamera.
function btnkamera_Callback(hObject, eventdata, handles)
% hObject    handle to btnkamera (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Konfigurasi Kamera
set(handles.panelkamera,'visible','on');
set(handles.btnkamera,'Cdata',imread('configTA.png'),'enable','inactive');
set(handles.btnpratampil,'Cdata',imread('eyeTA.png'),'enable','inactive');
set(handles.btnrun,'Cdata',imread('runTA.png'),'enable','inactive');
set(handles.btnstop,'Cdata',imread('stopTA.png'),'value',0,'enable','inactive');
set(handles.btnreset,'Cdata',imread('resetTA.png'),'enable','inactive');


% --- Executes on selection change in pupadaptor.
function pupadaptor_Callback(hObject, eventdata, handles)
% hObject    handle to pupadaptor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pupadaptor contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pupadaptor
cam_adaptor = get(hObject,'string');
cam = imaqhwinfo(char(cam_adaptor));
cam_name = {cam.DeviceInfo.DeviceName};
set(handles.pupkamera,'string',cam_name);

% Update Handles Structure
handles.cam_adaptor = cam_adaptor;
handles.cam = cam;
handles.cam_name = cam_name;

guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function pupadaptor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pupadaptor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pupkamera.
function pupkamera_Callback(hObject, eventdata, handles)
% hObject    handle to pupkamera (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pupkamera contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pupkamera
cam_id = get(handles.pupkamera,'value');
cam = handles.cam;
cam_res = cam.DeviceInfo(cam_id).SupportedFormats;
cam_id_name = handles.cam_name{cam_id};
set(handles.pupresolusi, 'value', 1);
set(handles.pupresolusi,'string',{char(cam_res)});

% Update Handles Structure
handles.cam_id_name = cam_id_name;
handles.cam_id = cam_id;
handles.cam_res = cam_res;

guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function pupkamera_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pupkamera (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pupresolusi.
function pupresolusi_Callback(hObject, eventdata, handles)
% hObject    handle to pupresolusi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pupresolusi contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pupresolusi
res_id = get(handles.pupresolusi,'value');
cam_resolusi = handles.cam_res{res_id};

% Update Handles Structure
handles.res_id = res_id;
handles.cam_resolusi = cam_resolusi;

guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function pupresolusi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pupresolusi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnsimpanconfig.
function btnsimpanconfig_Callback(hObject, eventdata, handles)
% hObject    handle to btnsimpanconfig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc
% Persiapan
set(handles.status,'String','[PROSES] Konfigurasi Kamera...');
set(handles.status,'String','[OK] Konfigurasi Kamera');
delete(imaqfind); % Delete semua kamera yang sedang digunakan

% Mengambil data konfigurasi kamera
adaptor = get(handles.pupadaptor,'string'); % Ambil data Adaptor
nama = handles.cam_id_name;
id = handles.cam_id; % Ambil data ID Kamera
res = handles.cam_resolusi; % Ambil data Resolusi Kamera

% Pengecekan
if isempty(adaptor) && isempty(nama) && isempty(id)
    set(handles.status,'String','[GAGAL] Konfigurasi Kamera');
    msgbox({'Konfigurasi kamera gagal!';...
        'Silakan melakukan pengaturan ulang!'},'Pemberitahuan','error')
    return
else
    % Persiapan Video
    set(handles.status,'String','[PROSES] Konfigurasi Kamera...');
    vid = videoinput(char(adaptor), id, char(res)); % Deklarasi 'vid' sebagai input video
    
    % Pengaturan Video
    set(vid, 'FramesPerTrigger', Inf);
    set(vid, 'TriggerRepeat', Inf);
    set(vid, 'ReturnedColorspace', 'rgb')
    
    % Persiapkan AXES 1 & 2
    vidRes = get(vid, 'VideoResolution'); % Video Resolusi
    nBands = get(vid, 'NumberOfBands'); % Channel Warna
    
    % Atur seluruh objek pada gui
    set(handles.txtnamakam,'String',nama);
    set(handles.txtinfo, 'String', [num2str(vidRes(2)),'x',...
        num2str(vidRes(1)),'x',num2str(nBands)]);
    set(handles.btnpratampil,'Cdata',imread('eyeA.png'),'enable','on');
    set(handles.btnrun,'Cdata',imread('runA.png'),'enable','on');
    set(handles.btnstop,'Cdata',imread('stopTA.png'),'enable','inactive');
    set(handles.btnreset,'Cdata',imread('resetA.png'),'enable','on');
    set(handles.pupoperator,'enable','on');
    set(handles.pupalgoritma,'enable','on');
    set(handles.puptoolbox,'enable','on');
    set(handles.pupframe,'enable','on');
    set(handles.pupjalur,'enable','on');
    set(handles.txtlmtfrm,'enable','on');
    set(handles.tbsimpulroi,'enable','on');
    set(handles.tbsimpan,'enable','on');
    set(handles.btnkamera,'Cdata',imread('configA.png'),'enable','on');
    set(handles.panelkamera, 'visible','off');
    set(handles.status,'String','[OK] Konfigurasi Kamera');
    msgbox('Konfigurasi kamera berhasil!','Pemberitahuan','help')
end

% Updates Handles structure
handles.adaptor = adaptor;
handles.id = id;
handles.nama = nama;
handles.res = res;
handles.vidRes = vidRes;
handles.nBands = nBands;
handles.vid = vid;

guidata(hObject, handles);

% --- Executes on button press in btnrun.
function btnrun_Callback(hObject, eventdata, handles)
% hObject    handle to btnrun (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc
memuat = waitbar(0,'Mempersiapkan... 0%');
set(handles.status,'String','[PROSES] Mempersiapkan...');

% Atur seluruh objek pada gui
if handles.pratampil == false
    set(handles.btnpratampil,'Cdata',imread('eyeTA.png'),'enable','inactive');
else
    set(handles.btnpratampil,'Cdata',imread('eyeHTA.png'),'enable','inactive');
end
set(handles.btnrun,'Cdata',imread('runTA.png'),'enable','inactive');
set(handles.btnkamera,'Cdata',imread('configTA.png'),'enable','inactive');
set(handles.btnstop,'Cdata',imread('stopA.png'),'enable','on');
set(handles.btnreset,'Cdata',imread('resetTA.png'),'enable','inactive');
set(handles.btnclose,'Cdata',imread('closeTA.png'),'enable','inactive');
set(handles.pupoperator,'enable','off');
set(handles.pupalgoritma,'enable','off');
set(handles.puptoolbox,'enable','off');
set(handles.pupframe,'enable','off');
set(handles.pupjalur,'enable','off');
set(handles.tbsimpulroi,'enable','off');
set(handles.tbsimpan,'enable','off');
set(handles.txtlmtfrm,'enable','off');
waitbar(0.25,memuat,'Mempersiapkan... 25%');

% Cek file pendukung
fullFileName = 'simpul_roi.mat';
if exist(fullFileName, 'file')
    load simpul_roi.mat b k
else
    set(handles.status,'String','[GAGAL] simpul_roi.mat tidak tersedia!');
    msgbox('simpul_roi.mat tidak tersedia!\nSilakan lakukan pengaturan simpul ROI',...
        'Pemberitahuan','warn');
    return
end
waitbar(0.5,memuat,'Mempersiapkan... 50%');

% Persiapan menu
operator = get(handles.pupoperator,'value'); % Menu operator
algoritma = get(handles.pupalgoritma,'value'); % Menu algoritma
toolbox = get(handles.puptoolbox,'value'); % Menu toolbox
jalur = get(handles.pupjalur,'value'); % Menu Deteksi jalur
simpan = get(handles.tbsimpan,'value'); % Menu Simpan
waitbar(0.72,memuat,'Mempersiapkan... 72%');

% Persiapan Variabel
limit = str2double(get(handles.txtlmtfrm,'string')); % Lama batas pengolahan
dummy = zeros(handles.vidRes(2),handles.vidRes(1),handles.nBands); % Axes 1
akuisisi = imshow(dummy,'Parent',handles.fighasil); % persiapan figure
totalframe = 0; % Total frame
[baris,kolom,~] = size(dummy);
kiri_x = 0;
kiri_y = 0.755*baris; %0.765 if error, 80km 0.755, normal 0.725
kanan_x = kolom;
kanan_y = 0.755*baris; %0.765 if error, 80km 0.755, normal 0.725
waitbar(0.93,memuat,'Mempersiapkan... 93%');

% Tampilkan informasi
set(handles.status,'String','[PROSES] Mengolah...');
fprintf('Adaptor : %s \nNama : %s \nID : %d\nResolusi : %s\n',...
    char(handles.adaptor),handles.nama,handles.id,handles.res);
fprintf('%s\n%s\n%s\n----------------------------------------------\n',...
    handles.opsi_operator{operator},handles.opsi_algoritma{algoritma},...
    handles.opsi_toolbox{toolbox});
waitbar(1,memuat,'Mempersiapkan... 100%');
close(memuat);

%% Pengolahan citra
start(handles.vid) % Memulai Video
while (handles.vid.FramesAcquired<=limit)
    tic
    switch algoritma
        %% Algoritma Umum
        case 1
            totalframe = totalframe+1;
            set(handles.txtfrmdeteksi,'String',totalframe);
            set(handles.txttotalfrm,'String',handles.vid.FramesAcquired);
            set(handles.txtfrmke,'String',handles.vid.FramesAcquired);
            im = getsnapshot(handles.vid);
            GS = rgb2gray(im); % Grayscalling
            perbaikan = medfilt2(GS); % Smoothing
            switch toolbox
                case 1
                    %% My Toolbox
                    % Operator Deteksi Tepi
                    switch operator
                        case 1
                            BW = cvTepiCanny(perbaikan); % Canny
                        case 2
                            BW = cvTepiLog(perbaikan); % LOG
                        case 3
                            BW = cvTepiKirsch(perbaikan,1); % Kirsch
                        otherwise
                            error('Operator yang dipilih tidak tersedia');
                    end
                case 2
                    %% MATLAB Toolbox
                    % Operator Deteksi Tepi
                    switch operator
                        case 1
                            BW = edge(perbaikan, 'canny'); % Canny
                        case 2
                            BW = edge(perbaikan, 'log'); % LOG
                        case 3
                            BW = cvTepiKirsch(perbaikan,2); % Kirsch
                        otherwise
                            error('Operator yang dipilih tidak tersedia');
                    end
            end
        case 2
            %% Algoritma Modifikasi
            totalframe = totalframe+1;
            set(handles.txtfrmdeteksi,'String',totalframe);
            set(handles.txttotalfrm,'String',handles.vid.FramesAcquired);
            set(handles.txtfrmke,'String',handles.vid.FramesAcquired);
            im = getsnapshot(handles.vid);
            GS = cvRGB2GRAY(im); % Grayscalling
            kontras = cvPOMul(GS,1.75); % Enhancement
            perbaikan = cvPikselPutih(kontras,130); % Enhancement
            switch toolbox
                case 1
                    %% MY Toolbox
                    switch operator
                        case 1
                            BW = cvTepiCanny(perbaikan); % Canny
                        case 2
                            BW = cvTepiLog(perbaikan); % LOG
                        case 3
                            BW = cvTepiKirsch(perbaikan,1); % Kirsch
                        otherwise
                            error('Operator yang dipilih tidak tersedia');
                    end
                    % Region of Interest
                    mask = roipoly(BW,b,k); % Masking
                    BW = BW.*mask; % Apply masking
                case 2
                    %% MATLAB Toolbox
                    switch operator
                        case 1
                            BW = edge(perbaikan, 'canny'); % Canny
                        case 2
                            BW = edge(perbaikan, 'log'); % LOG
                        case 3
                            BW = cvTepiKirsch(perbaikan,2); % Kirsch
                        otherwise
                            error('Operator yang dipilih tidak tersedia');
                    end
                    % Region of Interest
                    mask = roipoly(BW,b,k);
                    BW = BW.*mask;
            end
    end
    BWsimpan(:,:,:,totalframe) = BW;
    % Hough Transform
    [H,theta,rho] = hough(BW);
    % mengIdentifikasi Peaks pada Hough Transform
    hPeaks  = houghpeaks(H,2);
    % Ekstraksi garis dari Hough Transform dan peaks
    garis = houghlines(BW,theta,rho,hPeaks,'FillGap',5,'MinLength',5);
    % Menggambar Garis
    switch jalur
        case 1
            %% Deteksi garis marka
            % Mencari koordinat Garis
            posisi_garis = [];
            for lidx = 1:length(garis)
                % Get linePos in [x1 y1;x2 y2...] format.
                posisi_garis = [posisi_garis;...
                    garis(lidx).point1 garis(lidx).point2];
            end
            if (~isempty(posisi_garis))
                % garis terdeteksi gambar posisinya
                hasil(:,:,:,totalframe) = insertShape(...
                    im,'Line',posisi_garis,...
                    'Color','yellow','LineWidth',2);
            else
                % tidak ada garis yang terdeteksi kembalikan citra asli
                hasil(:,:,:,totalframe) = im;
            end
        case 2
            %% Deteksi jalur
            [tinggi,lebar,~] = size(im);
            batas_tengah = 397; batas_kanan = 405;
            kiriXL = []; kiriXR = []; kiriYL = []; kiriYR = [];
            kananXL = []; kananXR = []; kananYL = []; kananYR = [];
            iL = 0; iR = 0; % indeksi garis Kiri dan Kanan
            pt = [0 tinggi*0.9]; % Posisi teks arah
            min_len = 1; % Panjang garis minimum
            for i = 1:length(garis) %or P
                len = norm(garis(i).point1 - garis(i).point2);
                if (len > min_len)
                    % Menyimpan posisi 1 garis
                    xy = [garis(i).point1; garis(i).point2];
                    x1 = xy(1,1); % kooridnat x titik awal
                    y1 = xy(1,2); % kooridnat y titik awal
                    x2 = xy(2,1); % kooridnat x titik akhir
                    y2 = xy(2,2); % kooridnat y titik akhir
                    % hasil = insertShape(hasil, 'Line',...
                    %[x1 y1 x2 y2], 'LineWidth', 2, 'Color', 'red');
                    if(x2~=x1) % Menghindari garis yang memiliki
                        %titik awal dan akhir sama
                        slope = (y2-y1)/(x2-x1); % Mencari selisih
                        %'y2-y1/x2-x1'
                        if (slope<-0.45) % jika selisih < -0.45
                            %maka posisi garis di kiri
                            iL = iL + 1; % membuat index garis kiri
                            % syntax x = [x;1] menunjukan penyimpanan x kedalam
                            % array x dan menyimpan x sebelumnya. misal x = [1 1]
                            % jika penyimpanan x = [x] atau x = x maka x = [1 1]
                            % oleh karena itu untuk menyimpan nilai baru digunakan
                            % x = [x; y] maka x = [1 1 y];
                            
                            % leftLineXL = posisi X kiri
                            % leftLineYL = posisi Y kiri
                            % leftLineYR = posisi Y kanan
                            % leftLineXR = posisi X kanan
                            
                            kiriXL = [kiriXL;1];
                            kiriYL = [kiriYL;slope * ...
                                (kiriXL(iL) - x1) + y1];
                            kiriYR = [kiriYR;0.670*tinggi];
                            kiriXR = [kiriXR;(kiriYR(iL) - ...
                                kiriYL(iL))/slope + kiriXL(iL)];
                            %hasil = insertShape(hasil, 'Line',...
                            %[kiriXL(iL) kiriYL(iL) kiriXR(iL)...
                            %kiriYR(iL)], 'LineWidth',2, 'Color', 'green');
                        end
                        
                        if (slope>0.45) % jika selisih > 0.45 maka posisi garis di kanan
                            iR=iR+1; % membuat index garis kanan
                            kananXR = [kananXR; lebar];
                            kananYR = [kananYR;slope *...
                                (kananXR(iR) - x1) + y1];
                            kananYL = [kananYL;0.670*tinggi];
                            kananXL = [kananXL;-((kananYR(iR)...
                                - kananYL(iR))/slope - kananXR(iR))];
                            %hasil= insertShape(hasil, 'Line',...
                            %[kananXL(iR) kananYL(iR) kananXR(iR)...
                            %kananYR(iR)], 'LineWidth',2, 'Color', 'green');
                        end
                    end
                end
            end
            if (~isempty(kiriXL)*~isempty(kiriYL)*~isempty(kiriXR)...
                    *~isempty(kiriYR)*~isempty(kananXL)...
                    *~isempty(kananYL)*~isempty(kananXR)...
                    *~isempty(kananYR) > 0)
                p1 = [sum(kiriXL)/iL sum(kiriYL)/iL];
                p2 = [sum(kiriXR)/iL sum(kiriYR)/iL];
                p3 = [sum(kananXL)/iR sum(kananYL)/iR];
                p4 = [sum(kananXR)/iR sum(kananYR)/iR];
                fit1 = polyfit([p1(1) p2(1)],[p1(2) p2(2)],1);
                fit2 = polyfit([p3(1) p4(1)],[p3(2) p4(2)],1);
                posisi = fzero(@(x) polyval(fit1-fit2,x),3);
                
                % Menentukan Arah
                if (posisi < batas_tengah)
                    arah = 'Belok Kiri';
                end
                if (posisi > batas_tengah)
                    arah = 'Lurus';
                end
                if (posisi > batas_kanan)
                    arah = 'Belok Kanan';
                end
                
                % Gambar Hasil garis dan arah
                hasil = insertShape(im, 'Line', [p1 p2 p3 p4],...
                    'LineWidth',2, 'Color', 'yellow');
                hasil = insertShape(hasil, 'FilledPolygon',...
                    [p1 p2 p3 p4],'Color', [255 255 0], 'Opacity', 0.2);
            else
                % Jika gagal terdeteksi
                hasil = im;
                arah = 'Gagal Deteksi';
            end
            % Menyatukan hasil deteksi jalur dan arah
            hasil(:,:,:,totalframe) = insertText(hasil,pt,arah);
    end
    
    if get(handles.onoff,'value') == 1
        % Tampilkan citra hasil
        set(akuisisi,'Cdata',hasil(:,:,:,totalframe));
        drawnow;
    end
    
    % Tampilkan Waktu
    tiktok(totalframe) = toc;
    set(handles.waktuproses,'String',toc);
    
    % Hitung Garis
    threshold_garis = 6; % Total Garis didalam ROI
    TP(totalframe) = numel(garis);
    FN(totalframe) = threshold_garis - TP(totalframe);

    % Berhentikan proses jika tombol stop = true
    if get(handles.btnstop,'value') == 1
        set(handles.btnstop,'value',0)
        stop(handles.vid)
        break
        return
    end
end

% Jika tombol simpan = true && Hitung Recall
if simpan == 1
    tunggu_simpan = waitbar(0,'Sedang menyimpan... 0%');
    for i = 1:totalframe
        persen = i/totalframe;
        teks = sprintf('Sedang menyimpan... %0.0f%%',persen*100);
        waitbar(persen,tunggu_simpan,teks);
        hasil(:,:,:,i) = insertShape(hasil(:,:,:,i),...
            'Line',[kiri_x kiri_y kanan_x kanan_y],'Color','red',...
            'LineWidth',1);
        switch algoritma
            case 1
                switch operator
                    case 1
                        cvSimpanCitra(BWsimpan(:,:,:,i),'BW',...
                            'Hasil/Umum/Canny',i);
                        cvSimpanCitra(hasil(:,:,:,i),'hasil',...
                            'Hasil/Umum/Canny',i);
                        save Hasil/Umum/Canny/log_waktu.mat tiktok
                        save TP.mat TP
                        save FN.mat FN
                        drawnow;
                    case 2
                        cvSimpanCitra(BWsimpan(:,:,:,i),'BW',...
                            'Hasil/Umum/LOG',i);
                        cvSimpanCitra(hasil(:,:,:,i),'hasil',...
                            'Hasil/Umum/LOG',i);
                        save Hasil/Umum/LOG/log_waktu.mat tiktok
                        save TP.mat TP
                        save FN.mat FN
                        drawnow;
                    case 3
                        cvSimpanCitra(BWsimpan(:,:,:,i),'BW',...
                            'Hasil/Umum/Kirsch',i);
                        cvSimpanCitra(hasil(:,:,:,i),'hasil',...
                            'Hasil/Umum/Kirsch',i);
                        save Hasil/Umum/Kirsch/log_waktu.mat tiktok
                        save TP.mat TP
                        save FN.mat FN
                        drawnow;
                end
            case 2
                switch operator
                    case 1
                        cvSimpanCitra(BWsimpan(:,:,:,i),'BW',...
                            'Hasil/Modifikasi/Canny',i);
                        cvSimpanCitra(hasil(:,:,:,i),'hasil',...
                            'Hasil/Modifikasi/Canny',i);
                        save Hasil/Modifikasi/Canny/log_waktu.mat tiktok
                        save TP.mat TP
                        save FN.mat FN
                        drawnow;
                    case 2
                        cvSimpanCitra(BWsimpan(:,:,:,i),'BW',...
                            'Hasil/Modifikasi/LOG',i);
                        cvSimpanCitra(hasil(:,:,:,i),'hasil',...
                            'Hasil/Modifikasi/LOG',i);
                        save Hasil/Modifikasi/LOG/log_waktu.mat tiktok
                        save TP.mat TP
                        save FN.mat FN
                        drawnow;
                    case 3
                        cvSimpanCitra(BWsimpan(:,:,:,i),'BW',...
                            'Hasil/Modifikasi/Kirsch',i);
                        cvSimpanCitra(hasil(:,:,:,i),'hasil',...
                            'Hasil/Modifikasi/Kirsch',i);
                        save Hasil/Modifikasi/Kirsch/log_waktu.mat tiktok
                        save TP.mat TP
                        save FN.mat FN
                        drawnow;
                end
        end
    end
    close(tunggu_simpan);
end

% Hitung Recall
TP = sum(TP);
FN = sum(FN);
recall = (TP/(TP+FN))*100;
fprintf('TP (Garis sebenarnya yang terdeteksi) = %d \n',TP);
fprintf('FN (Garis sebenarnya tidak terdeteksi) = %d \n',FN);
fprintf('Recall = %0.2f%% \n',recall);
fprintf('----------------------------------------------\n');

% Hapus, Stop, Tampilkan Informasi
stop(handles.vid);
flushdata(handles.vid);
set(handles.status,'String','[OK] Pengolahan Selesai');
msgbox('Pengolahan Selesai!','Pemberitahuan','help')
fprintf('Total frame yang terdeteksi %d/%d\n',totalframe,...
    str2double(get(handles.txtfrmke,'string')));
fprintf('Total waktu pengolahan %0.2f detik\n',...
    (sum(tiktok)/length(tiktok))*totalframe);
fprintf('Rata-rata waktu pengolahan %0.4f detik/frame\n',...
    sum(tiktok)/length(tiktok));
fprintf('Rata-rata lompatan %0.0f frame/proses \n',...
    str2double(get(handles.txtfrmke,'string'))/totalframe);

% Atur seluruh objek yang ada pada GUI
if handles.pratampil == false
    set(handles.btnpratampil,'Cdata',imread('eyeA.png'),'enable','on');
else
    set(handles.btnpratampil,'Cdata',imread('eyeHA.png'),'enable','on');
end
set(handles.btnrun,'Cdata',imread('runA.png'),'enable','on');
set(handles.btnkamera,'Cdata',imread('configA.png'),'enable','on');
set(handles.btnreset,'Cdata',imread('resetA.png'),'enable','on');
set(handles.btnclose,'Cdata',imread('closeA.png'),'enable','on');
set(handles.btnstop,'Cdata',imread('stopTA.png'),'enable','inactive');

set(handles.pupoperator,'enable','on');
set(handles.pupalgoritma,'enable','on');
set(handles.puptoolbox,'enable','on');
set(handles.pupframe,'enable','on');
set(handles.pupjalur,'enable','on');

set(handles.tbsimpulroi,'enable','on');
set(handles.tbsimpan,'enable','on');

set(handles.txtlmtfrm,'enable','on');

% Update Handles Structure
guidata(hObject,handles)


% --- Executes on button press in btnclose.
function btnclose_Callback(hObject, eventdata, handles)
% hObject    handle to btnclose (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.status,'String','[PROSES] Keluar...');
jawab = questdlg('Apakah anda yakin ingi keluar?', ...
    'Keluar', ...
    'Ya','Tidak','Tidak');
switch jawab
    case 'Ya'
        delete(imaqfind);
        cla;clc;
        set(handles.status,'String','[OK] Keluar');
        close all;
        close();
    case 'Tidak'
        return
end


% --- Executes on button press in btnstop.
function btnstop_Callback(hObject, eventdata, handles)
% hObject    handle to btnstop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.status,'String','[PROSES] Berhenti...');
% Cek apakah vid masih kosong
if handles.vid == 0
    set(handles.status,'String','[INFO] Tidak ada video yang diputar!');
    msgbox('Tidak ada video yang diputar!','Pemberitahuan','warn')
    return
else
    stoppreview(handles.vid)
end
set(handles.status,'String','[OK] Berhenti');


% --- Executes on button press in btnreset.
function btnreset_Callback(hObject, eventdata, handles)
% hObject    handle to btnreset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

jawab = questdlg('Apakah anda yakin ingi reset?', ...
    'Reset', ...
    'Ya','Tidak','Tidak');
switch jawab
    case 'Ya'
        % Atur seluruh objek pada GUI
        axes(handles.fighasil); % Persipakan AXES 1
        imshow(handles.layout1); % Menampilkan layout AXES 1
        axes(handles.figpratampil); % Persipakan AXES 2
        imshow(handles.layout2, [], 'XData', [0 1], 'YData', [0 .5]);
        set(handles.panelkamera,'visible','on');
        
        set(handles.btnkamera,'Cdata',imread('configTA.png'),'enable','inactive');
        set(handles.btnpratampil,'Cdata',imread('eyeTA.png'),'enable','inactive');
        set(handles.btnrun,'Cdata',imread('runTA.png'),'enable','inactive');
        set(handles.btnstop,'Cdata',imread('stopTA.png'),'value',0,'enable','inactive');
        set(handles.btnreset,'Cdata',imread('resetTA.png'),'enable','inactive');
        
        set(handles.pupoperator,'string',handles.opsi_operator,'enable','off');
        set(handles.pupalgoritma,'string',handles.opsi_algoritma,'enable','off');
        set(handles.puptoolbox,'string',handles.opsi_toolbox,'enable','off');
        set(handles.pupframe,'string',handles.opsi_frame,'enable','off');
        set(handles.pupjalur,'string',handles.opsi_jalur,'enable','off');
        
        set(handles.tbsimpulroi,'value',0,'enable','off');
        set(handles.tbsimpan,'value',0,'enable','off');
        
        set(handles.txtfrmdeteksi,'String','0');
        set(handles.txttotalfrm,'String','0');
        set(handles.txtfrmke,'String','0');
        
        set(handles.waktuproses,'String','0');
        set(handles.status,'String','[PROSES] Reset...');
        set(handles.txtnamakam,'string','Kamera'); % Reset informasi
        set(handles.txtinfo,'string','Tidak tersedia'); % Reset informasi
        set(handles.txtlmtfrm,'enable','off');
        
        handles.cam_adaptor = 0; handles.vid = 0; handles.vidRes = 0;
        delete(imaqfind); % Menghapus kamera yang digunakan
        clc
        set(handles.status,'String','[OK] Reset');
    case 'Tidak'
        return
end

% Update Handles Structure
guidata(hObject,handles);


% --- Executes on button press in btnpratampil.
function btnpratampil_Callback(hObject, eventdata, handles)
% hObject    handle to btnpratampil (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if handles.pratampil == false
    % Mendapatkan Properti Video
    if handles.vidRes == 0
        set(handles.status,'String','[INFO] Silakan lakukan pengaturan kamera!');
        msgbox('Silakan lakukan pengaturan kamera!','Pemberitahuan','help')
        return
    end
    set(handles.status,'String','[PROSES] Pratampil...');
    pratampil = image(zeros(handles.vidRes(2),handles.vidRes(1),handles.nBands),...
        'Parent',handles.figpratampil); % Axes 2
    preview(handles.vid,pratampil); % Preview Webcam
    set(handles.status,'String','[OK] Pratampil');
    set(handles.btnpratampil,'Cdata',imread('eyeHA.png'));
    handles.pratampil = true;
else
    % Mempersiapkan Layout pada FIGPRATAMPIL
    stoppreview(handles.vid);
    axes(handles.figpratampil);
    imshow(handles.layout2, [], 'XData', [0 1], 'YData', [0 .5]);
    set(handles.btnpratampil,'Cdata',imread('eyeA.png'));
    handles.pratampil = false;
end

% Update handles structure
guidata(hObject,handles);


% --- Executes on button press in btninfo.
function btninfo_Callback(hObject, eventdata, handles)
% hObject    handle to btninfo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.status,'String','[PROSES] Konfigurasi Kamera...');
tentang;


% --- Executes on button press in btnhelp.
function btnhelp_Callback(hObject, eventdata, handles)
% hObject    handle to btnhelp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.status,'String','[PROSES] Cara menggunakan...');
cara;


function txtlmtfrm_Callback(hObject, eventdata, handles)
% hObject    handle to txtlmtfrm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of txtlmtfrm as text
%        str2double(get(hObject,'String')) returns contents of txtlmtfrm as a double


% --- Executes during object creation, after setting all properties.
function txtlmtfrm_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtlmtfrm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pupframe.
function pupframe_Callback(hObject, eventdata, handles)
% hObject    handle to pupframe (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pilih = get(hObject,'Value');
if pilih == 1
    set(handles.txtlmtfrm,'string','500','enable','on');
else
    set(handles.txtlmtfrm,'string','9999999','enable','off');
end

% Update handles structure
guidata(hObject,handles);


% --- Executes on selection change in pupoperator.
function pupoperator_Callback(hObject, eventdata, handles)
% hObject    handle to pupoperator (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pupoperator contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pupoperator


% --- Executes during object creation, after setting all properties.
function pupoperator_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pupoperator (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pupalgoritma.
function pupalgoritma_Callback(hObject, eventdata, handles)
% hObject    handle to pupalgoritma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pupalgoritma contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pupalgoritma


% --- Executes during object creation, after setting all properties.
function pupalgoritma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pupalgoritma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in puptoolbox.
function puptoolbox_Callback(hObject, eventdata, handles)
% hObject    handle to puptoolbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns puptoolbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from puptoolbox


% --- Executes during object creation, after setting all properties.
function puptoolbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to puptoolbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function pupframe_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pupframe (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pupjalur.
function pupjalur_Callback(hObject, eventdata, handles)
% hObject    handle to pupjalur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pupjalur contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pupjalur


% --- Executes during object creation, after setting all properties.
function pupjalur_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pupjalur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function pupkecepatan_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pupkecepatan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

