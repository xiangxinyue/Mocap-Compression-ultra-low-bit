% % Find the depth of all joints in skel

% % INPUT
% % skel: mocap data in skel structure

% % OUTPUT
% % dAry: 1-D array of size n-by-1 to hold the depth of all n joints

function dAry=jointdepthall(skel)

jointCount=length(skel.tree);

for i=1:jointCount
    dAry(i)=jointdepth(skel,i); 
end

dAry=dAry';

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
