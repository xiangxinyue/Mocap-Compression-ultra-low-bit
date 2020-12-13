% --- Executes on press Encode button

function gui_encode_dwt_mocap(hObject, eventdata, handles)

% hObject    handle to pushbutton1 (see GCBO)
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
% % Select .amc file to read mocap data
defaultFileName = fullfile(pathip, '*.amc');
[fnameAMCip, pathipAMC, FilterIndex] = uigetfile(defaultFileName,...
    'Select an .amc file to compress its MoCap data');
if fnameAMCip == 0
    return;
end

statusStr= get(handles.edit_status,'String');
statusStr='Please wait, [Reading MoCap data from ACM file]';
set(handles.edit_status,'String',statusStr); drawnow();

fnameAMCipfull=fullfile(pathipAMC,fnameAMCip);
[channels, skel] = acclaimLoadChannels(fnameAMCipfull, skel);

statusStr= get(handles.edit_status,'String');
statusStr='Done, [Reading MoCap data from ACM file]';
set(handles.edit_status,'String',statusStr); drawnow();

[frameCount, channelCount]=size(channels);
% % ---------------------------------------------------------------
msgStr= get(handles.edit_main_msgs,'String');
strTmp = sprintf('Input Skeleton and its Hierarchy File Name = %s',fnameASF);
msgStr{end+1}=strTmp;
strTmp = sprintf('Input Data File Name = %s',fnameAMCip);
msgStr{end+1}=strTmp;
strTmp = sprintf('Number of Frames = %g',frameCount);
msgStr{end+1}=strTmp;
strTmp = sprintf('Number of  Channels = %g',channelCount);
msgStr{end+1}=strTmp;
strTmp = sprintf('Number of Joints = %g',jointCount);
msgStr{end+1}=strTmp;
set(handles.edit_main_msgs,'String',msgStr); drawnow();
% % ---------------------------------------------------------------
% % % Input parameters of compression
Tg = handles.Tg;
lev = handles.lev;
wtyp = handles.wtyp;
keepapp = handles.keepapp;
R = handles.R;
Q = handles.Q;
% % ---------------------------------------------------------------
% % % Encoding
statusStr= get(handles.edit_status,'String');
statusStr='Please wait, [Encoding MoCap data by DWT]';
set(handles.edit_status,'String',statusStr); drawnow();

tic
[stru, lxd, cxdLength] = encode_mocap_dwt(channels, skel, Tg,lev,wtyp,keepapp,R,Q); 
timeEncode = toc;

statusStr= get(handles.edit_status,'String');
statusStr='Done, [Encoding MoCap data by DWT]';
set(handles.edit_status,'String',statusStr); drawnow();

msgStr= get(handles.edit_main_msgs,'String');
strTmp = sprintf('Encoding Time = %g second(s)',timeEncode);
msgStr{end+1}=strTmp;
set(handles.edit_main_msgs,'String',msgStr); drawnow();
% % ---------------------------------------------------------------
% % Saving encoded data            
statusStr= get(handles.edit_status,'String');
statusStr='Please wait, [Saving encoded data to output file]';
set(handles.edit_status,'String',statusStr); drawnow();

fstr1='_Tg';
fstr2=strcat('_',wtyp,'_lev',num2str(lev));
pathop=pathipAMC; %path of o/p file
fnT=getfilenamewithourext(fnameAMCip); %fnameAMCip without extension
fnameMAT=strcat(fnT,fstr1,num2str(Tg),fstr2,'.mat');
fnameMATfull=fullfile(pathop,fnameMAT);
fnameAMCop=strcat(fnT,fstr1,num2str(Tg),fstr2,'.amc');
fnameAMCopfull=fullfile(pathop,fnameAMCop);

[jnameAMC]=readjointnamesfromamcfile(fnameAMCipfull);

% [idM] = jointsMatch_ASF_AMC(skel, jnameAMC);
% save(fnameMATfull,'stru','lxd','frameCount','R',...
%     'cxdLength','wtyp','idM'); %Saving Encoded Data

[snM] = jointsMatchSNoASFAMC(skel, jnameAMC);
save(fnameMATfull,'stru','lxd','frameCount','R',...
    'cxdLength','wtyp','snM'); %Saving Encoded Data

statusStr= get(handles.edit_status,'String');
statusStr='Done, [Saving encoded data to output file]';
set(handles.edit_status,'String',statusStr); drawnow();
% % ---------------------------------------------------------------
% % %  Analysis
statusStr= get(handles.edit_status,'String');
statusStr='Please wait, [Analysing results]';
set(handles.edit_status,'String',statusStr); drawnow();

[CR,bit1,bit2]=sizeandratio2files(pathipAMC,pathop,fnameAMCip,fnameMAT); %compression ratio
[channelsAprx] = decode_mocap_dwt(stru,lxd,cxdLength,wtyp);

% % % xyz(p,t,d): positional data of pth joint, th frame, dth dimension
% % % For analysis (not for fitting) channels data to positional data
xyz = acclaim2xyzallfrm(skel,channels);   % convert original channels data to positional data
xyzi = acclaim2xyzallfrm(skel,channelsAprx); % convert approximated channels data to positional data
MSE=msqerr(xyz,xyzi); %mean square error b/w xyz & xyzi
distortion=distortion_EuclidianDistance(MSE);
bpsOrg=bit1/(frameCount*channelCount); %bits per sample original
bps=bit2/(frameCount*channelCount); %bits per sample compressed
% % ---------------------------------------------------------------
msgStr= get(handles.edit_main_msgs,'String');
strTmp = sprintf('Wavelet Name  = %s',wtyp);
msgStr{end+1}=strTmp;
strTmp = sprintf('Wavelet Decomposition Level = %g',lev);
msgStr{end+1}=strTmp;
strTmp = sprintf('Size of Input Data File  = %d bits',bit1);
msgStr{end+1}=strTmp;
strTmp = sprintf('Size of Output Data File  = %d bits',bit2);
msgStr{end+1}=strTmp;
strTmp = sprintf('Length of Run for run-length coding  = %d',R);
msgStr{end+1}=strTmp;
strTmp = sprintf('Bits per sample original = %g',bpsOrg);
msgStr{end+1}=strTmp;
strTmp = sprintf('Bits per sample compressed = %g',bps);
msgStr{end+1}=strTmp;
strTmp = sprintf('Global Wavelet Threshold Tg = %g',Tg);
msgStr{end+1}=strTmp;
strTmp = sprintf('Compression Ratio CR = %g',CR);
msgStr{end+1}=strTmp;
strTmp = sprintf('Distortion d = %g',distortion);
msgStr{end+1}=strTmp;
strTmp = sprintf('Output Encoded File Name = %s',fnameMAT);
msgStr{end+1}=strTmp;

strTmp = sprintf('----------------------------------------');
msgStr{end+1}=strTmp;
set(handles.edit_main_msgs,'String',msgStr); drawnow();

statusStr= get(handles.edit_status,'String');
statusStr='Done, [Encoding & Analysis]';
set(handles.edit_status,'String',statusStr); drawnow();


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
