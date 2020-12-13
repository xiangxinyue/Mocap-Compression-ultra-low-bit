% % returns size of file in bytes
% % INPUT
% % path: path of input file 
% %       e.g. path='D:\workarea\' or 'D:\workarea' ;
% % filenamewithoutpath: name of input file
% %                      e.g. filenamewithoutpath='abc.txt';
% % OUTPUT
% % bytes: size of input file in bytes
function bytes=getsizeoffile(path,filenamewithoutpath)
found=0;
bytes=0;

filelist = dir(path);
L=size(filelist,1);
i=0;
while i<L || ~found    
    i=i+1;
%     filelist(i).name
    if(strcmp(filelist(i).name,filenamewithoutpath))
        bytes=filelist(i).bytes; 
        found=1;
    end
end

if found
    return
else
    error('given file is not found in the given path')
end

% % whos ('-file', fname) % get details of variables in the file fname

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
