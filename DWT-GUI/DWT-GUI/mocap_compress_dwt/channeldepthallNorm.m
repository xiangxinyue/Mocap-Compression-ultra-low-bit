% % Find the normalized (between 0 and 1) depth of all channels in skel

% % INPUT
% % skel: mocap data in skel structure

% % OUTPUT
% % dAryNormChannel: 1-D array of normalized the depth of all the channels

function dAryNormChannel=channeldepthallNorm(skel)

dAryNormJoint=jointdepthallNorm(skel);

% % a joint has one or more channel, get indices of channels
startendAry=jointindxinchannels(skel);

[jointCount, tmp]=size(startendAry);
for p = 1: jointCount
    if startendAry(p,1)~=-1 % no data, if startendAry(p,1)==-1
        dAryNormChannel(startendAry(p,1):startendAry(p,2)) = dAryNormJoint(p);
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

