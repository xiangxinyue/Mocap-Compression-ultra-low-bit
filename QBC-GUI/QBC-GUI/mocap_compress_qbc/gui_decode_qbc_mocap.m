% --- Executes on press Decode button

function gui_decode_qbc_mocap(hObject, eventdata, handles)

% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% % ---------------------------------------------------------------
% For convenience in browsing, set a starting folder from which to browse.
pathip = '';
if ~exist(pathip, 'dir')
    % If that folder doesn't exist, just start in the current folder.
    pathip = pwd;
end
% % ---------------------------------------------------------------
% Select an .asf file to read skeleton & hierarchy
defaultFileName = fullfile(pathip, '*.asf');
[fnameASF, pathipASF, FilterIndex] = uigetfile(defaultFileName,...
    'Select an .asf file to read skeleton & hierarchy');
if fnameASF == 0
    return;
end

statusStr= get(handles.edit_status,'String');
statusStr='Please wait, [Reading skeleton & hierarchy from ASF file]';
set(handles.edit_status,'String',statusStr); drawnow();

fnameASFfull=fullfile(pathipASF,fnameASF);
skel = acclaimReadSkel(fnameASFfull);
jointCount=length(skel.tree);

statusStr= get(handles.edit_status,'String');
statusStr='Done, [Reading skeleton & hierarchy from ASF file]';
set(handles.edit_status,'String',statusStr); drawnow();
% % ---------------------------------------------------------------
% Select .mat file to read encoded data
defaultFileName = fullfile(pathip, '*.mat');
[fnameMAT, pathop, FilterIndex] = uigetfile(defaultFileName,...
    'Select a .mat file to decode (de-compress) it to .amc file');

if fnameMAT == 0
    return;
end

statusStr= get(handles.edit_status,'String');
statusStr='Please wait, [Reading encoded data from ASF file]';
set(handles.edit_status,'String',statusStr); drawnow();

fnameMATfull = fullfile(pathop, fnameMAT);
load(fnameMATfull); %read data from input file

statusStr= get(handles.edit_status,'String');
statusStr='Done, [Reading encoded data from ASF file]';
set(handles.edit_status,'String',statusStr); drawnow();

% % ---------------------------------------------------------------
msgStr= get(handles.edit_main_msgs,'String');
strTmp = sprintf('Input Skeleton and its Hierarchy File Name = %s',fnameASF);
msgStr{end+1}=strTmp;
strTmp = sprintf('Encoded Data File Name = %s',fnameMAT);
msgStr{end+1}=strTmp;
strTmp = sprintf('Number of Frames = %g',frameCount);
msgStr{end+1}=strTmp;
strTmp = sprintf('Number of Joints = %g',jointCount);
msgStr{end+1}=strTmp;
set(handles.edit_main_msgs,'String',msgStr); drawnow();

% % ---------------------------------------------------------------
% % % Decoding
statusStr= get(handles.edit_status,'String');
statusStr='Please wait, [Decoding MoCap data by QBC]';
set(handles.edit_status,'String',statusStr); drawnow();

tic
startendAry=jointindxinchannels(skel);
[channelsAprx]=decoder_qbc(startendAry, frameCount, stru);
timeDecode=toc;

statusStr= get(handles.edit_status,'String');
statusStr='Done, [Decoding MoCap data by QBC]';
set(handles.edit_status,'String',statusStr); drawnow();

msgStr= get(handles.edit_main_msgs,'String');
strTmp = sprintf('Decoding Time  = %g second(s)',timeDecode);
msgStr{end+1}=strTmp;
set(handles.edit_main_msgs,'String',msgStr); drawnow();

% % ---------------------------------------------------------------
[frameCount, channelCount]=size(channelsAprx);
msgStr= get(handles.edit_main_msgs,'String');
strTmp = sprintf('Number of  Channels = %g',channelCount);
msgStr{end+1}=strTmp;
set(handles.edit_main_msgs,'String',msgStr); drawnow();
% % ---------------------------------------------------------------
% % writting aprox data in .amc file
statusStr= get(handles.edit_status,'String');
statusStr='Please wait, [Creating approximate ACM file from decoded data]';
set(handles.edit_status,'String',statusStr); drawnow();

fnT=getfilenamewithourext(fnameMAT);
fnameAMCop=strcat(fnT,'.amc');
fnameAMCopfull = fullfile(pathop, fnameAMCop);


tic
writechannels2amcfile(fnameAMCopfull,channelsAprx,skel,snM);
timeWriteACM=toc;

statusStr= get(handles.edit_status,'String');
statusStr='Done, [Creating approximate ACM file from decoded data]';
set(handles.edit_status,'String',statusStr); drawnow();

msgStr= get(handles.edit_main_msgs,'String');
strTmp = sprintf('Time for Creating approximate ACM file = %g second(s)',timeWriteACM);
msgStr{end+1}=strTmp;
set(handles.edit_main_msgs,'String',msgStr); drawnow();
% % ---------------------------------------------------------------
msgStr= get(handles.edit_main_msgs,'String');
strTmp = sprintf('Output Decoded (Reconstructed) Data File Name = %s',fnameAMCop);
msgStr{end+1}=strTmp;
strTmp = sprintf('----------------------------------------------------');
msgStr{end+1}=strTmp;
set(handles.edit_main_msgs,'String',msgStr); drawnow();
% % ---------------------------------------------------------------

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
