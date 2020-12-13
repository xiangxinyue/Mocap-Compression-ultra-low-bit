% % July 2016
% % This function decode the MoCAp compressed data

% % INPUT
% % stru: MATLAB struct array to store DWT encoded data
% % lxd: bookkeeping vector 
% % cxdLength:

% % OUTPUT
% % channelsAprx: Approximated channel data

function [channelsAprx] = decode_mocap_dwt(stru,lxd,cxdLength,wtyp)

% % -----------------------------------------------------
% % if wtyp variable is empty then assign defualt type to it
if isempty(wtyp)
     wtyp='db3';  % default type of wtyp varaible
end
% % -----------------------------------------------------
for i=1:length(stru)
    % % Extract coefficents
    cxdRL=stru(i).cxdRL;
    RUNS=stru(i).RUNS;
    zrc=stru(i).zrc;
    % % Run-length decoding
    cxd=rlj2k_dc(cxdLength,cxdRL,RUNS,zrc);
    xAprx = waverec(cxd,lxd,wtyp); %reconstructed 1D signal
    xAprx=xAprx'; %transpose to colum vector of size N-by-1
    channelsAprx(:, i)=xAprx;
end

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




