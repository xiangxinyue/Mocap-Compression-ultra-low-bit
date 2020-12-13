% % Wrtie the contents of cell array in a file such that
% % cellAry{k} is written in the kth line of the file

% % INPUT
% % fname: file name
% % cellAry: cell array


function writecellaryinfile(fname,cellAry)

lineCount = length(cellAry);

fid = fopen(fname,'w');

for k=1: lineCount
    fprintf(fid,'%s\n',cellAry{k});
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

