% --- Executes on press Encode button

function gui_encode_qbc_mocap(hObject, eventdata, handles)

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
MxAllowSqD = handles.MxAllowSqD;
Delta = handles.Delta;
Q = handles.Q;
ibi=unique([1:Delta:frameCount,frameCount]);
% % ibi is "initial break points indices". It is NOT same as Delta
% % ibi can be computed from Delta as shown above
% % ---------------------------------------------------------------
% % % Encoding
statusStr= get(handles.edit_status,'String');
statusStr='Please wait, [Encoding MoCap data by QBC]';
set(handles.edit_status,'String',statusStr); drawnow();

tic
[stru]=encoder_qbc(skel, channels, MxAllowSqD, ibi, Q);
timeEncode = toc;

statusStr= get(handles.edit_status,'String');
statusStr='Done, [Encoding MoCap data by QBC]';
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

fstr1=strcat('_MxSqD',num2str(MxAllowSqD));
fstr2=strcat('_Delta',num2str(Delta));
pathop=pathipAMC; %path of o/p file
fnT=getfilenamewithourext(fnameAMCip); %fnameAMCip without extension
fnameMAT=strcat(fnT,fstr1,fstr2,'.mat');
fnameMATfull=fullfile(pathop,fnameMAT);
fnameAMCop=strcat(fnT,fstr1,fstr2,'.amc');
fnameAMCopfull=fullfile(pathop,fnameAMCop);

[jnameAMC]=readjointnamesfromamcfile(fnameAMCipfull);
[snM] = jointsMatchSNoASFAMC(skel, jnameAMC);
save(fnameMATfull,'stru','frameCount','snM'); %Saving Encoded Data

statusStr= get(handles.edit_status,'String');
statusStr='Done, [Saving encoded data to output file]';
set(handles.edit_status,'String',statusStr); drawnow();
% % ---------------------------------------------------------------
% % %  Analysis
statusStr= get(handles.edit_status,'String');
statusStr='Please wait, [Analysing results]';
set(handles.edit_status,'String',statusStr); drawnow();

[CR,bit1,bit2]=sizeandratio2files(pathipAMC,pathop,fnameAMCip,fnameMAT); %compression ratio


startendAry=jointindxinchannels(skel);
[channelsAprx]=decoder_qbc(startendAry, frameCount, stru);

% % % xyz(p,t,d): positional data of pth joint, th frame, dth dimension
% % % For analysis (not for fitting) channels data to positional data
xyz = acclaim2xyzallfrm(skel,channels);   % convert original channels data to positional data
xyzi = acclaim2xyzallfrm(skel,channelsAprx); % convert approximated channels data to positional data
MSE=msqerr(xyz,xyzi); %mean square error b/w xyz & xyzi
% % ---------------------------------------------------------------
msgStr= get(handles.edit_main_msgs,'String');
strTmp = sprintf('Size of Input Data File  = %d bits',bit1);
msgStr{end+1}=strTmp;
strTmp = sprintf('Size of Output Data File  = %d bits',bit2);
msgStr{end+1}=strTmp;
strTmp = sprintf('Initial breakpoint interval Delta = %g',Delta);
msgStr{end+1}=strTmp;
strTmp = sprintf('Maximum allowed squared distance MxAllowSqD = %g',MxAllowSqD);
msgStr{end+1}=strTmp;
strTmp = sprintf('Compression Ratio CR = %g',CR);
msgStr{end+1}=strTmp;
strTmp = sprintf('Mean square error MSE = %g',MSE);
msgStr{end+1}=strTmp;
strTmp = sprintf('Output Encoded File Name = %s',fnameMAT);
msgStr{end+1}=strTmp;

strTmp = sprintf('----------------------------------------------------');
msgStr{end+1}=strTmp;
set(handles.edit_main_msgs,'String',msgStr); drawnow();

statusStr= get(handles.edit_status,'String');
statusStr='Done, [Encoding & Analysis]';
set(handles.edit_status,'String',statusStr); drawnow();


% % % ---------------------------------------------------------------
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
