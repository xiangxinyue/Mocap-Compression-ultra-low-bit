% % July 2016
% % This function encode the MoCAp compressed data

% % INPUT
% % channels:
% % skel:
% % Tg: Global Wavelet Threshold Array
% % lev: Level (scale) of wavelet decomposition
% % wtyp: Type of wavelet
% % keepapp: Approximation coefficients to be thresholded or not
% % R: Length of RUN for run-length encoding (default, R=5)
% % Q: Round cxd to Q decimal places

% % OUTPUT
% % stru: 
% %     stru(i).cxdRL=cxdRL;
% %     stru(i).RUNS=RUNS;
% %     stru(i).zrc=zrc;

function [stru, lxd, cxdLength] = encode_mocap_dwt(channels,skel,varargin)

%%% Default values of input arguments %%%
Tg = 12;           % Global Wavelet Threshold
lev = 4;           % level (scale)   (default, lev=4)
wtyp = 'db3';      % type of wavelet (default, wtyp = 'db3)
keepapp = 1;       % approximation coefficients cannot be thresholded (default, keepapp = 1)
R=5;               % length of RUN for run-length encoding (default, R=5)
Q=1;               % round cxd to fixed decimal places
defaultValues = {Tg, lev,wtyp,keepapp,R,Q};
%%% Assign Valus %%%
nonemptyIdx = ~cellfun('isempty',varargin);
defaultValues(nonemptyIdx) = varargin(nonemptyIdx);
[Tg, lev,wtyp,keepapp,R,Q] = deal(defaultValues{:});
% % -----------------------------------------------------

% % if wtyp variable is empty then assign defualt type to it
if isempty(wtyp)
    wtyp='db3';  % default type of wtyp varaible
end
% % -----------------------------------------------------
[frameCount, channelCount]=size(channels);
startendAry=jointindxinchannels(skel);
dAryNormChannel=channeldepthallNorm(skel); % norm depth of all channels

for i=1: channelCount
    %% get depth of the joint and compute wavelet threshold
    depthN=dAryNormChannel(i);  %normalized depth of ith channel
    Tl=sqrt(log2(depthN+2))*Tg; %local wavelet threshold
    
    % % do wavelet decomposition of each channel independently
    x=channels(:,i)';  %data of ith channel as row vector
    [c,l] = wavedec(x,lev,wtyp); %wavelet decomposition
    % % c: wavelet decomposition vector (coefficients without thresholding)
    % % l: bookkeeping vector (# of coefficeints of each level)
    [xd,cxd,lxd] = wdencmp('gbl',c,l,wtyp,lev,Tl,'h',keepapp); % De-noising or compression
    % % xd: wavelet approximation of x after thersholding
    % % cxd: wavelet decomposition vector after thersholding of c
    % % lxd: bookkeeping vector (same as l)    
    cxd=roundTo(cxd, Q); %% Quantization, round cxd to fixed decimal places
    
    %%Run-length Encoding of thresholded decomposition vector
    [cxdRL,RUNS,zrc,R]=rlj2k_ec(cxd,R);
    stru(i).cxdRL=cxdRL;
    stru(i).RUNS=RUNS;
    stru(i).zrc=zrc;
end
cxdLength=length(cxd);    
    
    
% % % ---------------------------------------------------------------
% % Reference:
% Murtaza Ali Khan, "Multiresolution coding of motion capture data for
% real-time multimedia applications", Multimedia Tools and Applications,
% Springer journal, First online pp 1-16, Sep. 2016.
% DOI=10.1007/s11042-016-3944-7

% % Reference BibTeX
% % @Article{Khan2016,
% % author="Khan, Murtaza Ali",
% % title="Multiresolution coding of motion capture data for real-time multimedia applications",
% % journal="Multimedia Tools and Applications",
% % year="2016",
% % pages="1--16",
% % issn="1573-7721",
% % doi="10.1007/s11042-016-3944-7",
% % url="http://dx.doi.org/10.1007/s11042-016-3944-7"
% % }
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
