% % Find the depth of a given joint in skel

% % INPUT
% % skel: mocap data in skel structure
% % i: ith joint (i > 0) in the skel, whose depth is to be determine

% % OUTPUT
% % d: depth of joint whose index is i 

function d=jointdepth(skel,i)

if i<=0
    error('index i of joint must be greater than 0')
end

d=0;
p=skel.tree(i).parent;
while p~=0
    d=d+1;
    i=p;
    p=skel.tree(i).parent;    
end

% % % ---------------------------------------------------------------
% % General Notes:
% % The depth of a node v in a rooted tree is the length of the path from
% % the root to v. The depth of the root is 0.
% % The height of a node v is defined as the length of the longest path
% % from v to a leaf. The height of a tree is the height of its root.
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
