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
% % This is same function as getJointsNamesFromAmcFile.m.
% % Only difference change of order of output arguments.
% % The function getJointsNamesFromAmcFile.m can be used when
% % only first ouptut arugment is needed to save storage space

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
