function varargout = show_pic_ber(varargin)
% SHOW_PIC_BER MATLAB code for show_pic_ber.fig
%      SHOW_PIC_BER, by itself, creates a new SHOW_PIC_BER or raises the existing
%      singleton*.
%
%      H = SHOW_PIC_BER returns the handle to a new SHOW_PIC_BER or the handle to
%      the existing singleton*.
%
%      SHOW_PIC_BER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SHOW_PIC_BER.M with the given input arguments.
%
%      SHOW_PIC_BER('Property','Value',...) creates a new SHOW_PIC_BER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before show_pic_ber_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to show_pic_ber_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help show_pic_ber

% Last Modified by GUIDE v2.5 14-Sep-2016 10:14:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @show_pic_ber_OpeningFcn, ...
                   'gui_OutputFcn',  @show_pic_ber_OutputFcn, ...
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



% --- Executes just before show_pic_ber is made visible.
function show_pic_ber_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to show_pic_ber (see VARARGIN)

% Choose default command line output for show_pic_ber
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes show_pic_ber wait for user response (see UIRESUME)
% uiwait(handles.figure1);

gui_variables.snr = 0;
gui_variables.fileName = 'sample.avi';
gui_variables.skipTime = 5;
gui_variables.conMode = true;





% --- Outputs from this function are returned to the command line.
function varargout = show_pic_ber_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in startBt.
function startBt_Callback(hObject, eventdata, handles)
% hObject    handle to startBt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% get data value
gui_variables.snr = str2num(get(handles.snrField,'String'));
gui_variables.fileName = get(handles.fileNameField,'String');
gui_variables.skipTime = str2num(get(handles.skipField,'String'));
gui_variables.conMode  = get(handles.conCheck, 'Value');

gui_load_video(gui_variables, handles);


function conCheck_Callback(hObject, eventdata, handles)
% hObject    handle to startBt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


function snrField_Callback(hObject, eventdata, handles)
% hObject    handle to snrField (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of snrField as text
%        str2double(get(hObject,'String')) returns contents of snrField as a double




% --- Executes during object creation, after setting all properties.
function snrField_CreateFcn(hObject, eventdata, handles)
% hObject    handle to snrField (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in selectBt.
function selectBt_Callback(hObject, eventdata, handles)
% hObject    handle to selectBt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[name, path] = uigetfile('*.avi', 'video file');
if isequal(name, 0) || isequal(path, 0)
    fileName = '';
else
    fileName = [path name];
end
set(handles.fileNameField, 'string', fileName);
setappdata(0,'fileName', fileName);


function skipField_Callback(hObject, eventdata, handles)
% hObject    handle to skipField (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of skipField as text
%        str2double(get(hObject,'String')) returns contents of skipField as a double


% --- Executes during object creation, after setting all properties.
function skipField_CreateFcn(hObject, eventdata, handles)
% hObject    handle to skipField (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes2


% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes2



function gui_load_video(gui_variables, handles)

snr = gui_variables.snr;
fileName = gui_variables.fileName;
skipTime = gui_variables.skipTime; % skip the first few seconds



%hEnc = comm.LDPCEncoder; %not using them as we have .mexw64 files
hMod = comm.PSKModulator(4, 'BitInput',true);
hChan = comm.AWGNChannel(...
            'NoiseMethod','Signal to noise ratio (SNR)','SNR',snr);
hDemod = comm.PSKDemodulator(4, 'BitOutput',true,...
            'DecisionMethod','Approximate log-likelihood ratio', ...
            'Variance', 1/10^(hChan.SNR/10));
%hDec = comm.LDPCDecoder; %not using them as we have .mexw64 files


%% setting the reading of the picture
avi_obj=VideoReader(fileName);
y = avi_obj.Height; 
x = avi_obj.Width;
c = avi_obj.BitsPerPixel/8; % channels of picture
b = 8; % bit per channel

receivedPic = uint8(zeros(y*x*c*b,1));
decodedPic = uint8(zeros(y*x*c*b,1));

%% processing
i = 0; %frame count
avi_obj.CurrentTime = skipTime; % start processing from the middle
k = 336; l = 672; % half rate 11ad LDPC, each time 336 bit is take for encoding, encoded into 672 bits.
pic_size = floor(y*x*c*b/k); %nb LDPC_frames
while hasFrame(avi_obj)
    i = i+1;
    pic = readFrame(avi_obj);
    
    bit_pic = pic2bit(pic, y, x, c, b); %% in bitwise picture
    
    % processing a picture frame
    for block = 1:pic_size,
          %fprintf('%d ',block);
          encodedData    = encoder(1, bit_pic(block*k-k+1:block*k));
          modSignal      = step(hMod, encodedData);
          receivedSignal = step(hChan, modSignal);
          demodSignal    = step(hDemod, receivedSignal);
          receivedBits   = decoder(1, demodSignal);
          
          temp    =  (demodSignal<0); % hard-decison decoding
          receivedPic(block*k-k+1:block*k) = temp(1:k);
          
          decodedPic(block*k-k+1:block*k)    =  receivedBits(1:k); % LDPC decoding
    end;
    
    % convert to Matlab format and plot 
    re_pic = bit2pic(receivedPic, y, x, c, b); % received video    
    de_pic = bit2pic(decodedPic, y, x, c, b); % decoded Pic
    
    axes(handles.axes1);
    imshow(pic),
    title(sprintf('Frame %d',i ));
    drawnow;
    
    axes(handles.axes2);
    imshow(re_pic),
    title(sprintf('Frame %d; SNR = %.2f dB',i, hChan.SNR));
    drawnow;
    
    axes(handles.axes3);
    imshow(de_pic),
    title(sprintf('Frame %d',i));
    drawnow;
    
    gui_variables.conMode = get(handles.conCheck, 'Value');
    if (~gui_variables.conMode),
        break;
    end
end
