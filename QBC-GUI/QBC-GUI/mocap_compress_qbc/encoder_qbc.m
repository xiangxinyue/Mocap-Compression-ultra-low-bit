% %  Quadratic Bezier Curve (QBC) Encoding of Motion Capture Data

% % INPUT
% % skel:     skeleton hierarchy
% % channels: channel data of all joints
% % MxAllowSqD: Maximum allowed square distance b/w original and
% %             fitted data 
% % ibi: initial break-points indices
% % nPlaces: control points are rounded to nPlaces decimal values

% % OUTPUT
% % stru: MATLAB structure to store:
% %       (1) control points (p0mat,p1mat,p2mat)
% %       (2) final break-points indices (keyframe indices) 

function [stru]=encoder_qbc(skel, channels, MxAllowSqD, ibi, nPlaces)

jointCount=length(skel.tree);
startendAry=jointindxinchannels(skel);

q=0; 
for p=1: jointCount        
    if startendAry(p,1)~=-1 % no data, if startendAry(p,1)==-1
        %% Get joint data in array mat
        mat=channels(:, startendAry(p,1):startendAry(p,2));
        q=q+1;    
        %% p, size(mat), skel.tree(p).name
        [p0mat,p1mat,p2mat,fbi,MxSqD]=qbzapproxu(mat,MxAllowSqD,ibi); 

        if nPlaces > 0
            p0mat=roundTo(p0mat,nPlaces);
            p1mat=roundTo(p1mat,nPlaces);
            p2mat=roundTo(p2mat,nPlaces);
        end

        %% store CP (without duplicate points in p0mat and p2mat)
        stru(q).cp=[p0mat; p1mat; p2mat(end,:)];  

        %% store fbi (without first & last fbi (common to all fbi)
         stru(q).fbi=fbi(2:end-1);  
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
