% % INPUT
% % path1: path of file1
% % path2: path of file2

% % file1: name of file1
% % file2: name of file2
% % OUTPUT
% % bit1: size of file1 in bits
% % bit2: size of file2 in bits
% % SR: ratio of sizes of file1/file2
% % Note:
% % file1 and file2 must be in the directory 'path'

% % Example 
% % SR=sizeandratio2files('C:\RD','C:\mlfull\work','test2.lbz','test2.lbz2')


function [SR,bit1,bit2]=sizeandratio2files(path1,path2,file1,file2)

bit1=getsizeoffile(path1,file1)*8;
bit2=getsizeoffile(path2,file2)*8;

SR=bit1/bit2;

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