% Mempersiapkan kamera/webcam
cam = imaqhwinfo;
opsi_kamera = [{'Otomatis'} {'Manual'}]; % 1. Default 2. Pilih
kamera_menu = menu('Pilih pengaturan kamera:',opsi_kamera);
if isempty(kamera_menu) || kamera_menu==0
    Status = ('> Berhenti');
    msgbox({'Tidak ada opsi yang terpilih!'})
    return
end

% Mempersiapkan nama, device id dan resolusi kamera yang akan digunakan
[adaptor, id, res] = cvKamera(cam, kamera_menu);

% Deklarasi variabel 'vid' sebagai input video
vid = videoinput(adaptor, id, res);
set(vid, 'FramesPerTrigger', Inf);
set(vid, 'TriggerRepeat', Inf);
set(vid, 'ReturnedColorspace', 'rgb')
vid.FrameGrabInterval = 35;
% triggerconfig(vid, 'manual'); % membuat ekstraksi frame lebih cepat.
preview(vid)
