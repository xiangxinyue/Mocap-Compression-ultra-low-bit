% % Find Quadratic Bezier Control Points of given segments
% % INPUT:
% % Mat: Input data such that Mat(k,:) holds kth point.
% %      Points can be in N-D vector space i.e. 1D, 2D,3D or ND
% % SegIndexIn: Indix with respect to Mat where points are segmented.
% % ptype: if 'u' or 'unform' then uniform parameterizaton is used , 
% %        otherwise chord-length parameterizaton is used.
% % OUTPUT
% % p0mat,p1mat,p2mat: control point matrices such that p*mat(k,:)
% %                    holds Control Points of kth Segment.   
% % tout: parameter 't' value for all segments
function [p0mat,p1mat,p2mat,tout]=findqbzcplsallseg(Mat,SegIndexIn,varargin)

%%% Default Values %%%
ptype='';
defaultValues = {ptype};
%%% Assign Valus %%%
nonemptyIdx = ~cellfun('isempty',varargin);
defaultValues(nonemptyIdx) = varargin(nonemptyIdx);
[ptype] = deal(defaultValues{:});
%%%------------------------------

tout=[];
for k=1:length(SegIndexIn)-1
    fromRow=SegIndexIn(k);
    toRow=SegIndexIn(k+1);
    size(Mat(fromRow:toRow,:));
    if (strcmpi(ptype,'u') || strcmpi(ptype,'uniform') )
        [p0,p1,p2,t]= finquadbeziercpls(Mat(fromRow:toRow,:),'u'); %uniform parameterization
    else
        [p0,p1,p2,t]= finquadbeziercpls(Mat(fromRow:toRow,:));    %chord-length parameterization
    end   
    p0mat(k,:)=p0; 
    p1mat(k,:)=p1;
    p2mat(k,:)=p2;
    tout=horzcat(tout,t);
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

