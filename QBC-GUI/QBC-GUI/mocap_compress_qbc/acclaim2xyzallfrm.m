% % See also acclaim2xyz.m

% % INPUT:
% %	skel:     the tree structure of the skeleton.
% %	channels: the channels of the data read in.

% % OUTPUT: xyz contains 3-D position of joints such that
% %         xyz(p,t,d): positional data of pth joint, th frame, dth
% %         dimension
% % 
% %         xyz(p,t,1): x positional data pth joint of th frame
% %         xyz(p,t,2): y positional data pth joint of th frame
% %         xyz(p,t,3): z positional data pth joint of th frame

function xyz = acclaim2xyzallfrm(skel,channels)

% % r: (rows) frame count
[r c]=size(channels);

for t=1:r
      xyz(:,t,:) = acclaim2xyz(skel, channels(t,:));
end

% % % ---------------------------------------------------------------
% % Reference of acclaim2xyz.m
% Lawrence, N. D. "Mocap toolbox for matlab." Available on-line at
% http://www. cs. man. ac. uk/neill/mocap 136 (2011).
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


