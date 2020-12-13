% % See also readjointnamesfromamcfile.m (for reading channels names from amc file)
% % extracted from amc file


% % INPUT
% % fname: name of output file
% % channels: channel data of all joints
% % skel:     skeleton hierarchy
% % jnameCellAry: Cell Array of joints names
% % snM: An array that holds matching ids of ACM and ASF file

function writechannels2amcfile(fname,channels,skel,snM)

[frameCount TMP]=size(channels);

fid = fopen(fname,'w');

fprintf(fid,'%s\n',':FULLY-SPECIFIED'); %write keyword ":FULLY-SPECIFIED"
fprintf(fid,'%s\n',':DEGREES');         %write keyword ":DEGREES"
for j=1:frameCount
    fprintf(fid,'%d\n',j);              %write frame number
    for k=1:length(snM)        
        jdata = getjointdataofaframe(channels,skel,snM(k),j);
        fprintf(fid,'%s ',skel.tree(snM(k)).name); %write joint name        
        fprintf(fid,'%g ',jdata);                  %write joint data
        fprintf(fid,'\n');                         %new line
    end
end

fclose(fid);

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