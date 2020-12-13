% % find max. square distance and corresponding row index
% % b/w to two 2D arrays 'mat1' and 'mat2'. 
% % the algorithms is based on euclidean distance 
function [squaredmax,rowIndex]=MaxSqDistAndRowIndexbw2Mat(mat1,mat2)
% mat1=[x11,x12,...x1n;
%       x11,x12,...x1n; 
%       ...
%       xn1,xn2,...xnn; 

% mat2=[y11,y12,...y1n;
%       y11,y12,...y1n; 
%       ...
%       yn1,yn2,...ynn; 
% OR in brief mat1 and mat2 format is like following
%                               [P1;
%                                P2;
%                                P3;
%                                P4;
%                                ...
%                                PN];


if ~isequal(size(mat1),size(mat2))
    error('Two matrices must of of equal size');
end

% %Casting for accurate computation
mat1=double(mat1); 
mat2=double(mat2);

rowIndex=1;
squaredmax=sum( (mat1(1,:)-mat2(1,:)).^2,2 );

for k=1:size(mat1,1)
    % computing square distance b/w kth row
    SqDist=sum( (mat1(k,:)-mat2(k,:)).^2,2 )  ;
    % %  SqDist=TwoNormSqDist(mat1(k,:),mat2(k,:)); %No longer in use
    if(SqDist > squaredmax )
        squaredmax=SqDist;
        rowIndex=k;
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
