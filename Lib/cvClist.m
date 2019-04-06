function varargout = cvClist
% Menampilkan citra yang disediakan oleh matlab
% Tidak perlu memindahkan File ke dalam folder yang sama dengan file .m
% anda, Contoh Penggunaan:
%   C = imread('nama_file');
%   C = imread('eight.tif');

pth = fileparts(which('cameraman.tif'));
D = dir(pth);
C = {'.tif';'.jp';'.png';'.bmp'};
idx = false(size(D));
for ii = 1:length(C)
    idx = idx | (arrayfun(@(x) any(strfind(x.name,C{ii})),D));
end
D = D(idx);
for ii = 1:numel(D)
    fprintf('%s\n',D(ii).name)
end
if nargout, varargout{1}=pth;
end