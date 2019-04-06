function [cam_adaptor, cam_id, cam_resolusi] = cvKamera(x, opsi)
% Mencari perangkat camera yang masih berjalan
cam_aktif = imaqfind;
% Mematikan perangkat camera yang masih berjalan
delete(cam_aktif);
if opsi == 2
    % Memeriksa adaptor yang terpasang
    cam_adaptor = (x.InstalledAdaptors);
    % Menu adapator
    cam_menu = menu('Pilih adaptor:',cam_adaptor);
    if isempty(cam_adaptor) || cam_menu==0
        msgbox({'Tidak ada opsi yang terpilih!'})
        return
    end
    % Mencari Adaptor yang terpilih
    cam_adaptor = char(cam_adaptor);
    cam_adaptor = cam_adaptor(cam_menu,:);
    cam_adaptor(cam_menu=='') = [];
    cam = imaqhwinfo(cam_adaptor);
    
    % Mencari ID, Resolusi pada perangkat
    try
        cam_id = menu('Pilih Device ID:',cam.DeviceInfo.DeviceName);
        res = cam.DeviceInfo(cam_id).SupportedFormats;
        res_menu = menu('Pilih Resolusi:',res);
        cam_resolusi = res{res_menu};
    catch
        warndlg({'Pilih Device ID yang lain';...
            'Device yang dipilih tidak terpasang'})
        return
    end
else
    cam_adaptor = char(x.InstalledAdaptors(end));
    cam = imaqhwinfo(cam_adaptor,2);
    cam_id = cam.DeviceID(end);
    cam_resolusi = char(cam.SupportedFormats(end-1));
end
