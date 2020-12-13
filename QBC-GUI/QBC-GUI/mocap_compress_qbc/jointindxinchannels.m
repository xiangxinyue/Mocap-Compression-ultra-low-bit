% % MoCap data of all the channels is stored in 2D matrix channels
% % Each row of channels matrix corresponds to a single complete frame, i.e.,
% % data of all the channels. Each column of a channels matrix corresponds
% % to a data of a channel for for all the frames. Motion data of a a joint
% % may consists of one or more channels depend on DOF of a joint.
% % 
% % This function find the start index and end index of each joint in
% % channels' matrix. If a joint has no channel data then its start index
% % and end index are -1.
% % OUTPUT
% % startendAry(k,1): start index of kth joint in channels data
% % startendAry(k,2): end index of kth joint in channels data

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