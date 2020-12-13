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