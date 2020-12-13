function varargout = gui_main_dwt(varargin)
% GUI_MAIN_DWT MATLAB code for gui_main_dwt.fig
%      GUI_MAIN_DWT, by itself, creates a new GUI_MAIN_DWT or raises the existing
%      singleton*.
%
%      H = GUI_MAIN_DWT returns the handle to a new GUI_MAIN_DWT or the handle to
%      the existing singleton*.
%
%      GUI_MAIN_DWT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_MAIN_DWT.M with the given input arguments.
%
%      GUI_MAIN_DWT('Property','Value',...) creates a new GUI_MAIN_DWT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_main_dwt_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_main_dwt_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_main_dwt

% Last Modified by GUIDE v2.5 02-Feb-2017 12:36:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @gui_main_dwt_OpeningFcn, ...
    'gui_OutputFcn',  @gui_main_dwt_OutputFcn, ...
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


% --- Executes just before gui_main_dwt is made visible.
function gui_main_dwt_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_main_dwt (see VARARGIN)

% Choose default command line output for gui_main_dwt
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_main_dwt wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% % ---------------------------------------------------------------
% % change current directory (cd) to the folder of this script
if(~isdeployed)
    cd(fileparts(which(mfilename)));
end
% % ---------------------------------------------------------------
% % Message at the launch of application
codingSteps{1}='Encoding Steps';
codingSteps{end+1}='Step 1: Set the value of Glogbal Threshold Tg';
codingSteps{end+1}='Step 2: Press the button "Encode" ';
codingSteps{end+1}='Step 3: Select an .asf file to read skeleton & hierarchy';
codingSteps{end+1}='Step 4: Select an .amc file to compress its MoCap data';
codingSteps{end+1}='---------------------------------------------------------------------------';
codingSteps{end+1}='Decoding Steps';
codingSteps{end+1}='Step 1: Press the button "Decode" ';
codingSteps{end+1}='Step 2: Select an .asf file to read skeleton & hierarchy';
codingSteps{end+1}='Step 3: Select a .mat file to decode (de-compress) it to .amc file';

msgbox(codingSteps,'Encoding/Decoding Steps');
% % ---------------------------------------------------------------
% % get the default values of input parameters
[Tg, lev, wtyp, keepapp, R, Q] = default_parameters_dwt_mocap();

% % Storing input parameters as Global Data in the handles structure
handles.Tg = Tg;
handles.lev = lev;
handles.wtyp = wtyp;
handles.keepapp = keepapp;
handles.R = R;
handles.Q = Q;
guidata(hObject,handles)
% % ---------------------------------------------------------------
% % set default value to Tg slider
set(handles.slider_Tg,'Value',handles.Tg);
% % set default value to Tg text field
set(handles.edit_Tg,'String',num2str(handles.Tg));
% % ---------------------------------------------------------------
% --- Outputs from this function are returned to the command line.
function varargout = gui_main_dwt_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_encode.
function pushbutton_encode_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_encode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

gui_encode_dwt_mocap(hObject, eventdata, handles);

% --- Executes on button press in pushbutton_decode.
function pushbutton_decode_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_decode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

gui_decode_dwt_mocap(hObject, eventdata, handles);


% --- Executes on slider movement.
function slider_Tg_Callback(hObject, eventdata, handles)
% hObject    handle to slider_Tg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

% % get the value of slider and round it
handles.Tg = round(get(handles.slider_Tg,'Value'));

% % set the text field value same as slider value
set(handles.edit_Tg,'String',num2str(handles.Tg));

guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function slider_Tg_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_Tg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit_Tg_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Tg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Tg as text
%        str2double(get(hObject,'String')) returns contents of edit_Tg as a double

val = str2double(get(handles.edit_Tg,'String'));

if isnumeric(val) & length(val)==1 & ...
        val >= get(handles.slider_Tg,'Min') & ...
        val <= get(handles.slider_Tg,'Max')
    val=round(val);
    set(handles.slider_Tg,'Value',val);
    
    handles.Tg = round(get(handles.slider_Tg,'Value'));
    guidata(hObject,handles)    
else
    statusStr= get(handles.edit_status,'String');
    statusStr='Only integer valaue [0 - 100] are allowed for global threshold (Tg)';
    set(handles.edit_status,'String',statusStr); drawnow();
    
    % % get the value of slider and round it
    handles.Tg = round(get(handles.slider_Tg,'Value'));
    % % set the text field value same as slider value
    set(handles.edit_Tg,'String',num2str(handles.Tg));
end

% --- Executes during object creation, after setting all properties.
function edit_Tg_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Tg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_main_msgs_Callback(hObject, eventdata, handles)
% hObject    handle to edit_main_msgs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_main_msgs as text
%        str2double(get(hObject,'String')) returns contents of edit_main_msgs as a double


% --- Executes during object creation, after setting all properties.
function edit_main_msgs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_main_msgs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function fileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to fileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function saveAnalysis_submenu_Callback(hObject, eventdata, handles)
% hObject    handle to saveAnalysis_submenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

statusStr= get(handles.edit_status,'String');
statusStr='Please wait, [Saving results and statistics to a text file]';
set(handles.edit_status,'String',statusStr); drawnow();

saveResult_dwt_mocap(hObject, eventdata, handles);

statusStr= get(handles.edit_status,'String');
statusStr='Done, [Saving results and statistics to a text file]';
set(handles.edit_status,'String',statusStr); drawnow();

% --------------------------------------------------------------------
function close_submenu_Callback(hObject, eventdata, handles)
% hObject    handle to close_submenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all;

% --------------------------------------------------------------------
function about_submenu_Callback(hObject, eventdata, handles)
% hObject    handle to about_submenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% % launch the website of referenced paper
dos('explorer http://dx.doi.org/10.1007/s11042-016-3944-7'); 

% % Message about the System
aboutSystem{1}='MATLAB Code of Compression of MoCap Data using DWT';
aboutSystem{end+1}='Reference:';
aboutSystem{end+1}='Murtaza Ali Khan, "Multiresolution coding of motion capture data for real-time multimedia applications", Multimedia Tools and Applications, Springer journal, First online pp 1-16, Sep. 2016.';
aboutSystem{end+1}='DOI=10.1007/s11042-016-3944-7';
aboutSystem{end+1}='---------------------------------------------------------------------------';
aboutSystem{end+1}='Email: drkhanmurtaza@gmail.com';

msgbox(aboutSystem,'About the System');
% --------------------------------------------------------------------

function edit_status_Callback(hObject, eventdata, handles)
% hObject    handle to edit_status (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_status as text
%        str2double(get(hObject,'String')) returns contents of edit_status as a double


% --- Executes during object creation, after setting all properties.
function edit_status_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_status (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% % % ---------------------------------------------------------------
% % Reference:
% Murtaza Ali Khan, "Multiresolution coding of motion capture data for
% real-time multimedia applications", Multimedia Tools and Applications,
% Springer journal, First online pp 1-16, Sep. 2016.
% DOI=10.1007/s11042-016-3944-7

% % Reference BibTeX
% % @Article{Khan2016,
% % author="Khan, Murtaza Ali",
% % title="Multiresolution coding of motion capture data for real-time multimedia applications",
% % journal="Multimedia Tools and Applications",
% % year="2016",
% % pages="1--16",
% % issn="1573-7721",
% % doi="10.1007/s11042-016-3944-7",
% % url="http://dx.doi.org/10.1007/s11042-016-3944-7"
% % }
% % % ---------------------------------------------------------------
% % This program or any other program(s) supplied with it do(es) not
% % provide any warranty direct or implied.
% % This program is free to use/share for non-commerical purpose only. 
% % Kindly reference the author.
% % Thanking you.
% % @ Copyright: Dr. Murtaza Ali Khan
% % Email: drkhanmurtaza@gmail.com
% % LinkedIn: http://www.linkedin.com/pub/dr-murtaza-khan/19/680/3b3
% % ResearchGate: http://www.researchgate.net/profile/Murtaza_Khan2/
% % % --------------------------------------------------------------- 
