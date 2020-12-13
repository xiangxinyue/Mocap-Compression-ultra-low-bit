% % Find the normalized (between 0 and 1) depth of all joints in skel

% % INPUT
% % skel: mocap data in skel structure

% % OUTPUT
% % dAryNorm: 1-D array of normalized the depth of all n joints

function dAryNorm=jointdepthallNorm(skel)

dAry=jointdepthall(skel);
dAryNorm=dAry/max(dAry(:));

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


