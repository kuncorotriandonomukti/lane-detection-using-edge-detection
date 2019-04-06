function varargout = tentang(varargin)
%TENTANG MATLAB code file for tentang.fig
%      TENTANG, by itself, creates a new TENTANG or raises the existing
%      singleton*.
%
%      H = TENTANG returns the handle to a new TENTANG or the handle to
%      the existing singleton*.
%
%      TENTANG('Property','Value',...) creates a new TENTANG using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to tentang_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      TENTANG('CALLBACK') and TENTANG('CALLBACK',hObject,...) call the
%      local function named CALLBACK in TENTANG.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help tentang

% Last Modified by GUIDE v2.5 02-Jun-2018 15:26:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @tentang_OpeningFcn, ...
                   'gui_OutputFcn',  @tentang_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before tentang is made visible.
function tentang_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

foto = imread('foto.jpg');
sk = imread('logosk.png');
kampus = imread('Kampus.png');
axes(handles.kampus);
imshow(kampus);
axes(handles.sk);
imshow(sk);
axes(handles.foto);
imshow(foto);

% Choose default command line output for tentang
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes tentang wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = tentang_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
