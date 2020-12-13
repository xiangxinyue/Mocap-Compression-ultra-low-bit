% % This function return default values of input parameters

% % OUTPUT
% % Tg     : Global Wavelet Threshold Array
% % lev    : Level (scale) of wavelet decomposition
% % wtyp   : Type of wavelet
% % keepapp: Approximation coefficients to be thresholded or not
% % R      : Length of RUN for run-length encoding (default, R=5)
% % Q      : Round cxd to Q decimal places


function [Tg, lev, wtyp, keepapp, R,Q] = default_parameters_dwt_mocap()

Tg = 12;           % Global Wavelet Threshold
lev = 4;           % level (scale)   (default, lev=4)
wtyp = 'db3';      % type of wavelet (default, wtyp = 'db3)
keepapp = 1;       % approximation coefficients cannot be thresholded (default, keepapp = 1)
R=5;               % length of RUN for run-length encoding (default, R=5)
Q=1;               % round cxd to fixed decimal places

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
