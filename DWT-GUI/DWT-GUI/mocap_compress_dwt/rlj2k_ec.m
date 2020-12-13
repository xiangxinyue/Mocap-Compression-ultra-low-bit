% % Run-length encoding as done in im2jpeg2k of DIPUM with following
% % modifications
% % 1. Length of run can be pass as input (defualt is 10)

% % INPUT
% % c: data to be run-length encoded
% % LR: run greater than LR are run-length encoded
% % OUTPUT
% % c: run-length encoded output data. 
% %    A Run is identified by symbol zrc, following by index of vector
% %    RUNS that holds count of run.
% % RUNS: vector that holds count of runs
% % zrc: symbol that identifies a run in ouput c

function [c,RUNS,zrc,LR]=rlj2k_ec(c,varargin)

% % % Default Values 
LR=10;
defaultValues = {LR};
% % % Assign Valus
nonemptyIdx = ~cellfun('isempty',varargin);
defaultValues(nonemptyIdx) = varargin(nonemptyIdx);
[LR] = deal(defaultValues{:});
% % %----------------------------------------

global RUNS
% % Runlength code zero runs of more than 10.
% % a special code for 0 runs ('zrc') and end-of-code ('eoc') and
% % making a run-length table.
zrc=min(c(:))-1;
eoc=zrc-1;
RUNS=[65535];

% % Find the run transiton points: 'plus' contains the index of the
% % start of a zero run; the corresponding 'minus' is its end+1.
z=c==0;
z=z-[0 z(1:end-1)];
plus=find(z==1);
minus=find(z==-1);


% % Remove any terminating zero run frm 'c'.
if length(plus)~=length(minus)
    c(plus(end):end)=[];
    c=[c eoc];
end

% % Remove all other zero runs (based on 'plus' and 'minus') from 'c'.
for i=length(minus):-1:1
    run=minus(i)-plus(i);
    if run>LR
%         disp('run>LR');
        ovrflo=floor(run/65535);
        run=run-ovrflo*65535;
        c=[c(1:plus(i)-1) repmat([zrc 1], 1, ovrflo) zrc ...
           runcode(run) c(minus(i):end)];
    end
end
zrc=-zrc;
% % ------------------------------
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

