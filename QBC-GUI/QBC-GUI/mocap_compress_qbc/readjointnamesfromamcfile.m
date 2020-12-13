% % readjointnamesfromamcfile.m
% % read names of joints from .amc file 
% % see also getJointsNamesFromAmcFile.m 

% % INPUT
% % fn: file name e.g. fn='C:\RD\CMU\all_asfamc\subjects\09\09_01.amc'

% % OUTPUT
% % cellAry: cell array that contains joints names
% % charAry: character array that contains joints names
function [cellAry, charAry]=readjointnamesfromamcfile(fn)

[charAry, cellAry]=getJointsNamesFromAmcFile(fn);

% % Note:
% % This is same function as getJointsNamesFromAmcFile.m. Only difference
% % is change of order of output arguments.getJointsNamesFromAmcFile.m can
% % be used when only first ouptut arugment is needed to save storage space

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