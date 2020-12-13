% % Run-length Dencoding as done in jpeg2k2im of DIPUM

% % INPUT:
% % L: length of input data 
% % r: encoded data
% % runs: vector that holds count of runs
% % zrc: symbol that identifies a runs in ouput c

% % OUTPUT
% % c: decoded data

function c=rlj2k_dc(L,r,runs,zrc)


zrc=-zrc;

eoc=zrc-1;

c=[];
zi=find(r==zrc);
i=1;
for j=1:length(zi)

    c=[c r(i:zi(j)-1) zeros(1,runs(r(zi(j)+1)))];
    i=zi(j)+2;
end

zi=find(r==eoc); %undo terminating zero runs
if length(zi)==1 %or last no-zero runs.
    c=[c r(i:zi-1)];
    c=[c zeros(1,L-length(c))];
else
    c=[c r(i:end)];
end

% % % ---------------------------------------------------------------
% % Reference
% % Digital Image Processing Using MATLAB by Gonzalez, Woods and Eddins

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

