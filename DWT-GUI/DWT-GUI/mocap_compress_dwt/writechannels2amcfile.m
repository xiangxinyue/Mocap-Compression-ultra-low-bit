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
