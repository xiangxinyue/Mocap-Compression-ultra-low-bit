% % getJointsNamesFromAmcFile.m
% % read names of joints from .amc file 

% % Assumption: 
% % 1. All joints names are b/w lines that has frame number 1 and 2 exclusive.
% % 2. Joint name is the first token in the line
% % 3. Joint names begins with a letter (not with digit)

% % File Syntax:
% % ...
% % :DEGREES
% % 1
% % jointname_1 numeric_data ...
% % jointname_2 numeric_data ...
% % ....
% % jointname_n numeric_data ...
% % 2
% % ....

% % INPUT
% % fn: file name e.g. fn='C:\RD\CMU\all_asfamc\subjects\09\09_01.amc'

% % OUTPUT
% % charAry: character array that contains joints names
% % cellAry: cell array that contains joints names

function [charAry, cellAry]=getJointsNamesFromAmcFile(fn)

% disp('8-Aug-2016: getJointsNamesFromAmcFile.m');
% disp('native2unicode is removed (commented) from this function');

count=0;
found=0;
fid = fopen(fn,'r');
while feof(fid) == 0
line = fgetl(fid); % read and return line, discard newline character, return -1 for eof
% if strncmp(line,':DEGREES',8)
  if strcmp(line,':DEGREES')
     found=1;
     count=count+1;
     break; 
  end
  count=count+1;
end

k=0;
if(found)
    framenoline = fgetl(fid); %read 1: indicator of first frame data
    charAry = [];
    while ~strncmp(line,'2',1) %read 2: indicator of second frame
        k=k+1;        
        %line = native2unicode(fgetl(fid)); %native2unicode is very slow
        line = fgetl(fid); 
        line = strtok(line); %first token of line is joint name
        charAry = strvcat(charAry,line);
    end
    charAry(end,:)=[]; %% remove 2 (last line from char array
    cellAry = cellstr(charAry); % converts a character array into a cell array of strings
end

fclose(fid);


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

