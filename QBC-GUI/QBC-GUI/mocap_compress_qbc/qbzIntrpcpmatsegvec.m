% % Quadratic Bezier interpolation of control points based on
% % segmentation values of NVec and parameter values in vector ti.

% % INPUT:
% % Three matricies of contol points i.e. p0mat,p1mat and p2mat.
% % e.g. p0mat(k,:) contains  p0 of kth segment [e.g. for first segment p0mat(1,1:3)=(x0,y0,z0) ]
% % Similarly p1mat(k,:) contains  p1(x,y,z...) of kth segment
% % NVec: index vector where control points are segmented.    
% % ti: parametric values 0 to 1 for each segment. Number of values for kth
% %     segment equals to NVec(k+1)-NVec(k)+1. (Optional)
% % OUTPUT :
% % MatGlobalInterp : bezier interpolated values 

% % Example call with all arguments.
% %[MatGlobalInterp]=qbzIntrpcpmatsegvec(p0mat,p1mat,p2mat,p3mat,NVec,ti)

function [MatGlobalInterp]=qbzIntrpcpmatsegvec(p0mat,p1mat,p2mat,NVec,varargin)

% % % Default Values
ti=[];
defaultValues = {ti};
% % % Assign Valus
nonemptyIdx = ~cellfun('isempty',varargin);
defaultValues(nonemptyIdx) = varargin(nonemptyIdx);
[ti] = deal(defaultValues{:});
% % ---------------------------------------------------------

niarg = nargin; %number of input arguments

MatGlobalInterp=[];
to=0;
firstSegment=1;
for k=1:length(NVec)-1   
    count=NVec(k+1)-NVec(k)+1;
    if(niarg==6)            % if ti is passsed as argument
        from=to+1;
        to  = from+count-1;
        tloc=ti(from:to);   % extracting local t from ti for kth segment 
        
    else                    % ti is not passed, using uniform parameterization
        tloc=linspace(0,1,count);        
    end
    
    %% for two adjacent segments s1 & s2, paremetric value at t=1 for s1
    %% equals t=0 for s2. Therefore no need to evaluate it. Removing t=0 
    %% from tloc from the second segment onwards.
    if (~firstSegment)
        tloc=tloc(2:end);
    end  
    
    MatLocalInterp=quadbezierintrp( p0mat(k,:),p1mat(k,:),p2mat(k,:),tloc);    
    MatGlobalInterp=[MatGlobalInterp; MatLocalInterp]; % row wise concatenation
    firstSegment=0;
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

