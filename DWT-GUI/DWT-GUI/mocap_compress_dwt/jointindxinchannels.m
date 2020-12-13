% % MoCap data of all the channels is stored in 2D matrix channels.
% % Each row of channels matrix corresponds to a single complete frame, i.e.,
% % data of all the channels for a particular frame.
% % Each column of a channels matrix corresponds to a data of a particular
% % channel for for all the frames.
% % Motion data of a a joint may consists of one or more channels
% % depending on DOF of a joint.
% % ---------------------------------------------------------------------

% % This function finds the start index and end index of each joint in
% % channels' matrix. If a joint has no channel data then its start index
% % and end index are -1. For example, if 
% % startendAry(3,1)=7  
% % startendAry(3,2)=9 
% % Then 3rd joint's data start at column 7 and ends at column 9 in every 
% % row of channels matrix

% % INPUT
% % skel:     skeleton hierarchy

% % OUTPUT
% % startendAry: n-by-2 array that holds start and end index of joints'
% %              data, such that,
% %              startendAry(k,1): start index of kth joint's data in channels matrix
% %              startendAry(k,2): end index of kth joint's data in channels matrix
% %              k = 1:n where n is the number of joints (as in ASF file)

function startendAry=jointindxinchannels(skel)

startendAry=[];

endVal = 0;
for i =1:length(skel.tree)
  if length(skel.tree(i).channels)>0
    startVal = endVal + 1;
    endVal = endVal + length(skel.tree(i).channels);    
    startendAry(end+1,1:2)=[startVal, endVal];
  else
    startendAry(end+1,1:2)=[-1, -1];
  end
end


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
