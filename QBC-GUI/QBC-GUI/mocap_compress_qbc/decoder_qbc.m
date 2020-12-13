% % Quadratic Bezier Curve (QBC) Decoding of Motion Capture Data
% % See also decoder_qbc.m

% % INPUT
% % startendAry:     skeleton hierarchy    
% % frameCount: number of frames
% % stru: MATLAB structure with stored values of:
% %       (1) control points (p0mat,p1mat,p2mat)
% %       (2) final break-points indices (keyframe indices) 

% % OUTPUT
% % channelsAprx: Approximated channel data of all joints


function [channelsAprx]=decoder_qbc(startendAry, frameCount, stru)

% % startendAry=jointindxinchannels(skel);

p=0;
for q=1:length(stru)
    p=p+1; 
    %% Extract control points    
    fbi=[1; stru(q).fbi; frameCount];
    k1=length(fbi)-1;
    k2=k1+1;
    p0mat=stru(q).cp(1:k1,:);        %# of p0mat=k1;
    p1mat=stru(q).cp(k2:k2+k1-1,:);  %# of p1mat=p0mat;
    p2mat=[p0mat(2:end,:) ; stru(q).cp(end,:)];
    %% Interpolation using control points
    mati=qbzIntrpcpmatsegvec(p0mat, p1mat, p2mat, fbi);

    %% skipping joints with no data in channels
    while startendAry(p,1)==-1
         p=p+1;       
    end
    %interpolated data of pth joint
    channelsAprx(:, startendAry(p,1):startendAry(p,2))=mati;
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
