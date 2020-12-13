% % Get channel data of a specified frame of specified joint from
% % channels matrix

% % INPUT 
% % channels: channel data of all joints
% % skel:     skeleton hierarchy
% % sno:      serial number of joint in skel whose data is to be extracted
% %           from channels matrix
% % fno:      frame no whose data is to be extracted

% % OUTPUT
% % mat: data of specified joint 

function mat=getjointdataofaframe(channels,skel,sno,fno)
mat=[];
startendAry=jointindxinchannels(skel);
mat=channels(fno, startendAry(sno,1):startendAry(sno,2));

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




