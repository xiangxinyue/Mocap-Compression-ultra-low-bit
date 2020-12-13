function varargout = mainguiqbc(varargin)
% MAINGUIQBC MATLAB code for mainguiqbc.fig
%      MAINGUIQBC, by itself, creates a new MAINGUIQBC or raises the existing
%      singleton*.
%
%      H = MAINGUIQBC returns the handle to a new MAINGUIQBC or the handle to
%      the existing singleton*.
%
%      MAINGUIQBC('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAINGUIQBC.M with the given input arguments.
%
%      MAINGUIQBC('Property','Value',...) creates a new MAINGUIQBC or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mainguiqbc_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mainguiqbc_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mainguiqbc

% Last Modified by GUIDE v2.5 08-Feb-2017 11:16:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mainguiqbc_OpeningFcn, ...
                   'gui_OutputFcn',  @mainguiqbc_OutputFcn, ...
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


% --- Executes just before mainguiqbc is made visible.
function mainguiqbc_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mainguiqbc (see VARARGIN)

% Choose default command line output for mainguiqbc
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mainguiqbc wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% % ---------------------------------------------------------------
% % change current directory (cd) to the folder of this script
if(~isdeployed)
    cd(fileparts(which(mfilename)));
end
% % ---------------------------------------------------------------
% % Message at the launch of application
codingSteps{1}='Encoding Steps';
codingSteps{end+1}='Step 1 (Optional): Enter the value of maximum allowed squared distance';
codingSteps{end+1}='Step 2 (Optional): Enter the value of break point interval (Delta)';
codingSteps{end+1}='Step 3: Press the button "Encode" ';
codingSteps{end+1}='Step 4: Select an .asf file to read skeleton & hierarchy';
codingSteps{end+1}='Step 5: Select an .amc file to compress its MoCap data';
codingSteps{end+1}='---------------------------------------------------------------------------';
codingSteps{end+1}='Decoding Steps';
codingSteps{end+1}='Step 1: Press the button "Decode" ';
codingSteps{end+1}='Step 2: Select an .asf file to read skeleton & hierarchy';
codingSteps{end+1}='Step 3: Select a .mat file to decode (de-compress) it to .amc file';

msgbox(codingSteps,'Encoding/Decoding Steps');
% % ---------------------------------------------------------------
% % get the default values of input parameters
[MxAllowSqD, Delta, Q] = default_parameters_qbc_mocap();
% % Storing input parameters as Global Data in the handles structure
handles.MxAllowSqD = MxAllowSqD;
handles.Delta = Delta;
handles.Q = Q;
guidata(hObject,handles);
% % ---------------------------------------------------------------
% % set default value to  text fields
set(handles.edit_MxAllowSqD,'String',num2str(handles.MxAllowSqD));
set(handles.edit_Delta,'String',num2str(handles.Delta));
% % ---------------------------------------------------------------

% --- Outputs from this function are returned to the command line.
function varargout = mainguiqbc_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



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



function edit_MxAllowSqD_Callback(hObject, eventdata, handles)
% hObject    handle to edit_MxAllowSqD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_MxAllowSqD as text
%        str2double(get(hObject,'String')) returns contents of edit_MxAllowSqD as a double

valMxAllowSqD  = str2double(get(handles.edit_MxAllowSqD,'String'));

if isnan(valMxAllowSqD)
    statusStr= get(handles.edit_status,'String');
    statusStr='Only numeric valaues are allowed for max. allowed square distance';
    set(handles.edit_status,'String',statusStr); drawnow(); 
    
    % % set value of MxAllowSqD to its default value
    [MxAllowSqD, Delta, Q] = default_parameters_qbc_mocap();
    handles.MxAllowSqD = MxAllowSqD;         
    set(handles.edit_MxAllowSqD,'String',num2str(handles.MxAllowSqD));
elseif isnumeric(valMxAllowSqD) & length(valMxAllowSqD)==1        
    handles.MxAllowSqD = valMxAllowSqD;        
    set(handles.edit_MxAllowSqD,'String',num2str(handles.MxAllowSqD));
    
    statusStr= get(handles.edit_status,'String');
    statusStr='Done, [Max. allowed square distance value]';
    set(handles.edit_status,'String',statusStr); drawnow(); 

end
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit_MxAllowSqD_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_MxAllowSqD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_encode.
function pushbutton_encode_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_encode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

gui_encode_qbc_mocap(hObject, eventdata, handles);

% --- Executes on button press in pushbutton_decode.
function pushbutton_decode_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_decode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

gui_decode_qbc_mocap(hObject, eventdata, handles);

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

saveResult_qbc_mocap(hObject, eventdata, handles);

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
dos('explorer http://link.springer.com/article/10.1007%2Fs11045-014-0293-4'); 

% % Message about the System
aboutSystem{1}='MATLAB Code of Compression of MoCap Data using QBC';
aboutSystem{end+1}='Reference:';
aboutSystem{end+1}='Murtaza Ali Khan, "An efficient algorithm for compression of motion capture signal using multidimensional quadratic Bezier  curve break-and-fit method", Multidimensional Systems and Signal Processing, Springer journal, January 2016 (first online 2014), Vol. 27, No. 1, pp 121-143';
aboutSystem{end+1}='DOI=10.1007/s11045-014-0293-4';
aboutSystem{end+1}='---------------------------------------------------------------------------';
aboutSystem{end+1}='Email: drkhanmurtaza@gmail.com';

msgbox(aboutSystem,'About the System');



function edit_Delta_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Delta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Delta as text
%        str2double(get(hObject,'String')) returns contents of edit_Delta as a double


valDelta = str2double(get(handles.edit_Delta,'String'));

if isnan(valDelta)
    statusStr= get(handles.edit_status,'String');
    statusStr='Only integer valaues greater than 0 are allowed for break point interval (Delta)';
    set(handles.edit_status,'String',statusStr); drawnow(); 
    
    % % set value of Delta to its default value
    [MxAllowSqD, Delta, Q] = default_parameters_qbc_mocap();
    handles.Delta = Delta;     
    set(handles.edit_Delta,'String',num2str(handles.Delta));    
elseif isnumeric(valDelta) & length(valDelta)==1
    valDelta = round(valDelta);
    
    if valDelta < 1
        valDelta = 1 %value of Delta should be greter than 0
    end    
    handles.Delta = valDelta;
    set(handles.edit_Delta,'String',num2str(handles.Delta));   
    
    statusStr= get(handles.edit_status,'String');
    statusStr='Done, [Break point interval (Delta)]';
    set(handles.edit_status,'String',statusStr); drawnow(); 

end
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit_Delta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Delta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% % % ---------------------------------------------------------------
% % Reference:
% % Reference:
% Murtaza Ali Khan, "An efficient algorithm for compression of motion
% capture signal using multidimensional quadratic Bezier  curve
% break-and-fit method", Multidimensional Systems and Signal Processing,
% Springer journal, August 2014,
% DOI 10.1007/s11045-014-0293-4.
% http://link.springer.com/article/10.1007/s11045-014-0293-4

% % Reference BibTeX
% @Article{Khan2014,
% author="Khan, Murtaza Ali",
% title="An efficient algorithm for compression of motion capture signal using multidimensional quadratic Bezier curve break-and-fit method",
% journal="Multidimensional Systems and Signal Processing",
% year="2014",
% volume="27",
% number="1",
% pages="121--143",
% issn="1573-0824",
% doi="10.1007/s11045-014-0293-4",
% url="http://dx.doi.org/10.1007/s11045-014-0293-4"
% }
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
