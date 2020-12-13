% There are two matrices mat1 & mat2
% One can think each row of Mat as [w, x, y, z,....] i.e. each row have one
% point P=(w,x,y,z....) then mat1 and mat2 format is like following
%                               [P1;
%                                P2;
%                                P3;
%                                P4;
%                                ...
%                                PN];
% Points are segmented at indices stored in vector segIndex.
% For each segment this function finds maxium square distance and its
% corresponding golobal index (i.e. w.r.t mat1 rows (or mat2 same)).
% The algorithms is based on euclidean distance 

function [sqDistAry,indexAryGlobal]=MaxSqDistAndInd4EachSegbw2Mat(mat1,mat2,segIndex)

sqDistAry=[];
indexAryGlobal=[];

for k=1:length(segIndex)-1    
    mat1Seg=mat1(segIndex(k):segIndex(k+1),:);
    mat2Seg=mat2(segIndex(k):segIndex(k+1),:);
    [squaredmaxLocal,indexLocal]=MaxSqDistAndRowIndexbw2Mat(mat1Seg,mat2Seg);
    sqDistAry(k)=squaredmaxLocal;
    indexGlobal=indexLocal+segIndex(k)-1;        
    indexAryGlobal(k)=indexGlobal;
end


% So original boundary points are stored in mat1 and interpolated boundary
% points (parametric values) are in mat2. segIndex have indices w.r.t to
% mat1 where we do segmentation of boundary (i.e. where essentially two
% corresopding points of mat1 and mat2 intersect.

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

