% % Approximation of data by Quadratic Bezier Curves.
% % Based on least square fit, uniform parameterization.
% % Finds Control Point of Bezier Curve that approximates
% % the given data upto specified squared distance limit.


% %INPUT
% % Mat: original data (e.g. boundary data) to be approximated
% % ibi: initial break points indices.
% %      For each point (row) in Mat ibi have its correspding
% %      index(row) in Mat.
% % MxAllowSqD: Tolerance limit b/w orginal and fitted spline.
% %           If distance  b/w original data and fitted data
% %           is greater thabn MxAllowSqD then at the
% %             point of max. sq distance segment is brokon
% % OUTPUT
% % p0mat,p1mat,p2mat: Final set of control points
% % fbi: Final break points indices (Optional). 
% % MxSqD:   Max square distance between origina data and paramteric
% %          values. MxSqD <= MxAllowSqD (Optional).
% % MatI:

% % One can think each row of Mat, p0mat,p1mat,p2mat,p3mat is like 
% % [w, x, y, z,....] i.e. each row has one point P=(w,x,y,z....)
% % so format of Mat is like following,
% %                               [P1;
% %                                P2;
% %                                P3;
% %                                ...
% %                                PN];

function [p0mat,p1mat,p2mat,fbi,MxSqD,MatI]=qbzapproxu(Mat,varargin)


%%% Default Values %%%
MxAllowSqD=1;
ibi=[1; size(Mat,1)]; % first & last
cmd='';
defaultValues = {MxAllowSqD,ibi,cmd};
%%% Assign Valus %%%
nonemptyIdx = ~cellfun('isempty',varargin);
defaultValues(nonemptyIdx) = varargin(nonemptyIdx);
[MxAllowSqD,ibi,cmd] = deal(defaultValues{:});
% % %----------------------------------------
datatype=class(Mat); %original data type 
Mat=double(Mat);     %converte to double (necessary for computation)
MxAllowSqD=double(MxAllowSqD);
% % %----------------------------------------
p0mat=[];    p1mat=[];    p2mat=[];    
MxSqD=0;
fbi=ibi;  %initially same
clear ibi;

if(MxAllowSqD<0 )
    error('Max. Allowed Square Distance should be >= 0');    
end

if( ~isvec(fbi) )
    error('arg3 must be row OR column vector');    
end
fbi=getcolvector(fbi);

fbi=[fbi; 1; size(Mat,1)]; % make sure first & last are included
fbi=unique(fbi);           % sort and remove duplicates if any 

[p0mat,p1mat,p2mat,ti]=findqbzcplsallseg(Mat,fbi,'u'); 
[MatI]=qbzIntrpcpmatsegvec(p0mat,p1mat,p2mat,fbi,ti);

[sqDistAry,indexAryGlobal]=MaxSqDistAndInd4EachSegbw2Mat(Mat,MatI, fbi);
sqDistMat=[sqDistAry',indexAryGlobal'];
%% localIndex is index of row in sqDistMat that contains MxSqD
[MxSqD, localIndex]=max(sqDistMat(:,1)); 

while(~strcmpi(cmd,'stop') & MxSqD > MxAllowSqD)        
    %% appending index of new segmentation into fbi  
    %% index w.r.t Mat where sq. dist. is max among all segments
    MxSqDInd=sqDistMat(localIndex,2); 
    fbi(length(fbi)+1)=MxSqDInd;     % append
    fbi=sort(fbi);                     % sort          
    
    %% Finding range of fbi that would be affected by adding a new
    %% point at max-square-distance postion.
    %% If kth row mataches then get atmost k-1 to k+1 rows of fbi.
    [EffinitialbreaksIndex]=FindGivenRangeMatchedMat([fbi],[1 ; MxSqDInd], 1); 
     
    %% Finding control points of two new segments (obtained by breaking a segment)  
    %% Since we are passing EffinitialbreaksIndex, findqbzcplsallseg will only take
    %% relevant segments data from Mat.
    [p0matN,p1matN,p2matN,tiN]=findqbzcplsallseg(Mat,EffinitialbreaksIndex,'u');
    
    %% Combining new and old control point values (old + new + old ).
    %% if only one row in sqDistMat (case when initially there were only two
    %% breakpoints)
    if( size(sqDistMat,1)==1 ) 
        p0mat=p0matN; p1mat=p1matN; p2mat=p2matN; 
    else 
        p0mat=[p0mat(1:localIndex-1,:); p0matN; p0mat(localIndex+1:end,:)];
        p1mat=[p1mat(1:localIndex-1,:); p1matN; p1mat(localIndex+1:end,:)];
        p2mat=[p2mat(1:localIndex-1,:); p2matN; p2mat(localIndex+1:end,:)];
    end     
    
    %%Bezier Interpolatoin to new segments  
    [MatINew]=qbzIntrpcpmatsegvec(p0matN,p1matN,p2matN,EffinitialbreaksIndex,tiN);
    
    si=EffinitialbreaksIndex(1);  %intrp. values fbi(1:si) are already computed
    ei=EffinitialbreaksIndex(end);%intrp. values fbi(ei:end,:) are already computed   
    
    %% Combining new and old interpolation values (old + new + old ).
    %% Not taking common point b/w old-new and b/w new-old
    MatI=[MatI(1:si-1,:); MatINew; MatI(ei+1:end,:)];     
    
    %% now we would find the max-square-distance of affected segments only  
    [sqDistAryN,indexAryGlobalN]=MaxSqDistAndInd4EachSegbw2Mat(...
                                 Mat,MatI, EffinitialbreaksIndex ); % new
    sqDistMatN=[sqDistAryN',indexAryGlobalN'];      % new mat

    %% if only one row in sqDistMat (case when initially there were only two
    %% breakpoints)
    if( size(sqDistMat,1)==1 ) 
        sqDistMat=sqDistMatN;
    else 
    %% combining sqDistMat new and old values (old + new + old)
        sqDistMat=[sqDistMat(1:localIndex-1,:);...
                   sqDistMatN;...
                   sqDistMat(localIndex+1:length(sqDistMat),:)]; 
    end            
    [MxSqD, localIndex]=max(sqDistMat(:,1));     
end

% % if max(p1mat(:)>255)
% %     maxV=max(p1mat(:))
% % end
% % if min(p1mat(:)<0)
% %     minV=min(p1mat(:))
% % end

% p0mat=converttoclass(p0mat,datatype); %to that of org. Mat
% p1mat=converttoclass(p1mat,datatype); 
% p2mat=converttoclass(p2mat,datatype); 

% % % % % NOTES===============
% % Alternativley combining sqDistMat new and old values 
% % can be done as follows (slightly less efficient).
%  sqDistMat(localIndex,:)=[];        % remove previous local row
%  sqDistMat=[sqDistMat;sqDistMatN];  % appending two new rows
%  sqDistMat=sortrows(sqDistMat,2)    % sort by index (seond column)



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
