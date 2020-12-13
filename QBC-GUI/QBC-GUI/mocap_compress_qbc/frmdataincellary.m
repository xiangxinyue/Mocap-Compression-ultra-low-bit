% % See also readjointnamesfromamcfile.m to know how joint names are
% % extracted from amc file

% % Load specified frame data of all joints in the cell array

% % INPUT 
% % channels: channel data of all joints
% % skel:     skeleton hierarchy
% % fno: frame no whose data is to be extracted
% % jnameCellAry: Cell Array of joints names

% % OUTPUT
% % frmdataCellAry: data of all joints of specified frame in the cell array

% % frmdataCellAry{k} gives you data of kth joint. The index k is based on names 
% % specified in input jnameCellAry

function frmdataCellAry=frmdataincellary(channels,skel,fno,jnameCellAry)

for k=1:length(jnameCellAry)
    %%k, jnameCellAry(k)
    id=findidbyjointname(skel,jnameCellAry(k)); %joint id
    mat=getjointdataofaframefromchannelmat(channels,skel,id,fno); %joint data
    frmdataCellAry(k,1)=cellstr(num2str(mat));
end

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